<!--- called by ins_RefAvailable.cfm, upd_RefAvailable.cfm,  upd_RefAvailable1.cfm --->
<cfquery name="QRefAvailableAfter" datasource="#request.DSN#" >
	SELECT 
		ID,
		RefereeID,
		MatchDate,
		Available, 
		Notes
	FROM 
		refavailable 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #AfterID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

