<!--- called from ResultsGrid.cfm --->

<CFQUERY NAME="QResults" datasource="#request.DSN#">
	SELECT
		f.ID as FID, f.HomeID, f.AwayID, f.HomeGoals, f.AwayGoals, f.Result, 
		f.FixtureDate, f.HomePointsAdjust, f.AwayPointsAdjust, f.Attendance,
		IF(d.notes LIKE '%HideDivision%','Yes','No') as HideScore
	FROM 
		fixture AS f,
		constitution AS c,
		division AS d
	WHERE 
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c.ID = f.HomeID
		AND c.DivisionID = d.ID
</cfquery>
