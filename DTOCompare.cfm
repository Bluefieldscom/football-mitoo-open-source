REDUNDANT CODE <cfabort>

<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfinclude template="InclBegin.cfm">
<cfflush>

<cfset OnlyThisLeague = "No">
<cfif StructKeyExists(url,"Only") >
	<cfif url.Only IS "Yes">
		<cfset OnlyThisLeague = "Yes">
	</cfif>
</cfif>

<cfset PreviousYear = #LeagueCodeYear#-1 > <!--- e.g. 2008 --->
<cfset ThisYear = #LeagueCodeYear# >       <!--- e.g. 2009 --->

<cfset PreviousYearDatasource = "fm#PreviousYear#" > <!--- A e.g. "fm2008" --->
<cfset ThisYearDatasource = "fm#ThisYear#" >         <!--- B e.g. "fm2009" --->

<cfset PreviousYearID = "#PreviousYear#id" > <!---  e.g. "2008id" --->
<cfset ThisYearID = "#ThisYear#id" >         <!---  e.g. "2009id" --->

<cfsetting requestTimeOut = "240" >
<cfinclude template="InclMatchingDivisions.cfm">
<cfflush>
<cfinclude template="InclMatchingTeams.cfm">
<cfflush>
<cfinclude template="InclMatchingOrdinals.cfm">
<cfflush>
<!---
<cfinclude template="InclMatchingConstitutions.cfm">
<cfflush>
--->

<cfsetting requestTimeOut = "60" >
