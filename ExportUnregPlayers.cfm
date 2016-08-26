<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif Left(LeagueCode,3) IS "UCL">
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfinclude template="queries/qry_QAllUnregisteredPlayersName.cfm">
<span class="monopix12">
Export of Unregistered Players as at <cfoutput>#DateFormat(Now(),'DD MMMM YYYY')#</cfoutput><br> in Comma Separated Variable (.csv) format<br><br><br>
RegNo,Surname,Forename,DoB,PlayerNotes<br>
<!--- produce a comma separated variable list for export --->
<cfoutput query="QAllUnregisteredPlayersName">
	<span class="monopix12">#PlayerRegNo#,"#Surname#","#Forename#",<cfif PlayerDOB IS "">,<cfelse>#DateFormat(PlayerDOB, "DD/MM/YYYY")#,</cfif>"#PlayerNotes#"</span><BR>
</cfoutput>

