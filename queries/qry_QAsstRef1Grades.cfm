<!--- called by RefsHist.cfm --->

<CFQUERY NAME="QAsstRef1Grades" datasource="#request.DSN#">	
	SELECT
		COALESCE(SUM(AsstRef1Marks),0) as SumAsstRef1Marks,
		COUNT(AsstRef1Marks) as AsstRef1MarkedGames,
		
		COALESCE(SUM(AsstRef1MarksH),0) as SumAsstRef1MarksH,
		COUNT(AsstRef1MarksH) as AsstRef1MarkedGamesH,
		
		COALESCE(SUM(AsstRef1MarksA),0) as SumAsstRef1MarksA,
		COUNT(AsstRef1MarksA) as AsstRef1MarkedGamesA
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND AsstRef1ID = <cfqueryparam value = #RI# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
