<!--- called by CheckPlayerDuplicateNoWarnings2.cfm and CheckPlayerDuplicateNoWarnings3.cfm --->

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "ID") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "Type") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "LeagueCode") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.CurrentLeagueCode = session.CurrentLeagueCode >
</cflock>

<cfif url.LeagueCode NEQ request.CurrentLeagueCode >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset ThisPlayerDuplicateNoWarningsID = #url.ID# >
<!--- delete a single row of the PlayerDuplicateNoWarnings table --->
<cfinclude template="queries/del_SinglePlayerDuplicateNoWarnings.cfm">
<cfif url.Type IS 1 >
	<cflocation url="CheckPlayerDuplicateNoWarnings1.cfm?LeagueCode=#request.CurrentLeagueCode#" ADDTOKEN="NO">
<cfelseif url.Type IS 2 >
	<cflocation url="CheckPlayerDuplicateNoWarnings2.cfm?LeagueCode=#request.CurrentLeagueCode#" ADDTOKEN="NO">
<cfelseif url.Type IS 3 >
	<cflocation url="CheckPlayerDuplicateNoWarnings3.cfm?LeagueCode=#request.CurrentLeagueCode#" ADDTOKEN="NO">
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
