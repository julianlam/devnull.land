/* globals import */

import express from 'express';
import benchpress from 'benchpressjs';
import path, { dirname } from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';
import { _gists, check, get } from './lib/gists.js';
import middleware from './lib/middleware.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const fsPromises = fs.promises;

const app = express();
const port = 3000;

// Precompile templates
const viewsDir = path.join(__dirname, 'templates');
['header', 'footer', 'index', 'post'].forEach(async (tpl) => {
	const template = await fsPromises.readFile(path.join(viewsDir, `${tpl}.tpl`));
	const precompiled = await benchpress.precompile(template.toString(), { filename: `${tpl}.tpl` });
	await fsPromises.writeFile(path.join(viewsDir, 'build', `${tpl}.jst`), precompiled);
});

// Views engine
app.engine('jst', benchpress.__express);
app.set('view engine', 'jst');
app.set('views', path.join(viewsDir, 'build'));

app.use(middleware.processRender);
app.use('/milligram', express.static('node_modules/milligram/dist'));

await get();

app.get('/', check, async (req, res) => {
	const gists = [];
	for (const [filename, gist] of _gists) {
		gist.url = filename.slice(0, -3);
		gist.title = gist.title.replace('#blog', '');
		gists.push(gist);
	}

	gists.sort((a, b) => b.timestamp - a.timestamp);

	res.render('index', { gists });
});

app.get('/:title', check, async (req, res) => {
	const gist = _gists.get(`${req.params.title}.md`);
	res.render('post', gist);
});

app.listen(port, () => {
	console.log(`Listening on port ${port}`);
});
