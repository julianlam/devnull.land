<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>{{{ if title }}}{./title}{{{ else }}}Home{{{ end }}} | devnull.land</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Miscellaneous bits and bobs from the tech world">
	<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' shape-rendering='crispEdges'%3E%3Crect width='16' height='16' fill='%235c3a00'/%3E%3Crect x='1' y='1' width='14' height='14' fill='%23fa9f15'/%3E%3Crect x='2' y='2' width='2' height='2' fill='%23fff'/%3E%3Crect x='12' y='2' width='2' height='2' fill='%23fff'/%3E%3Crect x='2' y='12' width='2' height='2' fill='%23fff'/%3E%3Crect x='12' y='12' width='2' height='2' fill='%23fff'/%3E%3Crect x='6' y='4' width='4' height='1' fill='%23fff'/%3E%3Crect x='5' y='5' width='1' height='2' fill='%23fff'/%3E%3Crect x='10' y='5' width='1' height='1' fill='%23fff'/%3E%3Crect x='8' y='7' width='1' height='2' fill='%23fff'/%3E%3Crect x='8' y='10' width='1' height='2' fill='%23fff'/%3E%3C/svg%3E">
	<link rel="sitemap" href="/sitemap.xml" type="application/xml">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
	<style>
		:root {
			--sky: #5c94fc;
			--ink: #24292f;
			--muted: #57606a;
			--paper: #ffffff;
			--paper-soft: #f6f8fa;
			--line: #d0d7de;
			--accent: #e1573f;
			--code-bg: #f6f8fa;
			--code-line: #d0d7de;
			--code-ink: #24292f;
			--pixel-font: 'Press Start 2P', 'Courier New', monospace;
			--body-font: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
			--content-width: 46rem;
		}

		@media (prefers-color-scheme: dark) {
			:root {
				--ink: #e6edf3;
				--muted: #8d96a0;
				--paper: #0d1117;
				--paper-soft: #161b22;
				--line: #30363d;
				--accent: #ff7b5f;
				--code-bg: #161b22;
				--code-line: #30363d;
				--code-ink: #e6edf3;
			}
		}

		* { box-sizing: border-box; }

		html { -webkit-text-size-adjust: 100%; }

		body {
			margin: 0;
			font-family: var(--body-font);
			font-size: 1.0625rem;
			line-height: 1.7;
			color: var(--ink);
			background: var(--paper);
		}

		/* ---------- Pixel banner ---------- */

		.banner {
			display: block;
			width: 100%;
			height: auto;
			max-height: 320px;
			background: var(--sky);
		}

		/* mobile is portrait-dominant: a taller header is fine, and slice crops the sides */
		@media (max-width: 767px) {
			.banner { height: 300px; }
		}

		.banner a { text-decoration: none; }

		.banner .title {
			font-family: var(--pixel-font);
			font-size: 20px;
			letter-spacing: 1px;
		}

		.banner .tagline {
			font-family: var(--pixel-font);
			font-size: 7px;
			letter-spacing: 1px;
		}

		/* ---------- Layout ---------- */

		.wrap {
			max-width: var(--content-width);
			margin: 0 auto;
			padding: 2rem 1.25rem 4rem;
		}

		/* ---------- Index ---------- */

		.post-list {
			list-style: none;
			margin: 0;
			padding: 0;
		}

		.post-list li {
			display: grid;
			grid-template-columns: 1fr auto;
			align-items: baseline;
			column-gap: 1rem;
			row-gap: 0.25rem;
			padding: 1rem 0;
			border-bottom: 1px solid var(--line);
		}

		.post-list li:first-child { padding-top: 0; }

		.post-list a {
			font-size: 1.25rem;
			font-weight: 600;
			line-height: 1.4;
			color: var(--ink);
			text-decoration: none;
		}

		.post-list a:hover,
		.post-list a:focus {
			color: var(--accent);
			text-decoration: underline;
		}

		.post-list .meta {
			display: block;
			text-align: right;
			white-space: nowrap;
			font-size: 0.875rem;
			color: var(--muted);
		}

		.post-list .comments {
			font-size: 0.875rem;
			font-weight: 600;
			text-decoration: none;
		}

		.post-list .comments:hover,
		.post-list .comments:focus {
			color: var(--accent);
			text-decoration: underline;
		}

		.pagination {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-top: 2rem;
			padding-top: 1.25rem;
			border-top: 1px solid var(--line);
			font-size: 0.9375rem;
		}

		.pagination a {
			color: var(--accent);
			text-decoration: none;
			font-weight: 600;
		}

		.pagination a:hover,
		.pagination a:focus {
			text-decoration: underline;
		}

		.pagination .side { flex: 1; }

		.pagination .side:last-child { text-align: right; }

		.pagination .page-indicator { color: var(--muted); flex-shrink: 0; }

		/* ---------- Posts ---------- */

		.post { font-size: 1.125rem; }

		.post-header {
			margin-bottom: 2rem;
			padding-bottom: 1.5rem;
			border-bottom: 4px solid var(--line);
		}

		.post-header h1 {
			margin: 0 0 0.5rem;
			font-size: 2rem;
			line-height: 1.25;
			overflow-wrap: break-word;
		}

		.post-header .meta {
			margin: 0;
			font-size: 0.9375rem;
			color: var(--muted);
		}

		.post-header .meta a { color: var(--muted); }

		.post-header .meta a:hover,
		.post-header .meta a:focus { color: var(--accent); }

		.post h2,
		.post h3,
		.post h4 {
			line-height: 1.3;
			margin: 2.25rem 0 1rem;
			overflow-wrap: break-word;
		}

		.post h2 { font-size: 1.5rem; }
		.post h3 { font-size: 1.25rem; }

		.post p { margin: 0 0 1.25rem; }

		.post a {
			color: var(--accent);
			text-underline-offset: 2px;
		}

		.post a:hover,
		.post a:focus { color: var(--ink); }

		.post ul,
		.post ol {
			padding-left: 1.5rem;
			margin: 0 0 1.25rem;
		}

		.post li { margin: 0.375rem 0; }

		.post blockquote {
			margin: 1.5rem 0;
			padding: 0.5rem 1.25rem;
			border-left: 4px solid var(--accent);
			background: var(--paper-soft);
			color: var(--muted);
		}

		.post blockquote p { margin: 0.5rem 0; }

		.post code {
			font-family: ui-monospace, SFMono-Regular, 'SF Mono', Menlo, Consolas, 'Liberation Mono', monospace;
			font-size: 0.875em;
			background: var(--code-bg);
			border: 1px solid var(--code-line);
			border-radius: 4px;
			padding: 0.1em 0.35em;
		}

		.post pre {
			background: var(--code-bg);
			border: 1px solid var(--code-line);
			border-radius: 6px;
			padding: 1rem;
			overflow-x: auto;
			line-height: 1.5;
			margin: 0 0 1.5rem;
		}

		.post pre code {
			background: none;
			border: none;
			padding: 0;
			font-size: 0.875rem;
			color: var(--code-ink);
		}

		.post img,
		.post video {
			max-width: 100%;
			height: auto;
			border-radius: 6px;
		}

		.post table {
			border-collapse: collapse;
			width: 100%;
			margin: 0 0 1.5rem;
			font-size: 0.9375rem;
			display: block;
			overflow-x: auto;
		}

		.post th,
		.post td {
			border: 1px solid var(--line);
			padding: 0.5rem 0.75rem;
			text-align: left;
		}

		.post th { background: var(--paper-soft); }

		.post hr {
			border: none;
			border-top: 4px solid var(--line);
			margin: 2.5rem 0;
		}

		/* ---------- Footer ---------- */

		.site-footer {
			border-top: 4px solid var(--line);
			padding: 1.5rem 1.25rem 3rem;
			text-align: center;
			font-size: 0.875rem;
			color: var(--muted);
		}

		.site-footer a { color: var(--muted); }

		.site-footer a:hover,
		.site-footer a:focus { color: var(--accent); }

		/* ---------- 404 ---------- */

		.error-page {
			text-align: center;
			padding-top: 3rem;
		}

		.error-page .game-over {
			font-family: var(--pixel-font);
			font-size: 1.5rem;
			margin: 0 0 1.5rem;
		}

		.error-page p { color: var(--muted); }
		.error-page a { color: var(--accent); }

		@media (max-width: 480px) {
			.post-header h1 { font-size: 1.625rem; }
		}

		@media (prefers-reduced-motion: no-preference) {
			.banner .coin {
				animation: coin-bob 1.2s steps(2) infinite;
			}

			@keyframes coin-bob {
				50% { transform: translateY(-4px); }
			}
		}

		:focus-visible {
			outline: 3px solid var(--accent);
			outline-offset: 2px;
		}
	</style>
</head>
<body>
	<header>
		<svg class="banner" viewBox="0 0 960 200" preserveAspectRatio="xMidYMid slice" role="img" aria-label="devnull.land — pixel-art level with hills, pipes and floating blocks" shape-rendering="crispEdges">
			<rect width="960" height="200" fill="#5c94fc"/>

			<!-- clouds -->
			<g fill="#ffffff">
				<rect x="48" y="20" width="16" height="8"/>
				<rect x="44" y="28" width="24" height="8"/>
				<rect x="40" y="36" width="32" height="8"/>
				<rect x="768" y="36" width="16" height="8"/>
				<rect x="764" y="44" width="24" height="8"/>
				<rect x="760" y="52" width="32" height="8"/>
				<rect x="880" y="12" width="16" height="8"/>
				<rect x="876" y="20" width="24" height="8"/>
				<rect x="872" y="28" width="32" height="8"/>
			</g>

						<!-- coins -->
			<g class="coin">
				<rect x="104" y="40" width="16" height="24" fill="#fbd000"/>
				<rect x="108" y="44" width="8" height="16" fill="#fa9f15"/>
			</g>
			<g class="coin">
				<rect x="300" y="32" width="16" height="24" fill="#fbd000"/>
				<rect x="304" y="36" width="8" height="16" fill="#fa9f15"/>
			</g>
			<g class="coin">
				<rect x="480" y="88" width="16" height="24" fill="#fbd000"/>
				<rect x="484" y="92" width="8" height="16" fill="#fa9f15"/>
			</g>
			<g class="coin">
				<rect x="860" y="40" width="16" height="24" fill="#fbd000"/>
				<rect x="864" y="44" width="8" height="16" fill="#fa9f15"/>
			</g>
<!-- hills -->
			<g fill="#00a800">
				<rect x="0" y="160" width="128" height="8"/>
				<rect x="8" y="152" width="112" height="8"/>
				<rect x="16" y="144" width="96" height="8"/>
				<rect x="24" y="136" width="80" height="8"/>
				<rect x="32" y="128" width="64" height="8"/>
				<rect x="40" y="120" width="48" height="8"/>
				<rect x="208" y="160" width="96" height="8"/>
				<rect x="216" y="152" width="80" height="8"/>
				<rect x="224" y="144" width="64" height="8"/>
				<rect x="232" y="136" width="48" height="8"/>
				<rect x="656" y="160" width="96" height="8"/>
				<rect x="664" y="152" width="80" height="8"/>
				<rect x="672" y="144" width="64" height="8"/>
				<rect x="680" y="136" width="48" height="8"/>
				<rect x="832" y="160" width="128" height="8"/>
				<rect x="840" y="152" width="112" height="8"/>
				<rect x="848" y="144" width="96" height="8"/>
				<rect x="856" y="136" width="80" height="8"/>
				<rect x="864" y="128" width="64" height="8"/>
				<rect x="872" y="120" width="48" height="8"/>
			</g>
			<g fill="#58d854">
				<rect x="40" y="120" width="4" height="48"/>
				<rect x="232" y="136" width="4" height="32"/>
				<rect x="680" y="136" width="4" height="32"/>
				<rect x="872" y="120" width="4" height="48"/>
			</g>

						<!-- pipes -->
			<rect x="88" y="104" width="48" height="16" fill="#43b047"/>
			<rect x="88" y="116" width="48" height="4" fill="#1e6b1e"/>
			<rect x="92" y="120" width="40" height="48" fill="#43b047"/>
			<rect x="96" y="120" width="8" height="48" fill="#80d010"/>
			<rect x="120" y="120" width="8" height="48" fill="#1e6b1e"/>
			<rect x="824" y="104" width="48" height="16" fill="#43b047"/>
			<rect x="824" y="116" width="48" height="4" fill="#1e6b1e"/>
			<rect x="828" y="120" width="40" height="48" fill="#43b047"/>
			<rect x="832" y="120" width="8" height="48" fill="#80d010"/>
			<rect x="856" y="120" width="8" height="48" fill="#1e6b1e"/>

			<!-- block row, one third in: brick brick ? -->
			<rect x="248" y="72" width="48" height="48" fill="#5c2c00"/>
			<rect x="252" y="76" width="40" height="16" fill="#c84c0c"/>
			<rect x="272" y="76" width="4" height="16" fill="#5c2c00"/>
			<rect x="252" y="96" width="40" height="20" fill="#c84c0c"/>
			<rect x="260" y="96" width="4" height="20" fill="#5c2c00"/>
			<rect x="284" y="96" width="4" height="20" fill="#5c2c00"/>
			<rect x="296" y="72" width="48" height="48" fill="#5c2c00"/>
			<rect x="300" y="76" width="40" height="16" fill="#c84c0c"/>
			<rect x="320" y="76" width="4" height="16" fill="#5c2c00"/>
			<rect x="300" y="96" width="40" height="20" fill="#c84c0c"/>
			<rect x="308" y="96" width="4" height="20" fill="#5c2c00"/>
			<rect x="332" y="96" width="4" height="20" fill="#5c2c00"/>
			<rect x="344" y="72" width="48" height="48" fill="#5c3a00"/>
			<rect x="348" y="76" width="40" height="40" fill="#fa9f15"/>
			<rect x="352" y="80" width="8" height="8" fill="#ffffff"/>
			<rect x="376" y="80" width="8" height="8" fill="#ffffff"/>
			<rect x="352" y="104" width="8" height="8" fill="#ffffff"/>
			<rect x="376" y="104" width="8" height="8" fill="#ffffff"/>
			<rect x="364" y="88" width="8" height="2" fill="#ffffff"/>
			<rect x="362" y="90" width="2" height="4" fill="#ffffff"/>
			<rect x="372" y="90" width="2" height="2" fill="#ffffff"/>
			<rect x="368" y="94" width="2" height="4" fill="#ffffff"/>
			<rect x="368" y="100" width="2" height="4" fill="#ffffff"/>

			<!-- block row, two thirds in: brick ? brick -->
			<rect x="568" y="72" width="48" height="48" fill="#5c2c00"/>
			<rect x="572" y="76" width="40" height="16" fill="#c84c0c"/>
			<rect x="592" y="76" width="4" height="16" fill="#5c2c00"/>
			<rect x="572" y="96" width="40" height="20" fill="#c84c0c"/>
			<rect x="580" y="96" width="4" height="20" fill="#5c2c00"/>
			<rect x="604" y="96" width="4" height="20" fill="#5c2c00"/>
			<rect x="616" y="72" width="48" height="48" fill="#5c3a00"/>
			<rect x="620" y="76" width="40" height="40" fill="#fa9f15"/>
			<rect x="624" y="80" width="8" height="8" fill="#ffffff"/>
			<rect x="648" y="80" width="8" height="8" fill="#ffffff"/>
			<rect x="624" y="104" width="8" height="8" fill="#ffffff"/>
			<rect x="648" y="104" width="8" height="8" fill="#ffffff"/>
			<rect x="636" y="88" width="8" height="2" fill="#ffffff"/>
			<rect x="634" y="90" width="2" height="4" fill="#ffffff"/>
			<rect x="644" y="90" width="2" height="2" fill="#ffffff"/>
			<rect x="640" y="94" width="2" height="4" fill="#ffffff"/>
			<rect x="640" y="100" width="2" height="4" fill="#ffffff"/>
			<rect x="664" y="72" width="48" height="48" fill="#5c2c00"/>
			<rect x="668" y="76" width="40" height="16" fill="#c84c0c"/>
			<rect x="688" y="76" width="4" height="16" fill="#5c2c00"/>
			<rect x="668" y="96" width="40" height="20" fill="#c84c0c"/>
			<rect x="676" y="96" width="4" height="20" fill="#5c2c00"/>
			<rect x="700" y="96" width="4" height="20" fill="#5c2c00"/>
<!-- ground -->
			<rect x="0" y="168" width="960" height="16" fill="#e39d25"/>
			<rect x="0" y="184" width="960" height="16" fill="#c84c0c"/>

			<!-- title -->
			<a href="/">
				<text class="title" x="480" y="46" text-anchor="middle" fill="#000000" opacity="0.35">devnull.land</text>
				<text class="title" x="480" y="44" text-anchor="middle" fill="#ffffff">devnull.land</text>
				<text class="tagline" x="480" y="62" text-anchor="middle" fill="#000000" opacity="0.35">bits &amp; bobs from the tech world</text>
				<text class="tagline" x="480" y="60" text-anchor="middle" fill="#ffffff">bits &amp; bobs from the tech world</text>
			</a>
		</svg>
	</header>
</body>
</html>
