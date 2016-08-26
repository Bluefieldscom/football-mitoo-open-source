<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="CENTER" >
			<table border="0" cellspacing="0" cellpadding="3" align="CENTER" bgcolor="Black">
				<tr>
					<td>
						<cfif NewRecord IS "Yes">
							<cfif TblName IS "Matches">
							<cfelse>
								<span class="pix10boldwhite">Adding <cfoutput>#TblName#</cfoutput></span>
							</cfif>
						<cfelse>
							<cfif TblName IS "Matches">
							<cfelse>
								<span class="pix10boldwhite">Updating/Deleting <cfoutput>#TblName#</cfoutput></span>
							</cfif>
						</cfif>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
