<cfinclude template="queries/qry_QDevelopmentLog1.cfm">
<cfif QDevelopmentLog1.RecordCount GT 0 OR StructKeyExists(url, "DHist") >
	<table width="100%" border="1" align="center" cellpadding="5" cellspacing="0" >
		<cfoutput query="QDevelopmentLog1">
				<tr bgcolor="pink">
					<td width="150" align="left"><span class="pix13boldrealblack">#DateFormat(DevDate, 'DD MMMM YYYY')#</span></td>
					<td align="left"><span class="pix13boldrealblack">#DevText#</span></td>
				</tr>
		</cfoutput>
		<cfif StructKeyExists(url, "DHist")>
			<cfinclude template="queries/qry_QDevelopmentLog2.cfm">
			<cfoutput query="QDevelopmentLog2">
					<tr bgcolor="white">
						<td width="150" align="left"><span class="pix10">#DateFormat(DevDate, 'DD MMMM YYYY')#</span></td>
						<td align="left"><span class="pix10">#DevText#</span></td>
					</tr>
			</cfoutput>
		</cfif>		
	</table>

</cfif>