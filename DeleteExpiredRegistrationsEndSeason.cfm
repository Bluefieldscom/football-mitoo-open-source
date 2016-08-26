<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "TeamID") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "LastDayDate") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- see Delete all the Expired registrations for one club --->

<cfquery name="QExpiredRegistrations" datasource="#request.DSN#" >
	DELETE
	FROM
		register
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TeamID = #TeamID#
		AND	LastDay <= '#LastDayDate#'
</cfquery>
<cflocation url="RegisteredPlayers.cfm?LeagueCode=#LeagueCode#" addtoken="no">
