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
const PER_PAGE = 20;

// Last-resort safety net: log and keep serving rather than crashing the process
process.on('unhandledRejection', (err) => {
	console.error('Unhandled rejection:', err);
});
process.on('uncaughtException', (err) => {
	console.error('Uncaught exception:', err);
});

// Express 4 does not forward rejections from async handlers to the error middleware
const asyncHandler = (fn) => (req, res, next) => {
	fn(req, res, next).catch(next);
};

// Precompile templates
const viewsDir = path.join(__dirname, 'templates');
try {
	await Promise.all(['header', 'footer', 'index', 'post', '404'].map(async (tpl) => {
		const template = await fsPromises.readFile(path.join(viewsDir, `${tpl}.tpl`));
		const precompiled = await benchpress.precompile(template.toString(), { filename: `${tpl}.tpl` });
		await fsPromises.writeFile(path.join(viewsDir, 'build', `${tpl}.jst`), precompiled);
	}));
} catch (err) {
	console.error('Template precompilation failed:', err);
	process.exit(1);
}

// Views engine
app.engine('jst', benchpress.__express);
app.set('view engine', 'jst');
app.set('views', path.join(viewsDir, 'build'));

app.use(processRender);

// Start with an empty cache if the initial fetch fails; `check` refreshes on the first request
await get().catch((err) => {
	console.error(`Initial gist fetch failed, starting with empty cache: ${err.message}`);
});

app.get('/', check, asyncHandler(async (req, res) => {
	const gists = [];
	for (const [filename, gist] of _gists) {
		gist.url = filename.slice(0, -3);
		gists.push(gist);
	}

	gists.sort((a, b) => b.timestamp - a.timestamp);

	const totalPages = Math.max(1, Math.ceil(gists.length / PER_PAGE));
	let page = parseInt(req.query.page, 10) || 1;
	page = Math.min(Math.max(1, page), totalPages);

	res.render('index', {
		gists: gists.slice((page - 1) * PER_PAGE, page * PER_PAGE),
		page,
		totalPages,
		showPagination: totalPages > 1,
		hasPrev: page > 1,
		hasNext: page < totalPages,
		prevPage: page - 1,
		nextPage: page + 1,
	});
}));

app.get('/sitemap.xml', check, asyncHandler(async (req, res) => {
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
}));

app.get('/:title', check, asyncHandler(async (req, res, next) => {
	if (_gists.has(`${req.params.title}.md`)) {
		const gist = _gists.get(`${req.params.title}.md`);
		return res.render('post', gist);
	}

	next();
}));

app.use(asyncHandler(async (req, res) => {
	res.status(404).render('404');
}));

// Central error handler
app.use((err, req, res, next) => {
	console.error(err);
	if (res.headersSent) {
		return next(err);
	}
	res.status(500).send('Internal Server Error');
});

app.listen(port, () => {
	console.log(`Listening on port ${port}`);
}).on('error', (err) => {
	console.error('Failed to start server:', err);
	process.exit(1);
});
