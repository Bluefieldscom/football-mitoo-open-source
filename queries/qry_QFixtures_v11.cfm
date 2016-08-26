<!--- called by HospitalityMarksXLS.cfm --->

<cfquery name="QFixtures" datasource="#request.DSN#" >
SELECT
	f.HomeGoals,
	f.AwayGoals,
	f.HospitalityMarks,
	t1.longCol AS HomeTeam ,
	t2.longCol AS AwayTeam ,
	t1.shortCol AS HomeGuest ,
	t2.shortCol AS AwayGuest ,
	t1.ID AS HomeTeamID,
	t2.ID AS AwayTeamID,
	o1.longCol AS HomeOrdinal ,
	o2.longCol AS AwayOrdinal ,
	d.longCol AS DivName ,
	CASE
		WHEN d.Notes LIKE '%External%'
		THEN 'Yes'
		ELSE 'No'
		END
		as External,
	f.HomeID AS FHomeID,
	f.AwayID AS FAwayID,
	f.FixtureDate
FROM
	fixture AS f,
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS o1,
	ordinal AS o2,
	division AS d
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND FixtureDate <= #Now()# 
	AND HomeID = c1.ID 
	AND AwayID = c2.ID 
	AND t1.ID = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.ID = c2.TeamID 
	AND o2.id = c2.OrdinalID 
	AND d.id = c1.DivisionID
ORDER BY
	HomeTeam, HomeOrdinal, AwayTeam, AwayOrdinal, FixtureDate
</cfquery>
