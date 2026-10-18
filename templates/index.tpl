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
</main>
