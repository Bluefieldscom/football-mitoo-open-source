<!--- Called by LUList.cfm --->

<CFQUERY NAME="MatchReportList" datasource="#request.DSN#">
	SELECT 
		ID,
		LongCol,
		MediumCol,
		ShortCol,
		Notes
	FROM
		matchreport as MatchReport
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol IS NOT NULL
	ORDER BY
		 ID DESC
</CFQUERY>
