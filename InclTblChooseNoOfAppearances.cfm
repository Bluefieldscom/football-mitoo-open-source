<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="LEFT">
			<cfoutput>
				<SELECT NAME="NoOfAppearances" size="1">
					<cfloop from="1" to="30" step="1" index="n">
						<cfif NoOfAppearancesSelected IS "#n#">
							<option value="#n#" selected >#n#</option>
						<cfelse>
							<option value="#n#" >#n#</option>
						</cfif>
					</cfloop>
				</select>
			</cfoutput>
		</td>
	</tr>
</table>
