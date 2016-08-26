<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=Committee.xls">
<cfset ThisColSpan = 11 >
<cfoutput>
<table border="1">
	<tr>
		<td>PageRequests</td>
		<td>LeagueCode</td>
		<td>LeagueName</td>
		<td>Position</td>
		<td>Title</td>
		<td>Surname</td>
		<td>Forenames</td>
		<td>Name</td>
		<td>Email1</td>
		<td>Email2</td>
		<td>AddressLine1</td>
		<td>AddressLine2</td>
		<td>AddressLine3</td>
		<td>PostCode</td>
		<td>HomeTel</td>
		<td>WorkTel</td>
		<td>MobileTel</td>
	</tr>
</table>
</cfoutput>
<cfinclude template="queries/qry_QCommitteeMailout.cfm">
<cfoutput>
<table border="1">
</cfoutput>
<cfoutput query="QCommitteeMailout1">
	<tr>
		<td>#PageRequests#</td>
		<td>#LeagueCode#</td>
		<td>#LeagueName#</td>
		<td>#Position#</td>
		<td>#Title#</td>
		<td>#Surname#</td>
		<td>#Forename#</td>
		<td>#Membername#</td>
		<td>#EmailAddress1#</td> 
		<td>#EmailAddress2#</td> 
		<td>#AddressLine1#</td>
		<td>#AddressLine2#</td>
		<td>#AddressLine3#</td>
		<td>#PostCode#</td>
		<td>#HomeTel#</td>
		<td>#WorkTel#</td>
		<td>#MobileTel#</td>
	</tr>
</cfoutput>
</table>
