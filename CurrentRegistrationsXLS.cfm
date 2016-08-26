<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=CurrentRegistrations.xls">
<cfif RIGHT(request.dsn,4) GE 2012>
	<cfset ThisColSpan = 13 >
<cfelse>
	<cfset ThisColSpan = 7 >
</cfif>



<cfoutput>
	<table border="1">
		<tr> <td width="100%" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top" bgcolor="silver"><strong>#LeagueName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>Current Player Registrations</strong></td></tr>
	</table>
</cfoutput>

<cfinclude template="queries/qry_QCurrentRegistrations.cfm">


<cfoutput>
<table border="1">
	<tr>
		<td align="center" bgcolor="white">Team</td>
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
		<td align="center" bgcolor="white">Notes</td>
	</tr>
</cfoutput>

<cfif QCurrentRegistrations.RecordCount GT 0>

	<cfoutput query="QCurrentRegistrations">
		<tr>
			<td bgcolor="white">#ClubName#</td>	
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
			<td bgcolor="white">#PlayerNotes#</td>
		</tr>
	</cfoutput>
</cfif> 

</table>
