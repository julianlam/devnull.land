import fetch from 'node-fetch';
import MarkdownIt from 'markdown-it';

const md = new MarkdownIt({
	html: true,
});

async function getHTML(url) {
	const markdown = await (await fetch(url)).text();
	return md.render(markdown);
}

async function getMetadata(url) {
	return (await fetch(url)).json();
}

export const _gists = new Map();
let _gistsETag;

export const get = async () => {
	let gists = [];
	let _currentSet = null;
	let _currentPage = 1;
	while (_currentSet === null || (Array.isArray(_currentSet) && _currentSet.length)) {
		// eslint-disable-next-line no-await-in-loop
		_currentSet = await fetch(`https://api.github.com/users/${process.env.GITHUB_USERNAME || 'julianlam'}/gists?per_page=100&page=${_currentPage}`);

		if (_currentPage === 1) {
			_gistsETag = _currentSet.headers.get('etag');
		}

		// eslint-disable-next-line no-await-in-loop
		_currentSet = await _currentSet.json();
		gists = gists.concat(_currentSet);

		_currentPage += 1;
	}

	// Filter out non-blog gists
	gists = gists.filter(gist => gist.description.indexOf('#blog') !== -1);

	_gists.clear();
	gists = await Promise.all(gists.map(async (gist) => {
		gist.name = Object.keys(gist.files).find(name => name !== 'meta.json');
		gist.html = await getHTML(gist.files[gist.name].raw_url);
		gist.metadata = gist.files['meta.json'] ? await getMetadata(gist.files['meta.json'].raw_url) : {};
		return gist;
	}));

	gists.forEach((gist) => {
		const { name, html, metadata } = gist;
		const when = new Date(parseInt(metadata.timestamp, 10) || gist.created_at);

		if (when > Date.now()) {
			return;
		}

		_gists.set(name, {
			name,
			html,
			title: gist.description.replace('#blog', ''),
			created_at: gist.created_at,
			timestamp: when.getTime(),
			dateString: when.toLocaleString(),
		});
	});
};

export const check = async (req, res, next) => {
	const response = await fetch(`https://api.github.com/users/${process.env.GITHUB_USERNAME || 'julianlam'}/gists`, {
		method: 'head',
	});
	const etag = response.headers.get('etag');

	if (etag !== _gistsETag) {
		await get();
	}

	next();
};

