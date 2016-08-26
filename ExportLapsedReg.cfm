<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif Left(LeagueCode,3) IS "UCL">
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfinclude template="queries/qry_QLapsedReg.cfm">
<span class="monopix12">
Export of Player Registrations as at <cfoutput>#DateFormat(Now(),'DD MMMM YYYY')#</cfoutput><br>in Comma Separated Variable (.csv) format<br><br><br>
RegNo,Surname,Forename,DoB,ClubName,RegType,FirstDay,LastDay,PlayerNotes<br>
<!--- produce a comma separated variable list for export --->
<cfoutput query="QLapsedReg">

	<span class="monopix12">#PlayerRegNo#,"#Surname#","#Forename#",<cfif PlayerDOB IS "">,<cfelse>#DateFormat(PlayerDOB, "DD/MM/YYYY")#,</cfif>"#ClubName#",<cfif RegType IS "A">"Non-Contract"<cfelseif RegType IS "B">"Contract"<cfelseif RegType IS "C">"Short Loan"<cfelseif RegType IS "D">"Long Loan"<cfelseif RegType IS "E">"Work Experience"<cfelseif RegType IS "G">"Lapsed"<cfelseif RegType IS "F">"Temporary"</cfif>,<cfif FirstDay IS "">,<cfelse>#DateFormat(FirstDay, "DD/MM/YYYY")#,</cfif><cfif LastDay IS "">,<cfelse>#DateFormat(LastDay, "DD/MM/YYYY")#,</cfif>"#PlayerNotes#"</span><BR>
</cfoutput>

