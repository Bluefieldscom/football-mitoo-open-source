<!--- called by RefAppoints.cfm, RefAppointsXLS.cfm --->

<cfquery name="QFixtures" datasource="#request.DSN#" >
SELECT
	f.RefereeMarksH,
	f.RefereeMarksA,
	f.HomeGoals,
	f.AwayGoals,
	f.Result,
	f.HomeSportsmanshipMarks,
	f.AwaySportsmanshipMarks,
	t1.longCol AS HomeTeam ,
	t2.longCol AS AwayTeam ,
	t1.shortCol AS HomeGuest ,
	t2.shortCol AS AwayGuest ,
	t1.ID AS HomeTeamID,
	t2.ID AS AwayTeamID,
	o1.longCol AS HomeOrdinal ,
	o2.longCol AS AwayOrdinal ,
	r.ParentCounty,
	r.ID AS RefsID ,
	CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RefsName,
	r.mediumCol AS RefsNo ,
	k.longCol AS RoundName ,
	d.longCol AS DivName ,
	CASE
		WHEN d.Notes LIKE '%External%'
		THEN 'Yes'
		ELSE 'No'
		END
		as External,
	f.HomeID AS FHomeID,
	f.AwayID AS FAwayID,
	f.FixtureDate,
	f.FixtureNotes ,
	f.PrivateNotes
FROM
	fixture AS f,
	referee AS r,
	koround AS k,
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS o1,
	ordinal AS o2,
	division AS d
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND FixtureDate <= #Now()# 
	AND HomeID = c1.ID 
	AND AwayID = c2.ID 
	AND t1.ID = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.ID = c2.TeamID 
	AND o2.id = c2.OrdinalID 
	AND f.RefereeID = r.ID 
	AND f.KORoundID = k.ID 
	AND d.id = c1.DivisionID
HAVING Length(Trim(RefsName)) > 0
ORDER BY
	ParentCounty, Surname, Forename, RefsName, FixtureDate
</cfquery>
