<!--- called by MtchDay.cfm --->

<cfquery name="QDoubleHeader" datasource="#request.DSN#">
		SELECT
			id
		FROM
			fixture 
		WHERE
			leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND fixturedate='#ThisDate#'
			AND CONCAT(CAST(awayid as char(60)), ' ', CAST(homeid as char(60))) 
			IN (SELECT  CONCAT(CAST(homeid as char(60)), ' ', CAST(awayid as char(60)))
				FROM fixture WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND fixturedate='#ThisDate#')
</cfquery>