<main class="wrap">
	<ul class="post-list">
		{{{ each gists }}}
		<li>
			<a href="/{./url}">{./title}</a>
			<time datetime="{./created_at}">{./dateString}</time>
			{{{ if ./comments }}}
			<a class="comments" href="{./gist_url}#comments">{./comments} comment(s)</a>
			{{{ end }}}
		</li>
		{{{ end }}}
	</ul>
</main>
