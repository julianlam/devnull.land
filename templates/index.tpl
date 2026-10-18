<main class="wrap">
	<ul class="post-list">
		{{{ each gists }}}
		<li>
			<a href="/{./url}">{./title}</a>
			<span class="meta">
			<time datetime="{./created_at}">{./dateString}</time>
			{{{ if ./comments }}}
			<br/>
			<a class="comments" href="{./gist_url}#comments">{./comments} comment(s)</a>
			{{{ end }}}
			</span>
		</li>
		{{{ end }}}
	</ul>
	{{{ if showPagination }}}
	<nav class="pagination" aria-label="Post pages">
		<span class="side">
			{{{ if hasPrev }}}
			<a class="prev" href="/?page={prevPage}">&larr; Newer</a>
			{{{ end }}}
		</span>
		<span class="page-indicator">{page} / {totalPages}</span>
		<span class="side">
			{{{ if hasNext }}}
			<a class="next" href="/?page={nextPage}">Older &rarr;</a>
			{{{ end }}}
		</span>
	</nav>
	{{{ end }}}
</main>
