<!--- called by AverageRefMarks.cfm --->

<cfquery name="HRefsMarks" datasource="#request.DSN#">
	SELECT
		f.ID,
		f.RefereeMarksH,
		f.HomeGoals,
		f.AwayGoals,
		f.FixtureDate,
		f.Result,
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RName ,
		(SELECT LongCol 
			FROM constitution, team 
			WHERE 
				constitution.ID = f.AwayID 
				AND team.ID = constitution.TeamID) 
			as OpponentsTeam,
		(SELECT LongCol 
			FROM constitution, ordinal 
			WHERE 
				constitution.ID = f.AwayID 
				AND ordinal.ID = constitution.OrdinalID) 
			as OpponentsOrdinal
	FROM
		fixture AS f,
		constitution AS c,
		team AS t,
		ordinal AS o,
		referee AS r
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID NOT IN 
			(SELECT ID FROM fixture WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND RefereeMarksH IS NULL) 
		AND t.ID = <cfqueryparam value = #TID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND o.ID = <cfqueryparam value = #OID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND f.HomeID = c.ID 
		AND c.TeamID = t.ID 
		AND c.OrdinalID = o.ID 
		AND f.RefereeID = r.ID
	ORDER BY 
		FixtureDate
</cfquery>
