<!--- Called by HomeAwayTeamCommentsXLS.cfm --->

<cfquery name="QHomeAwayTeamComments" datasource="#request.DSN#" >
SELECT 
	f.fixturedate,
	d.longcol as Competition,
	CASE
	WHEN o1.longcol IS NULL 
	THEN t1.longcol
	ELSE CONCAT(t1.longcol, " ", o1.longcol)
	END
	as HomeTeamName ,
	CASE
	WHEN o2.longcol IS NULL
	THEN t2.longcol
	ELSE CONCAT(t2.longcol, " ", o2.longcol)
	END
	as AwayTeamName ,
	f.hometeamnotes as HomeTeamComments,
	f.awayteamnotes as AwayTeamComments
FROM
	fixture f ,
	constitution AS c1 ,
	constitution AS c2 ,
	team AS t1 ,
	team AS t2 ,
	ordinal AS o1 ,
	ordinal AS o2 ,
	division d
WHERE
	f.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND ( length(trim(f.hometeamnotes)) > 0 OR length(trim(f.awayteamnotes)) > 0 )
	AND d.id = c1.divisionID
	AND f.HomeID = c1.ID 
	AND f.AwayID = c2.ID 
	AND t1.ID = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.ID = c2.TeamID 
	AND o2.id = c2.OrdinalID 
ORDER BY
	f.fixturedate, d.mediumcol
</cfquery>