<main class="wrap">
	<article class="post">
		<header class="post-header">
			<h1>{./title}</h1>
			<p class="meta">
				<time datetime="{./created_at}">{./dateString}</time>
				{{{ if ./comments }}}
				&middot; <a href="{./gist_url}#comments">{./comments} comment(s)</a>
				{{{ end }}}
			</p>
		</header>
		{{./html}}
		<p><a href="/">&larr; Back to all posts</a></p>
	</article>
</main>
