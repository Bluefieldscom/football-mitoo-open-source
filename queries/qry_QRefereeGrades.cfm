<!--- called by RefsHist.cfm --->

<CFQUERY NAME="QRefereeGrades" datasource="#request.DSN#">	
	SELECT
		COALESCE(SUM(RefereeMarksH),0) as SumRefereeMarksH,
		COALESCE(SUM(RefereeMarksA),0) as SumRefereeMarksA,
		COUNT(RefereeMarksH) as RefereeMarkedGamesH,
		COUNT(RefereeMarksA) as RefereeMarkedGamesA
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND RefereeID = <cfqueryparam value = #RI# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>

