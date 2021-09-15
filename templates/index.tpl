<html>
<head>
	<style>
		table {
			width: 100%;
		}

		th, td {
			text-align: left;
			padding: 1em;
		}
	</style>
</head>
<body>
	<h1>devnull.land</h1>
	<em>Miscellaneous bits and bobs from the tech world</em>
	<hr />
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
</body>
</html>