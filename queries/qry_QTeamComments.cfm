<!--- called by TeamList.cfm when SecurityLevel is Yellow and also called by InclSchedule01.cfm --->

<CFQUERY NAME="QTeamComments" datasource="#request.DSN#">
	SELECT
		Notes
	FROM
		newsitem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol = 'TeamComments'
</CFQUERY>


