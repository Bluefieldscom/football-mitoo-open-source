<!--- called by RefsPromotionReport.cfm --->

<CFQUERY NAME="QRefereeA1" datasource="#DataSrce#">	
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
		AND RefereeID = <cfqueryparam value = #QRefsID.RID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
