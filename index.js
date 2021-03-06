/* globals import */

import express from 'express';
import benchpress from 'benchpressjs';
import path, { dirname } from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';
import { SitemapStream, streamToPromise } from 'sitemap';
import { Readable } from 'stream';

import { _gists, check, get } from './lib/gists.js';
import { processRender } from './lib/middleware.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const fsPromises = fs.promises;

const app = express();
const port = 3000;

// Precompile templates
const viewsDir = path.join(__dirname, 'templates');
['header', 'footer', 'index', 'post', '404'].forEach(async (tpl) => {
	const template = await fsPromises.readFile(path.join(viewsDir, `${tpl}.tpl`));
	const precompiled = await benchpress.precompile(template.toString(), { filename: `${tpl}.tpl` });
	await fsPromises.writeFile(path.join(viewsDir, 'build', `${tpl}.jst`), precompiled);
});

// Views engine
app.engine('jst', benchpress.__express);
app.set('view engine', 'jst');
app.set('views', path.join(viewsDir, 'build'));

app.use(processRender);
app.use('/milligram', express.static('node_modules/milligram/dist'));

await get();

app.get('/', check, async (req, res) => {
	const gists = [];
	for (const [filename, gist] of _gists) {
		gist.url = filename.slice(0, -3);
		gists.push(gist);
	}

	gists.sort((a, b) => b.timestamp - a.timestamp);

	res.render('index', { gists });
});

app.get('/sitemap.xml', check, async (req, res) => {
	const gists = [];
	for (const [filename, gist] of _gists) {
		gist.url = filename.slice(0, -3);
		gists.push(gist);
	}

	const links = gists.map((gist) => {
		return {
			url: `/${gist.name.slice(0, -3)}`,
			changefreq: 'monthly',
			priority: 0.75,
		}
	});
	links.unshift({
		url: '/',
		changefreq: 'weekly',
		priority: 1,
	});

	// Create a stream to write to
	const stream = new SitemapStream( { hostname: process.env.BASE_URL || 'https://devnull.land' } )

	// Return a promise that resolves with your XML string
	const xml = (await streamToPromise(Readable.from(links).pipe(stream))).toString();

	res.type('xml').send(xml);
});

app.get('/:title', check, async (req, res, next) => {
	if (_gists.has(`${req.params.title}.md`)) {
		const gist = _gists.get(`${req.params.title}.md`);
		return res.render('post', gist);
	}

	next();
});

app.use((req, res, next) => {
	res.status(404).render('404');
});

app.listen(port, () => {
	console.log(`Listening on port ${port}`);
});
