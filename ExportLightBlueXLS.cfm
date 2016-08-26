<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=LightBlue.xls">
<cfset ThisColSpan = 7 >
<cfoutput>
	<table border="1">
		<tr> <td width="100%" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>LightBlue Details</strong></td></tr>
	</table>
</cfoutput>
<cfinclude template="queries/qry_QLightBlueDetails.cfm">

<cfoutput>
<table border="1">
</cfoutput>
<cfoutput query="QLightBlueDetails">
<cfif Len(Trim(EmailAddress1)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td> </td>
<td>#Forename#</td>
<td>#Surname#</td>
<td>#Position#</td>
<td>#EmailAddress1#</td>
</tr>
</cfif>
<cfif Len(Trim(EmailAddress2)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td> </td>
<td>#Forename#</td>
<td>#Surname#</td>
<td>#Position#</td>
<td>#EmailAddress2#</td>
</tr>
</cfif>
</cfoutput>
</table>








