<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif Left(LeagueCode,3) IS "UCL">
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfinclude template="queries/qry_QListOfSuspensions.cfm">
<span class="monopix12">
Export of Suspended Players as at <cfoutput>#DateFormat(Now(),'DD MMMM YYYY')#</cfoutput><br> in Comma Separated Variable (.csv) format<br><br><br>
Surname,Forename,TeamName,RegNo,FirstDay,LastDay,DaysSuspended,NumberOfMatches,DoB,PlayerNotes<br>
<!--- produce a comma separated variable list for export --->
<cfoutput query="QListOfSuspensions">
	<span class="monopix12">"#Surname#","#Forename#","#TeamName#",#RegNo#,#DateFormat(FirstDayOfSuspension,'DD/MM/YYYY')#,#DateFormat(LastDayOfSuspension,'DD/MM/YYYY')#,"#DateDiff('d',FirstDayOfSuspension,LastDayOfSuspension)+1#",<cfif NumberOfMatches IS 0>,<cfelse>#NumberOfMatches#,</cfif><cfif DOB IS "">,<cfelse>#DateFormat(DOB, "DD/MM/YYYY")#,</cfif>"#ReplaceList(StripCR(ReplaceList(PlayerNotes,"<,>,!","")),Chr(34), Chr(32) )#"</span><BR>
</cfoutput>

