<!--- called by AverageRefMarks.cfm --->

<cfquery name="QAveRefMarksA" datasource="#request.DSN#" >
	SELECT
		t.ID as ATID,
		o.ID as AOID,
		t.LongCol as TeamName,
		o.LongCol as OrdinalName,
		COALESCE(SUM(f.RefereeMarksA),0) as SumRefereeMarksA,
		COUNT(*) as AGames
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
					OR ShortCol = 'GUEST' 
					OR LongCol IS NULL ) 
		AND f.ID NOT IN 
			(SELECT ID 
				FROM fixture 
				WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND RefereeMarksA IS NULL) 
		AND t.ID = c.TeamID 
		AND o.ID = c.OrdinalID 
		AND f.AwayID = c.ID
	GROUP BY
		ATID, AOID, TeamName, OrdinalName <!--- t.ID, o.ID, t.LongCol, o.LongCol --->
	HAVING
		SumRefereeMarksA > 0 <!--- SUM(f.RefereeMarksA) > 0 --->
</cfquery>