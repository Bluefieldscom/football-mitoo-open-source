<!--- called by InclSchedule01.cfm --->

<cfquery name="GetKORnd" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol
	FROM
		koround as KORound
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		MediumCol
</cfquery>

