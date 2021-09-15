/* globals import */

import fetch from 'node-fetch';
import express from 'express';
import benchpress from 'benchpressjs';
import path, { dirname } from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const fsPromises = fs.promises;

const app = express();
const port = 3000;

// Precompile templates
const viewsDir = path.join(__dirname, 'templates');
['index', 'post'].forEach(async (tpl) => {
	const template = await fsPromises.readFile(path.join(viewsDir, `${tpl}.tpl`));
	const precompiled = await benchpress.precompile(template.toString(), { filename: `${tpl}.tpl` });
	await fsPromises.writeFile(path.join(viewsDir, 'build', `${tpl}.jst`), precompiled);
});

// Views engine
app.engine('jst', benchpress.__express);
app.set('view engine', 'jst');
app.set('views', path.join(viewsDir, 'build'));

// TODO: Move this to a separate lib
const _gists = new Map();
let _gistsETag;
const refreshGists = async () => {
	let gists = await fetch('https://api.github.com/users/julianlam/gists');
	_gistsETag = gists.headers.get('etag');
	gists = await gists.json();

	// Filter out non-blog gists
	gists = gists.filter(gist => gist.description.indexOf('#blog') !== -1);

	_gists.clear();
	await Promise.all(gists.map(async (gist) => {
		const name = Object.keys(gist.files).pop();
		const markdown = await (await fetch(gist.files[name].raw_url)).text();
		_gists.set(name, {
			name,
			markdown,
			title: gist.description,
			created_at: gist.created_at,
			timestamp: new Date(gist.created_at).getTime(),
		});
	}));
};
const checkGists = async (req, res, next) => {
	const response = await fetch('https://api.github.com/users/julianlam/gists', {
		method: 'head',
	});
	const etag = response.headers.get('etag');

	if (etag !== _gistsETag) {
		await refreshGists();
	}

	next();
};

await refreshGists();

app.get('/', checkGists, async (req, res) => {
	const gists = [];
	for (const [filename, gist] of _gists) {
		gist.url = filename.slice(0, -3);
		gist.title = gist.title.replace('#blog', '');
		gists.push(gist);
	}

	res.render('index', { gists });
});

app.get('/:title', checkGists, async (req, res) => {
	const gist = _gists.get(`${req.params.title}.md`);
	res.render('post', gist);
});

app.listen(port, () => {
	console.log(`Listening on port ${port}`);
});
