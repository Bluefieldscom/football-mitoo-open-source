<!--- called from SeeMatchReport.cfm --->

<CFQUERY NAME="QMatchReport1" datasource="#request.DSN#">
	SELECT
		Notes
	FROM
		matchreport
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #MatchReportID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
