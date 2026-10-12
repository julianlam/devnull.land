<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>{{{ if title }}}{./title}{{{ else }}}Home{{{ end }}} | devnull.land</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Miscellaneous bits and bobs from the tech world">
	<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' shape-rendering='crispEdges'%3E%3Crect width='16' height='16' fill='%23fa9f15'/%3E%3Crect x='1' y='1' width='2' height='2' fill='%23fff'/%3E%3Crect x='13' y='1' width='2' height='2' fill='%23fff'/%3E%3Crect x='1' y='13' width='2' height='2' fill='%23fff'/%3E%3Crect x='13' y='13' width='2' height='2' fill='%23fff'/%3E%3Crect x='8' y='3' width='1' height='2' fill='%23fff'/%3E%3Crect x='7' y='5' width='2' height='1' fill='%23fff'/%3E%3Crect x='7' y='6' width='1' height='2' fill='%23fff'/%3E%3Crect x='7' y='10' width='1' height='1' fill='%23fff'/%3E%3C/svg%3E">
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
			max-height: 150px;
			background: var(--sky);
		}

		.banner a { text-decoration: none; }

		.banner .title {
			font-family: var(--pixel-font);
			font-size: 24px;
			letter-spacing: 1px;
		}

		.banner .tagline {
			font-family: var(--pixel-font);
			font-size: 8px;
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
			display: flex;
			flex-wrap: wrap;
			align-items: baseline;
			gap: 0.25rem 1rem;
			padding: 1rem 0;
			border-bottom: 1px solid var(--line);
		}

		.post-list li:first-child { padding-top: 0; }

		.post-list a {
			flex: 1 1 12rem;
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

		.post-list time,
		.post-list .comments {
			white-space: nowrap;
			font-size: 0.875rem;
			color: var(--muted);
		}

		.post-list .comments { text-decoration: none; }

		.post-list .comments:hover,
		.post-list .comments:focus {
			color: var(--accent);
			text-decoration: underline;
		}

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
			.banner .title { font-size: 16px; }
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
		<svg class="banner" viewBox="0 0 960 112" role="img" aria-label="devnull.land — pixel-art level with hills, pipes and floating blocks" shape-rendering="crispEdges">
			<rect width="960" height="112" fill="#5c94fc"/>

			<!-- clouds -->
			<g fill="#ffffff">
				<rect x="24" y="32" width="16" height="8"/>
				<rect x="8" y="40" width="48" height="8"/>
				<rect x="680" y="24" width="16" height="8"/>
				<rect x="664" y="32" width="48" height="8"/>
				<rect x="928" y="32" width="16" height="8"/>
				<rect x="912" y="40" width="48" height="8"/>
			</g>

			<!-- coins -->
			<g class="coin">
				<rect x="140" y="60" width="8" height="12" fill="#fbd000"/>
				<rect x="142" y="62" width="4" height="8" fill="#fa9f15"/>
			</g>
			<g class="coin">
				<rect x="396" y="52" width="8" height="12" fill="#fbd000"/>
				<rect x="398" y="54" width="4" height="8" fill="#fa9f15"/>
			</g>
			<g class="coin">
				<rect x="660" y="60" width="8" height="12" fill="#fbd000"/>
				<rect x="662" y="62" width="4" height="8" fill="#fa9f15"/>
			</g>
			<g class="coin">
				<rect x="936" y="56" width="8" height="12" fill="#fbd000"/>
				<rect x="938" y="58" width="4" height="8" fill="#fa9f15"/>
			</g>
			<g class="coin">
				<rect x="250" y="28" width="8" height="12" fill="#fbd000"/>
				<rect x="252" y="30" width="4" height="8" fill="#fa9f15"/>
			</g>

			<!-- hills -->
			<g fill="#00a800">
			<rect x="16" y="88" width="120" height="8"/>
			<rect x="24" y="80" width="104" height="8"/>
			<rect x="32" y="72" width="88" height="8"/>
			<rect x="40" y="64" width="72" height="8"/>
			<rect x="48" y="56" width="56" height="8"/>
			<rect x="56" y="48" width="40" height="8"/>
			<rect x="64" y="40" width="24" height="8"/>
			<rect x="280" y="88" width="120" height="8"/>
			<rect x="288" y="80" width="104" height="8"/>
			<rect x="296" y="72" width="88" height="8"/>
			<rect x="304" y="64" width="72" height="8"/>
			<rect x="312" y="56" width="56" height="8"/>
			<rect x="320" y="48" width="40" height="8"/>
			<rect x="328" y="40" width="24" height="8"/>
			<rect x="560" y="88" width="104" height="8"/>
			<rect x="568" y="80" width="88" height="8"/>
			<rect x="576" y="72" width="72" height="8"/>
			<rect x="584" y="64" width="56" height="8"/>
			<rect x="592" y="56" width="40" height="8"/>
			<rect x="600" y="48" width="24" height="8"/>
			<rect x="760" y="88" width="184" height="8"/>
			<rect x="768" y="80" width="168" height="8"/>
			<rect x="776" y="72" width="152" height="8"/>
			<rect x="784" y="64" width="136" height="8"/>
			<rect x="792" y="56" width="120" height="8"/>
			<rect x="800" y="48" width="104" height="8"/>
			<rect x="808" y="40" width="88" height="8"/>
			<rect x="816" y="32" width="72" height="8"/>
			<rect x="824" y="24" width="56" height="8"/>
			<rect x="832" y="16" width="40" height="8"/>
			<rect x="840" y="8" width="24" height="8"/>
			</g>
			<g fill="#58d854">
				<rect x="68" y="40" width="4" height="48"/>
				<rect x="332" y="40" width="4" height="48"/>
				<rect x="604" y="48" width="4" height="40"/>
				<rect x="840" y="8" width="4" height="88"/>
			</g>

			<!-- pipes -->
			<rect x="160" y="48" width="20" height="12" fill="#43b047"/>
			<rect x="160" y="56" width="20" height="4" fill="#1e6b1e"/>
			<rect x="164" y="60" width="12" height="36" fill="#43b047"/>
			<rect x="164" y="60" width="4" height="36" fill="#80d010"/>
			<rect x="172" y="60" width="4" height="36" fill="#1e6b1e"/>
			<rect x="430" y="48" width="20" height="12" fill="#43b047"/>
			<rect x="430" y="56" width="20" height="4" fill="#1e6b1e"/>
			<rect x="434" y="60" width="12" height="36" fill="#43b047"/>
			<rect x="434" y="60" width="4" height="36" fill="#80d010"/>
			<rect x="442" y="60" width="4" height="36" fill="#1e6b1e"/>
			<rect x="700" y="48" width="20" height="12" fill="#43b047"/>
			<rect x="700" y="56" width="20" height="4" fill="#1e6b1e"/>
			<rect x="704" y="60" width="12" height="36" fill="#43b047"/>
			<rect x="704" y="60" width="4" height="36" fill="#80d010"/>
			<rect x="712" y="60" width="4" height="36" fill="#1e6b1e"/>

			<!-- ? blocks -->
			<rect x="108" y="40" width="24" height="24" fill="#fa9f15"/>
			<rect x="108" y="40" width="24" height="4" fill="#fbd000"/>
			<rect x="112" y="44" width="4" height="4" fill="#ffffff"/>
			<rect x="128" y="44" width="4" height="4" fill="#ffffff"/>
			<rect x="112" y="60" width="4" height="4" fill="#ffffff"/>
			<rect x="128" y="60" width="4" height="4" fill="#ffffff"/>
			<rect x="112" y="44" width="12" height="4" fill="#ffffff"/>
			<rect x="124" y="48" width="4" height="4" fill="#ffffff"/>
			<rect x="120" y="52" width="4" height="4" fill="#ffffff"/>
			<rect x="120" y="60" width="4" height="4" fill="#ffffff"/>
			<rect x="210" y="56" width="24" height="24" fill="#fa9f15"/>
			<rect x="210" y="56" width="24" height="4" fill="#fbd000"/>
			<rect x="214" y="60" width="4" height="4" fill="#ffffff"/>
			<rect x="230" y="60" width="4" height="4" fill="#ffffff"/>
			<rect x="214" y="76" width="4" height="4" fill="#ffffff"/>
			<rect x="230" y="76" width="4" height="4" fill="#ffffff"/>
			<rect x="214" y="60" width="12" height="4" fill="#ffffff"/>
			<rect x="226" y="64" width="4" height="4" fill="#ffffff"/>
			<rect x="222" y="68" width="4" height="4" fill="#ffffff"/>
			<rect x="222" y="76" width="4" height="4" fill="#ffffff"/>
			<rect x="490" y="44" width="24" height="24" fill="#fa9f15"/>
			<rect x="490" y="44" width="24" height="4" fill="#fbd000"/>
			<rect x="494" y="48" width="4" height="4" fill="#ffffff"/>
			<rect x="510" y="48" width="4" height="4" fill="#ffffff"/>
			<rect x="494" y="64" width="4" height="4" fill="#ffffff"/>
			<rect x="510" y="64" width="4" height="4" fill="#ffffff"/>
			<rect x="494" y="48" width="12" height="4" fill="#ffffff"/>
			<rect x="506" y="52" width="4" height="4" fill="#ffffff"/>
			<rect x="502" y="56" width="4" height="4" fill="#ffffff"/>
			<rect x="502" y="64" width="4" height="4" fill="#ffffff"/>
			<rect x="740" y="48" width="24" height="24" fill="#fa9f15"/>
			<rect x="740" y="48" width="24" height="4" fill="#fbd000"/>
			<rect x="744" y="52" width="4" height="4" fill="#ffffff"/>
			<rect x="760" y="52" width="4" height="4" fill="#ffffff"/>
			<rect x="744" y="68" width="4" height="4" fill="#ffffff"/>
			<rect x="760" y="68" width="4" height="4" fill="#ffffff"/>
			<rect x="744" y="52" width="12" height="4" fill="#ffffff"/>
			<rect x="756" y="56" width="4" height="4" fill="#ffffff"/>
			<rect x="752" y="60" width="4" height="4" fill="#ffffff"/>
			<rect x="752" y="68" width="4" height="4" fill="#ffffff"/>

			<!-- brick blocks -->
			<rect x="136" y="40" width="24" height="24" fill="#c84c0c"/>
			<rect x="136" y="48" width="24" height="4" fill="#5c2c00"/>
			<rect x="136" y="56" width="24" height="4" fill="#5c2c00"/>
			<rect x="148" y="40" width="4" height="8" fill="#5c2c00"/>
			<rect x="142" y="52" width="4" height="4" fill="#5c2c00"/>
			<rect x="154" y="52" width="4" height="4" fill="#5c2c00"/>
			<rect x="234" y="56" width="24" height="24" fill="#c84c0c"/>
			<rect x="234" y="64" width="24" height="4" fill="#5c2c00"/>
			<rect x="234" y="72" width="24" height="4" fill="#5c2c00"/>
			<rect x="246" y="56" width="4" height="8" fill="#5c2c00"/>
			<rect x="240" y="68" width="4" height="4" fill="#5c2c00"/>
			<rect x="252" y="68" width="4" height="4" fill="#5c2c00"/>
			<rect x="514" y="44" width="24" height="24" fill="#c84c0c"/>
			<rect x="514" y="52" width="24" height="4" fill="#5c2c00"/>
			<rect x="514" y="60" width="24" height="4" fill="#5c2c00"/>
			<rect x="526" y="44" width="4" height="8" fill="#5c2c00"/>
			<rect x="520" y="56" width="4" height="4" fill="#5c2c00"/>
			<rect x="532" y="56" width="4" height="4" fill="#5c2c00"/>

			<!-- ground -->
			<rect x="0" y="96" width="960" height="8" fill="#e39d25"/>
			<rect x="0" y="104" width="960" height="8" fill="#c84c0c"/>

			<!-- title -->
			<a href="/">
				<text class="title" x="480" y="28" text-anchor="middle" fill="#000000" opacity="0.35">devnull.land</text>
				<text class="title" x="480" y="26" text-anchor="middle" fill="#ffffff">devnull.land</text>
				<text class="tagline" x="480" y="44" text-anchor="middle" fill="#000000" opacity="0.35">bits &amp; bobs from the tech world</text>
				<text class="tagline" x="480" y="42" text-anchor="middle" fill="#ffffff">bits &amp; bobs from the tech world</text>
			</a>
		</svg>
	</header>
</body>
</html>
