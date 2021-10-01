<div class="container">
	<div class="row">
		<div class="column">
			<table>
				<tbody>
					{{{ each gists }}}
					<tr>
						<td>
							<a href="/{./url}">{./title}</a><br />
							<small>{./dateString}</small>
						</td>
					</tr>
					{{{ end }}}
				</tbody>
			</table>
		</div>
	</div>
</div>