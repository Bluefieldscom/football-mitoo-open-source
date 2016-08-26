<!--- called by News.cfm --->
<cfquery name="QFixturesMissingKORound" datasource="#request.DSN#">
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
	d.longcol as DivName,
	f.fixturedate as FixtureDate,
	f.MatchNumber as MatchNumber,
	t1.ID as TID,
	d.ID as DID
FROM
	fixture f,
	constitution c1,
	constitution c2,
	division d, 
	koround k,
	team t1,
	team t2,
	ordinal o1,
	ordinal o2
WHERE  
	f.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
  	AND left(d.notes,2)='KO'
  	AND k.longcol IS NULL
	AND f.HomeID = c1.ID
	AND f.AwayID = c2.ID
	AND t1.id = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.id = c2.TeamID 
	AND o2.id = c2.OrdinalID
	AND d.ID = c1.DivisionID
	AND f.koroundid=k.id
ORDER BY
	d.MediumCol, FixtureDate , MatchNumber, HomeTeamName, AwayTeamName
</cfquery>