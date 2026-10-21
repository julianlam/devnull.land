import fetch from 'node-fetch';
import MarkdownIt from 'markdown-it';
import { apiInit, FETCH_TIMEOUT } from './gists.js';

const md = new MarkdownIt({
	html: true,
});

const ABOUT_GIST_ID = process.env.GITHUB_ABOUT_GIST;

// At most one GitHub fetch per REFRESH_INTERVAL, shared by concurrent requests
const REFRESH_INTERVAL = 60 * 1000;
let _aboutHtml = null;
let lastFetch = 0;
let inFlight = null;

export const enabled = () => Boolean(ABOUT_GIST_ID);

export const getAbout = async () => {
	if (!ABOUT_GIST_ID) {
		throw new Error('GITHUB_ABOUT_GIST is not set');
	}

	if (_aboutHtml && Date.now() - lastFetch < REFRESH_INTERVAL) {
		return _aboutHtml;
	}

	if (inFlight) {
		return inFlight;
	}

	lastFetch = Date.now();
	inFlight = (async () => {
		const response = await fetch(`https://api.github.com/gists/${ABOUT_GIST_ID}`, apiInit());
		if (!response.ok) {
			throw new Error(`GitHub API request failed: ${response.status}`);
		}

		const gist = await response.json();
		const name = Object.keys(gist.files).find(file => file.endsWith('.md'));
		if (!name) {
			throw new Error('About gist contains no markdown file');
		}

		const rawResponse = await fetch(gist.files[name].raw_url, { signal: AbortSignal.timeout(FETCH_TIMEOUT) });
		if (!rawResponse.ok) {
			throw new Error(`Failed to fetch ${gist.files[name].raw_url}: ${rawResponse.status}`);
		}

		return md.render(await rawResponse.text());
	})().finally(() => {
		inFlight = null;
	});

	// Cache the result only on success so a failed fetch retries on the next request
	_aboutHtml = await inFlight;
	return _aboutHtml;
};
