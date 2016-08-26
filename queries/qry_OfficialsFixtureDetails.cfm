<!--- called by Calendar.cfm --->

<cfquery name="QOfficialsFixtureDetails" datasource="#request.DSN#">
	SELECT
		CASE
		WHEN o1.LongCol IS NULL
		THEN t1.LongCol
		ELSE CONCAT(t1.LongCol, " ", o1.LongCol)
		END
		as HomeTeamName ,
		CASE
		WHEN o2.LongCol IS NULL
		THEN t2.LongCol
		ELSE CONCAT(t2.LongCol, " ", o2.LongCol)
		END
		as AwayTeamName,
		f.RefereeID as RefereeID,
		f.AsstRef1ID as AsstRef1ID,
		f.AsstRef2ID as AsstRef2ID,
		f.FourthOfficialID as FourthOfficialID,
		f.AssessorID as AssessorID,
		d.ShortCol as DivisionCode,
		f.HomeGoals,
		f.AwayGoals,
		f.Result
	FROM
		fixture f,
		constitution AS c1,
		team AS t1,
		ordinal AS o1,
		constitution AS c2,
		team AS t2,
		ordinal AS o2,
		division d
	WHERE
		f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">	
		AND f.FixtureDate = '#ThisFixtureDate#'
		AND (f.RefereeID = #ThisRefereeID# OR AsstRef1ID = #ThisRefereeID# OR AsstRef2ID = #ThisRefereeID# OR FourthOfficialID = #ThisRefereeID# OR AssessorID = #ThisRefereeID#)
		AND f.HomeID = c1.ID
		AND f.AwayID = c2.ID
		AND t1.id = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.id = c2.TeamID 
		AND o2.id = c2.OrdinalID
		AND d.ID = c1.DivisionID							
</cfquery>

