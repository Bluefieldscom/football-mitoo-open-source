<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=PrivateComments.xls">
<cfoutput>
<table border="1">
	<tr>
		<td>Fixture Date</td>
		<td>Competition</td>
		<td>Home Team Name</td>
		<td>Away Team Name</td>
		<td>Private Comments</td>
	</tr>
</table>
</cfoutput>
<cfinclude template="queries/qry_QPrivateComments.cfm">
<cfoutput>
<table border="1">
</cfoutput>
<cfoutput query="QPrivateComments">
	<tr>
		<td>#DateFormat(fixturedate, 'dd/mm/yyyy')#</td>
		<td>#competition#</td>
		<td>#HomeTeamName#</td>
		<td>#AwayTeamName#</td>
		<td>#PrivateComments#</td>
	</tr>
</cfoutput>
</table>
