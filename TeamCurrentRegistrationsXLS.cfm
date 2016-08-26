<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##url.TeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">



<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=TeamCurrentRegistrations.xls">
<cfif RIGHT(request.dsn,4) GE 2012>
	<cfset ThisColSpan = 12 >
<cfelse>
	<cfset ThisColSpan = 6 >
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel) > <!--- don't show the notes to clubs  --->
	<cfset ThisColSpan = ThisColSpan - 1 >
</cfif>

<cfinclude template="queries/qry_QTeamCurrentRegistrations.cfm">
<cfoutput>
	<table border="1">
		<tr> <td width="100%" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top" bgcolor="silver"><strong>#LeagueName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>#QTeamCurrentRegistrations.TeamName#<br>Current Player Registrations</strong></td></tr>
	</table>
</cfoutput>

<cfoutput>
<table border="1">
	<tr>
		<td align="center" bgcolor="white">Surname</td>
		<td align="center" bgcolor="white">Forenames</td>
		<td align="center" bgcolor="white">Reg No</td>
		<td align="center" bgcolor="white">Reg Type</td>
		<td align="center" bgcolor="white">DoB</td>
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			<td align="center" bgcolor="white">FAN</td>
		<td align="center" bgcolor="white">Address Line 1</td>
			<td align="center" bgcolor="white">Address Line 2</td>
			<td align="center" bgcolor="white">Address Line 3</td>
			<td align="center" bgcolor="white">Postcode</td>
			<td align="center" bgcolor="white">Email</td>
		</cfif>
		<cfif ListFind("Yellow",request.SecurityLevel) >
		<cfelse>
			<td align="center" bgcolor="white">Notes</td>
		</cfif>
	</tr>
</cfoutput>
	
<cfoutput query="QTeamCurrentRegistrations">
	<tr>
		<td bgcolor="white">#Surname#</td>
		<td bgcolor="white">#Forename#</td>
		<td bgcolor="white">#PlayerRegNo#</td>
		<cfif RegType IS "A">
			<td bgcolor="white">Non-Contract</td>
		<cfelseif RegType IS "B">
			<td bgcolor="white">Contract</td>
		<cfelseif RegType IS "C">
			<td bgcolor="white">Short Loan</td>
		<cfelseif RegType IS "D">
			<td bgcolor="white">Long Loan</td>
		<cfelseif RegType IS "E">
			<td bgcolor="white">Work Experience</td>
		<cfelseif RegType IS "G">
			<td bgcolor="white">Lapsed</td>
		<cfelseif RegType IS "F">
			<td bgcolor="white">Temporary</td>
		<cfelse>
			<td bgcolor="white">Unknown</td>
		</cfif>
		<td bgcolor="white">#DateFormat(PlayerDOB,'DD/MM/YYYY')#</td>
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			<td bgcolor="white">#FAN#</td>
		<td bgcolor="white">#AddressLine1#</td>
			<td bgcolor="white">#AddressLine2#</td>
			<td bgcolor="white">#AddressLine3#</td>
			<td bgcolor="white">#Postcode#</td>
			<td bgcolor="white">#Email1#</td>
		</cfif>
		<cfif ListFind("Yellow",request.SecurityLevel) >
		<cfelse>
			<td bgcolor="white">#PlayerNotes#</td>
		</cfif>
	</tr>
</cfoutput>
</table>
