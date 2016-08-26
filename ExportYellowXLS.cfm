<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=Yellow.xls">
<cfset ThisColSpan = 6 >
<cfoutput>
	<table border="1">
		<tr> <td width="100%" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>Yellow Details</strong></td></tr>
	</table>
</cfoutput>
<cfinclude template="queries/qry_QYellowDetails1.cfm">

<cfinclude template="queries/qry_QYellowDetails2.cfm">

<cfoutput>
<table border="1">
</cfoutput>
<cfoutput query="QYellowDetails1">
<cfif Len(Trim(Contact1Email1)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td>#TeamName#</td>
<td>#Contact1Name#</td>
<td>#Contact1JobDescr#</td>
<td>#Contact1Email1#</td>
</tr>
</cfif>
<cfif Len(Trim(Contact1Email2)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td>#TeamName#</td>
<td>#Contact1Name#</td>
<td>#Contact1JobDescr#</td>
<td>#Contact1Email2#</td>
</tr>
</cfif>
<cfif Len(Trim(Contact2Email1)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td>#TeamName#</td>
<td>#Contact2Name#</td>
<td>#Contact2JobDescr#</td>
<td>#Contact2Email1#</td>
</tr>
</cfif>
<cfif Len(Trim(Contact2Email2)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td>#TeamName#</td>
<td>#Contact2Name#</td>
<td>#Contact2JobDescr#</td>
<td>#Contact2Email2#</td>
</tr>
</cfif>
<cfif Len(Trim(Contact3Email1)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td>#TeamName#</td>
<td>#Contact3Name#</td>
<td>#Contact3JobDescr#</td>
<td>#Contact3Email1#</td>
</tr>
</cfif>
<cfif Len(Trim(Contact3Email2)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td>#TeamName#</td>
<td>#Contact3Name#</td>
<td>#Contact3JobDescr#</td>
<td>#Contact3Email2#</td>
</tr>
</cfif>
</cfoutput>

<cfoutput query="QYellowDetails2">
<cfif Len(Trim(EmailAddress1)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td> </td>
<td>#Forename# #Surname#</td>
<td>Referee</td>
<td>#EmailAddress1#</td>
</tr>
</cfif>
<cfif Len(Trim(EmailAddress2)) GT 0 >
<tr>
<td>#namesort#</td>
<td>#leaguecode#</td>
<td> </td>
<td>#Forename# #Surname#</td>
<td>Referee</td>
<td>#EmailAddress2#</td>
</tr>
</cfif>
</cfoutput>
</table>








