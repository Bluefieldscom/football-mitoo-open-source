<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "LeagueCode") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "RegNo1") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "RegNo2") >
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
<cfinclude template="queries/ins_PlayerDuplicateNoWarning3.cfm">
<cflocation url="LUList.cfm?TblName=Player&LeagueCode=#request.CurrentLeagueCode#" ADDTOKEN="NO">
