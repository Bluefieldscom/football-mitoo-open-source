<!--- called by RefsHist.cfm --->

<CFQUERY NAME="QAsstRef2Grades" datasource="#request.DSN#">	
	SELECT
		COALESCE(SUM(AsstRef2Marks),0) as SumAsstRef2Marks,
		COUNT(AsstRef2Marks) as AsstRef2MarkedGames,
		
		COALESCE(SUM(AsstRef2MarksH),0) as SumAsstRef2MarksH,
		COUNT(AsstRef2MarksH) as AsstRef2MarkedGamesH,
		
		COALESCE(SUM(AsstRef2MarksA),0) as SumAsstRef2MarksA,
		COUNT(AsstRef2MarksA) as AsstRef2MarkedGamesA
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND AsstRef2ID = <cfqueryparam value = #RI# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
