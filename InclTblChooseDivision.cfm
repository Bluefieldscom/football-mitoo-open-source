<cfinclude template="queries/qry_GetDivision_v3.cfm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="LEFT">
			<SELECT NAME="DID" size="1">
				<cfoutput query="GetDivision3" >
					<cfif DIDSelected IS "#ID#">
						<OPTION VALUE="#ID#" selected >#DivisionName#</OPTION>
					<cfelse>
						<OPTION VALUE="#ID#">#DivisionName#</OPTION>
					</cfif>
				</cfoutput>
			</select>
		</td>
	</tr>
</table>
