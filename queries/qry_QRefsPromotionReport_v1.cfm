<!--- called by RefsPromotionReport.cfm --->

<!--- <cfquery name="QRefsPromotionReport" datasource="#request.DSN#"> --->
<cfquery name="QRefsPromotionReport" datasource="#DataSrce#">
	SELECT
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RName ,
		f.RefereeMarksH,
		f.RefereeMarksA,
		f.FixtureDate,
		f.HomeGoals,
		f.AwayGoals,
		d.LongCol as DivisionName,
		t1.LongCol as HomeTeamName,
		o1.LongCol as HomeOrdinalName,
		t2.LongCol as AwayTeamName,
		o2.LongCol as AwayOrdinalName
	FROM
		referee AS r,
		fixture AS f,
		team AS t1,
		ordinal AS o1,
		team AS t2,
		ordinal AS o2,
		constitution AS c1,
		constitution AS c2,
		division AS d
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.FixtureDate 
			BETWEEN #CreateODBCDate(CreateDate(ThisYYYYString, 3, 1))# 
				AND #CreateODBCDate(CreateDate(ThisYYYYString, 5, 31))# 
		AND r.ID = <cfqueryparam value = #QRefsID.RID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND r.ID = f.RefereeID 
		AND f.HomeID = c1.ID 
		AND c1.TeamID = t1.ID 
		AND c1.OrdinalID = o1.ID 
		AND f.AwayID = c2.ID 
		AND c2.TeamID = t2.ID 
		AND c2.OrdinalID = o2.ID 
		AND c1.DivisionID = d.ID
	ORDER BY
		FixtureDate <!--- f.FixtureDate --->
</cfquery>
