<!--- called by AwardedGames.cfm --->
<cfquery name="QAwardedGames" datasource="#request.DSN#">
SELECT 
	f.HomeID,
	f.AwayID,
	f.Result,
	f.fixturedate,
	d.ID as DID,
	f.ID as FID,
	d.longcol as DivName,
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
	as AwayTeamName
FROM
	fixture f,
	constitution c1,
	constitution c2,
	division d, 
	team t1,
	team t2,
	ordinal o1,
	ordinal o2
WHERE  
	f.leaguecode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND f.Result IN('H','A','D')
 	AND f.HomeID = c1.ID
	AND f.AwayID = c2.ID
	AND t1.id = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.id = c2.TeamID 
	AND o2.id = c2.OrdinalID
	AND d.ID = c1.DivisionID
ORDER BY
	FixtureDate , d.MediumCol,  HomeTeamName
</cfquery>
