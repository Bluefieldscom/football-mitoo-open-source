<!--- called by DeleteRedundantTeamDetails.cfm --->
<cfquery name="QRedundantTeamDetails" datasource="#request.DSN#">	
	DELETE FROM	
		teamdetails
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND id = <cfqueryparam value = #url.id# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
</cfquery>
