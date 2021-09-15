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
				{./created_at}
			</td>
		</tr>
		{{{ end }}}
	</tbody>
</table>