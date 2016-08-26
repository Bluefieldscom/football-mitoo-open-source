<!--- called by RefsPromotionReport.cfm --->

<CFQUERY NAME="QRefereeH2" datasource="#DataSrce#">	
	SELECT
		COALESCE(SUM(RefereeMarksH),0)   as SumRefereeMarksH,
		COUNT(RefereeMarksH) as RefereeMarkedGamesH
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FixtureDate 
			BETWEEN #CreateODBCDate(CreateDate(ThisYYYYString, 8, 1))# 
				AND 
			<cfif IsLeapYear(NextYYYYString)>
				#CreateODBCDate(CreateDate(NextYYYYString, 2, 29))#
			<cfelse>
				#CreateODBCDate(CreateDate(NextYYYYString, 2, 28))#
			</cfif> 
		AND RefereeID = <cfqueryparam value = #QRefsID.RID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
