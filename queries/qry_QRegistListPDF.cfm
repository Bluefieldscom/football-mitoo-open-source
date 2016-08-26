<!--- called by InclSchedule01.cfm --->

<CFQUERY NAME="QRegistListPDF" datasource="#request.DSN#">
	SELECT
		Notes
	FROM
		newsitem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol = 'RegistListPDF'
</CFQUERY>


