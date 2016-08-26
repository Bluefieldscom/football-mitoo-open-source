<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=RegOfInterest.xls">
<cfset ThisColSpan = 12 >
<cfoutput>
	<table border="1">
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>Registrations of Interest in football.mitoo</strong></td></tr>
	</table>
</cfoutput>
<!---
<cfinclude template="queries/qry_QRegOfInterest1.cfm">
--->
<cfinclude template="queries/qry_QRegOfInterest3.cfm">


<cfoutput>
<table border="1">
<tr bgcolor="silver">
	<td>Date</td>
	<td>Forename</td> 
	<td>Surname</td> 
	<td>Email</td> 
	<td>OtherComments</td> 
	<td>LeagueCode</td> 
	<td>TeamsInvolved</td> 
	<td>RoleList</td>
	<td>Other</td> 
	<td>HowFoundOut</td> 
	<td>HowLongUsing</td> 
	<td>AgeRange</td>
</tr>
</cfoutput>
<cfoutput query="QRegOfInterest3">
<tr>
	<td>#DateFormat(DateRegistered, 'DD/MM/YY')#</td>
	<td>#Forename#</td> 
	<td>#Surname#</td> 
	<td>#Email#</td> 
	<td>#OtherComments#</td> 
	<td>#LeagueCode#</td> 
	<td>#TeamsInvolved#</td> 
	<td>#RoleList#</td>
	<td>#Other#</td> 
	<td>#HowFoundOut#</td> 
	<td>#HowLongUsing#</td> 
	<td>#AgeRange#</td>
</tr>
</cfoutput>
</table>

<cfinclude template="queries/qry_QRegOfInterest2.cfm">

<cfoutput>
<table border="1">
<tr bgcolor="silver">
	<td>Date</td>
	<td>Forename</td> 
	<td>Surname</td> 
	<td>Email</td> 
	<td>OtherComments</td> 
	<td>LeagueCode</td> 
	<td>TeamsInvolved</td> 
	<td>Roles</td>
	<td></td>
	<td>HowFoundOut</td> 
	<td>HowLongUsing</td> 
	<td>AgeRange</td>
</tr>
</cfoutput>
<cfoutput query="QRegOfInterest2">
<tr>
	<td>#DateFormat(DateRegistered, 'DD/MM/YY')#</td>
	<td>#Forename#</td> 
	<td>#Surname#</td> 
	<td>#Email#</td> 
	<td>#OtherComments#</td> 
	<td>#LeagueCode#</td> 
	<td>#TeamsInvolved#</td> 
	<td>#Roles#</td>
	<td></td> 
	<td>#HowFoundOut#</td> 
	<td>#HowLongUsing#</td> 
	<td>#AgeRange#</td>
</tr>
</cfoutput>
</table>



<cfinclude template="queries/qry_QRegOfInterest1.cfm">

<cfoutput>
<table border="1">
<tr bgcolor="silver">
	<td>Date</td>
	<td colspan="2">Name</td> 
	<td>Email</td> 
	<td>Info</td> 
	<td>LeagueCode</td> 
	<td></td> 
	<td></td>
	<td></td>
	<td></td> 
	<td></td> 
	<td></td>
</tr>
</cfoutput>
<cfoutput query="QRegOfInterest1">
<tr>
	<td>#DateFormat(DateRegistered, 'DD/MM/YY')#</td>
	<td colspan="2">#Name#</td> 
	<td>#Email#</td> 
	<td>#Info#</td> 
	<td>#LeagueCode#</td> 
	<td></td> 
	<td></td>
	<td></td> 
	<td></td> 
	<td></td> 
	<td></td>
</tr>
</cfoutput>
</table>
