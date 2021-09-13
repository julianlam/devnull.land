'use strict';

import fetch from 'node-fetch';
import express from 'express';

const app = express();
const port = 3000;

app.get('/', async (req, res) => {
	let gists = await fetch('https://api.github.com/users/julianlam/gists');
	gists = await gists.json();
	console.log(gists);
	res.sendStatus(200);
});

app.listen(port, () => {
	console.log(`Listening on port ${port}`);
});
