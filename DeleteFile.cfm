<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif StructKeyExists(url, "FN")>
	<cffile action="delete" file="#url.FN#" >
	<cflocation url="LUList.cfm?TblName=Document&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
</cfif>
