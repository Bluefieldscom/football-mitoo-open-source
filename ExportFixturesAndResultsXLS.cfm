<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=FixturesAndResults.xls">
<cfset ThisColSpan = 8 >
<cfoutput>
<table border="1">
	<tr>
		<td>FixtureDate</td>
		<td>DivisionName</td>
		<td>HomeTeamName</td>
		<td>HomeScore</td>
		<td>v</td>
		<td>AwayScore</td>
		<td>AwayTeamName</td>
		<td>FixtureNotes</td>
	</tr>
</table>
</cfoutput>
<cfinclude template="queries/qry_QExportFixturesAndResults.cfm">
<cfoutput>
<table border="1">
</cfoutput>

<cfoutput query="QExportFixturesAndResults">
	<tr>
		<td>#DateFormat(FixtureDate, 'dd/mm/yyyy')#</td>
		<td>#DivisionName#</td>
		<td>#HomeTeamName#</td>
		<td>#HomeScore#</td>
		<td>v</td>
		<td>#AwayScore#</td>
		<td>#AwayTeamName#</td>
		<td>#FixtureNotes#</td>
	</tr>
</cfoutput>
</table>
