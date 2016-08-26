<!--- called by RefsPromotionReport.cfm --->

<CFQUERY NAME="QLeagueMarksH1" datasource="#DataSrce#">	
	SELECT
		COALESCE(SUM(RefereeMarksH),0)   as SumRefereeMarksH,
		COUNT(RefereeMarksH) as RefereeMarkedGamesH
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FixtureDate 
			BETWEEN #CreateODBCDate(CreateDate(ThisYYYYString, 3, 1))# 
				AND #CreateODBCDate(CreateDate(ThisYYYYString, 5, 31))#
</CFQUERY>
