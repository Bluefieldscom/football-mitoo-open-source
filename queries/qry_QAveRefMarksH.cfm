<!--- called by AverageRefMarks.cfm --->

<cfquery name="QAveRefMarksH" datasource="#request.DSN#" >
	SELECT
		t.ID as HTID,
		o.ID as HOID,
		t.LongCol as TeamName,
		o.LongCol as OrdinalName,
		COALESCE(SUM(f.RefereeMarksH),0) as SumRefereeMarksH,
		COUNT(*) as HGames
	FROM
		fixture AS f,
		constitution AS c,
		team AS t,
		ordinal AS o
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND t.ID NOT IN
			(SELECT ID 
				FROM team 
				WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
					AND LEFT(Notes,7) = 'NoScore' 
					OR ShortCol = 'GUEST' OR LongCol IS NULL ) 
		AND f.ID NOT IN 
			(SELECT ID 
				FROM fixture 
				WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
					AND RefereeMarksH IS NULL) 
		AND t.ID = c.TeamID 
		AND o.ID = c.OrdinalID 
		AND f.HomeID = c.ID
	GROUP BY
		HTID, HOID, TeamName, OrdinalName <!--- t.ID, o.ID, t.LongCol, o.LongCol --->
	HAVING
		SumRefereeMarksH > 0 <!--- SUM(f.RefereeMarksH) > 0 --->
</cfquery>