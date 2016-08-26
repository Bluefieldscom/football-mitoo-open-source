<!--- called by RefsPromotionReport.cfm --->

<CFQUERY NAME="QLeagueMarksA1" datasource="#DataSrce#">	
	SELECT
		COALESCE(SUM(RefereeMarksA),0)   as SumRefereeMarksA,
		COUNT(RefereeMarksA) as RefereeMarkedGamesA
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FixtureDate 
			BETWEEN #CreateODBCDate(CreateDate(ThisYYYYString, 3, 1))# 
				AND #CreateODBCDate(CreateDate(ThisYYYYString, 5, 31))#
</CFQUERY>
