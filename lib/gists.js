import fetch from 'node-fetch';
import MarkdownIt from 'markdown-it';

const md = new MarkdownIt({
	html: true,
});

export const _gists = new Map();
let _gistsETag;

export const get = async () => {
	let gists = await fetch('https://api.github.com/users/julianlam/gists');
	_gistsETag = gists.headers.get('etag');
	gists = await gists.json();

	// Filter out non-blog gists
	gists = gists.filter(gist => gist.description.indexOf('#blog') !== -1);

	_gists.clear();
	await Promise.all(gists.map(async (gist) => {
		const name = Object.keys(gist.files).pop();
		const markdown = await (await fetch(gist.files[name].raw_url)).text();
		const when = new Date(gist.created_at);
		_gists.set(name, {
			name,
			markdown,
			html: md.render(markdown),
			title: gist.description,
			created_at: gist.created_at,
			timestamp: when.getTime(),
			dateString: when.toLocaleString(),
		});
	}));
};

export const check = async (req, res, next) => {
	const response = await fetch('https://api.github.com/users/julianlam/gists', {
		method: 'head',
	});
	const etag = response.headers.get('etag');

	if (etag !== _gistsETag) {
		await get();
	}

	next();
};

