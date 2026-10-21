import nodebb from 'eslint-config-nodebb';

export default [
	{
		ignores: ['.tools/'],
	},
	...nodebb,
	{
		files: ['**/*.js'],
		languageOptions: {
			// the app is ESM (top-level await needs a newer ecmaVersion than the config default)
			ecmaVersion: 'latest',
			sourceType: 'module',
		},
	},
];
