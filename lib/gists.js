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
	let gists = await fetch(`https://api.github.com/users/${process.env.GITHUB_USERNAME || 'julianlam'}/gists`);
	_gistsETag = gists.headers.get('etag');
	gists = await gists.json();

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

