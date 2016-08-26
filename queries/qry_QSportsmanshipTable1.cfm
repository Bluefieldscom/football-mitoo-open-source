<!--- called from SportsmanshipTable.cfm --->

<cfquery name="QSportsmanshipTable1" datasource="#request.DSN#">
	SELECT
	DISTINCT t.LongCol as TeamName,
	o.LongCol as OrdinalName,
	cc.TeamID as TeamID,
	cc.OrdinalID as OID,
	(SELECT COALESCE(SUM(f.HomeSportsmanshipMarks),0)  
		FROM
			fixture f, 
			constitution c 
		WHERE
			c.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND c.TeamID = cc.TeamID 
			AND c.OrdinalID = cc.OrdinalID 
			AND	f.HomeID = c.ID 
			AND	f.HomeSportsmanshipMarks IS NOT NULL ) 
		as HMarks,
	(SELECT	COALESCE(SUM(f.AwaySportsmanshipMarks),0)  
		FROM
			fixture f, 
			constitution c 
		WHERE
			c.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND c.TeamID = cc.TeamID 
			AND c.OrdinalID = cc.OrdinalID 
			AND	f.AwayID = c.ID 
			AND	f.AwaySportsmanshipMarks IS NOT NULL ) 
		as AMarks,
	(SELECT COUNT(f.HomeSportsmanshipMarks)
		FROM
			fixture f, 
			constitution c 
		WHERE
			c.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND c.TeamID = cc.TeamID 
			AND c.OrdinalID = cc.OrdinalID 
			AND	f.HomeID = c.ID 
			AND	f.HomeSportsmanshipMarks IS NOT NULL ) 
		as HMarkedGames,
	(SELECT COUNT(f.AwaySportsmanshipMarks)  
		FROM
			fixture f, 
			constitution c 
		WHERE
			c.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND c.TeamID = cc.TeamID 
			AND c.OrdinalID = cc.OrdinalID 
			AND	f.AwayID = c.ID 
			AND	f.AwaySportsmanshipMarks IS NOT NULL ) 
		as AMarkedGames
FROM
	team AS t,
	ordinal AS o,
	constitution AS cc	
WHERE
	cc.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND t.ID NOT IN
		(SELECT ID 
			FROM 
				team 
			WHERE
				LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND (LEFT(Notes,7) = 'NoScore' 
					OR ShortCol = 'GUEST' 
					OR LongCol IS NULL
					OR LongCol LIKE '%(WITHDRAWN)%' ) ) 
	AND o.ID NOT IN
		(SELECT ID 
			FROM 
				ordinal 
			WHERE
				LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND LongCol LIKE '%(WITHDRAWN)%' ) 
	AND t.ID = cc.TeamID 
	AND o.ID = cc.OrdinalID
</cfquery>
