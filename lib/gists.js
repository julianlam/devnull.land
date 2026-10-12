import fetch from 'node-fetch';
import MarkdownIt from 'markdown-it';

const md = new MarkdownIt({
	html: true,
});

const FETCH_TIMEOUT = 10000;

async function getHTML(url) {
	const response = await fetch(url, { signal: AbortSignal.timeout(FETCH_TIMEOUT) });
	if (!response.ok) {
		throw new Error(`Failed to fetch ${url}: ${response.status}`);
	}
	const markdown = await response.text();
	return md.render(markdown);
}

async function getMetadata(url) {
	const response = await fetch(url, { signal: AbortSignal.timeout(FETCH_TIMEOUT) });
	if (!response.ok) {
		throw new Error(`Failed to fetch ${url}: ${response.status}`);
	}
	return response.json();
}

export const _gists = new Map();
let _gistsETag;

export const get = async () => {
	let gists = [];
	let _currentSet = null;
	let _currentPage = 1;
	while (_currentSet === null || (Array.isArray(_currentSet) && _currentSet.length)) {
		// eslint-disable-next-line no-await-in-loop
		const response = await fetch(`https://api.github.com/users/${process.env.GITHUB_USERNAME || 'julianlam'}/gists?per_page=100&page=${_currentPage}`, { signal: AbortSignal.timeout(FETCH_TIMEOUT) });
		if (!response.ok) {
			throw new Error(`GitHub API request failed: ${response.status}`);
		}

		if (_currentPage === 1) {
			_gistsETag = response.headers.get('etag');
		}

		// eslint-disable-next-line no-await-in-loop
		_currentSet = await response.json();
		gists = gists.concat(_currentSet);

		_currentPage += 1;
	}

	// Filter out non-blog gists
	gists = gists.filter(gist => (gist.description || '').indexOf('#blog') !== -1);

	gists = await Promise.all(gists.map(async (gist) => {
		gist.name = Object.keys(gist.files).find(name => name !== 'meta.json');
		if (!gist.name) {
			return null;
		}

		try {
			gist.html = await getHTML(gist.files[gist.name].raw_url);
			gist.metadata = gist.files['meta.json'] ? await getMetadata(gist.files['meta.json'].raw_url) : {};
		} catch (err) {
			console.error(`Skipping gist ${gist.id}: ${err.message}`);
			return null;
		}

		return gist;
	}));
	gists = gists.filter(Boolean);

	// Build the new set first so a failed refresh above leaves the old cache intact
	const next = new Map();
	gists.forEach((gist) => {
		const { name, html, metadata } = gist;
		const when = new Date(parseInt(metadata.timestamp, 10) || gist.created_at);

		if (when > Date.now()) {
			return;
		}

		next.set(name, {
			name,
			html,
			gist_url: gist.html_url,
			comments: gist.comments,
			title: (gist.description || '').replace('#blog', ''),
			created_at: gist.created_at,
			timestamp: when.getTime(),
			dateString: when.toLocaleString(),
		});
	});
	_gists.clear();
	next.forEach((value, key) => _gists.set(key, value));
};

export const check = async (req, res, next) => {
	try {
		const response = await fetch(`https://api.github.com/users/${process.env.GITHUB_USERNAME || 'julianlam'}/gists`, {
			method: 'head',
			signal: AbortSignal.timeout(FETCH_TIMEOUT),
		});

		if (response.ok) {
			const etag = response.headers.get('etag');

			if (etag !== _gistsETag) {
				await get();
			}
		} else {
			console.warn(`GitHub API check failed (${response.status}), serving cached gists`);
		}
	} catch (err) {
		console.warn(`Gist refresh failed, serving cached gists: ${err.message}`);
	}

	next();
};
