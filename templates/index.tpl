<div class="container">
	<div class="row">
		<div class="column">
			<table>
				<thead>
					<tr>
						<th>Title</th>
						<th>Date</th>
					</tr>
				</thead>
				<tbody>
					{{{ each gists }}}
					<tr>
						<td>
							<a href="{./url}">{./title}</a>
						</td>
						<td>
							{./dateString}
						</td>
					</tr>
					{{{ end }}}
				</tbody>
			</table>
		</div>
	</div>
</div>