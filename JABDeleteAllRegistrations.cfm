<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- JAB Only --->

<!--- see RegisteredList1.cfm or RegisteredList2.cfm
Delete all the registrations for ALL TEAMS 
--->


<cfinclude template="queries/qry_QRegPlayers1.cfm">
<cfoutput query="QRegPlayers1">
	<cfset TeamID = #TID# >
	<cfinclude template="queries/del_Registrations.cfm">
</cfoutput>
<cflocation url="RegisteredPlayers.cfm?LeagueCode=#LeagueCode#" addtoken="no">

