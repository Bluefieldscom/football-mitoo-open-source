<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=Hospitality.xls">
<cfset ThisColSpan = 7 >
<cfoutput>
	<table border="1">
		<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>#LeagueName#</strong></td></tr>
		<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>Hospitality Marks</strong></td></tr>
	</table>
</cfoutput>
<cfinclude template="queries/qry_QFixtures_v11.cfm">
<cfoutput>
<table border="1">
</cfoutput>
<cfset ThisHomeTeam = "">
	<cfoutput query="QFixtures">
		<cfif ThisHomeTeam IS "#QFixtures.HomeTeam# #QFixtures.HomeOrdinal#">
		<cfelse>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>		
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>		
			</tr>
			
		</cfif>
		<tr>
			<td>#DateFormat( FixtureDate , "DD/MM/YYYY")#</td>
			<td>#DivName#</td>
			<td>#HomeTeam# #HomeOrdinal#</td>
			<td>#HomeGoals#</td>
			<td>#AwayGoals#</td>
			<td>#AwayTeam# #AwayOrdinal#</td>
			<td>#HospitalityMarks#</td>		
		</tr>
		<cfset ThisHomeTeam = "#HomeTeam# #HomeOrdinal#">		
	</cfoutput>
</table>
