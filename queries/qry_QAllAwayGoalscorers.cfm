<!--- called by InclGoalscorerInfo.cfm --->

<CFQUERY NAME="QAllAwayGoalscorers" datasource="#request.DSN#">
	SELECT
		a.FixtureID,
		CASE
			WHEN p.shortcol = 0 THEN 'Own Goal'
			ELSE p.Surname
		END
		as PlayerSurname,
		CASE
			WHEN p.shortcol = 0 THEN '-' 
			WHEN p.Forename = '' THEN '-'
			ELSE p.Forename
		END
		as PlayerForename,
		a.GoalsScored
	FROM
		appearance a INNER JOIN player p ON a.PlayerID = p.ID		
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.HomeAway = 'A' 						
		AND a.FixtureID IN (#FIDList#) 
		AND a.GoalsScored > 0 
</cfquery>

