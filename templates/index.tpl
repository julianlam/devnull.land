<div class="container">
	<div class="row">
		<div class="column">
			<table>
				<tbody>
					{{{ each gists }}}
					<tr>
						<td>
							<a href="/{./url}">{./title}</a><br />
							<small>
								{./dateString}
								{{{ if ./comments }}}
								| <a href="{./gist_url}#comments">{./comments} comment(s)</a>
								{{{ end }}}
							</small>
						</td>
					</tr>
					{{{ end }}}
				</tbody>
			</table>
		</div>
	</div>
</div>