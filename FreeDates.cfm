<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QFreeDates.cfm">
<cfif QFreeDates.RecordCount IS 0>
	<span class="pix18">No Free Dates found<BR><BR></span>
	<cfabort>
</cfif>
<cfset ThisColSpan = 2>
<table border="0" cellpadding="2" cellspacing="2">
	<cfoutput query="QFreeDates" group="TeamName">
		<tr>
			<td align="left"><span class="pix13bold">#TeamName#</span></td>
			<td align="left"><img src="gif/unavailable.gif"> </td>
		</tr>
		<cfset ThisCount = 0>
		<cfoutput>
			<tr>
				<td> </td>
				<td  align="left"><span class="pix10">#DateFormat(FreeDate,'DDDD, DD MMMM YYYY')#</span></td>
			</tr>
		</cfoutput>
		<tr><td colspan="#ThisColSpan#" align="left"></td></tr>
	</cfoutput>
</table>

