<!--- called from HospitalityTable.cfm --->

<cfquery name="QHospitalityTable1" datasource="#request.DSN#">
	SELECT
	DISTINCT t.LongCol as TeamName,
	o.LongCol as OrdinalName,
	cc.TeamID as TeamID,
	cc.OrdinalID as OID,
	(SELECT COALESCE(SUM(f.HospitalityMarks),0)  
		FROM
			fixture f, 
			constitution c 
		WHERE
			c.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND c.TeamID = cc.TeamID 
			AND c.OrdinalID = cc.OrdinalID 
			AND	f.HomeID = c.ID 
			AND	f.HospitalityMarks IS NOT NULL ) 
		as HMarks,
	(SELECT COUNT(f.HospitalityMarks)
		FROM
			fixture f, 
			constitution c 
		WHERE
			c.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND c.TeamID = cc.TeamID 
			AND c.OrdinalID = cc.OrdinalID 
			AND	f.HomeID = c.ID 
			AND	f.HospitalityMarks IS NOT NULL ) 
		as HMarkedGames
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
