import util from 'util';

export const processRender = (req, res, next) => {
	// res.render post-processing, shamelessly stolen from NodeBB
	const { render } = res;
	const renderAsync = util.promisify(render.bind(res));
	res.render = function renderOverride(template, options = {}, fn) {
		const self = this;
		if (typeof options === 'function') {
			fn = options;
			options = {};
		}

		return (async () => {
			const [header, content, footer] = await Promise.all(['header', template, 'footer'].map(async tpl => renderAsync(tpl, options)));

			let str;
			if (res.locals.renderHeaderFooter !== false) {
				str = `${header}${content}${footer}`;
			} else {
				str = content;
			}

			if (typeof fn !== 'function') {
				self.send(str);
			} else {
				fn(null, str);
			}
		})().catch((err) => {
			if (typeof fn === 'function') {
				fn(err);
			} else {
				console.error(`Render error for ${template}: ${err.message}`);
				self.status(500).send('Internal Server Error');
			}
		});
	};

	next();
};

export default { processRender };
