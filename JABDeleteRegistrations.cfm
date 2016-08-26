<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- JAB Only --->

<!--- see RegisteredList1.cfm or RegisteredList2.cfm
Delete all the registrations for a team
--->
<cfinclude template="queries/del_Registrations.cfm">
<cflocation url="RegisteredPlayers.cfm?LeagueCode=#LeagueCode#" addtoken="no">

