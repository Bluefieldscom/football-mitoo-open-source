<!--- called from MoveToMisc.cfm --->

<cfquery name="QMisc005" datasource="#request.DSN#" >
	SELECT
		ID, 
		DivisionID, 
		TeamID, 
		OrdinalID, 
		ThisMatchNoID, 
		NextMatchNoID, 
		LeagueCode   
	FROM
		constitution 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #form.AwayID#
</cfquery>
