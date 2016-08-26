<!--- called by QGoalsScored_query2.cfm --->

<cfquery name="QCurrentTeam" datasource="#variables.dsn#">
	SELECT 
		zlkc1.id AS teamID, zlkd.id AS divisionID, zlkd.divisionname
 	FROM
		fm#getLeagueYear.leagueCodeYear#.fixture f
		JOIN fm#getLeagueYear.leagueCodeYear#.appearance a ON a.fixtureID = f.ID
		JOIN fm#getLeagueYear.leagueCodeYear#.constitution c ON 
			(c.ID = f.HomeID AND a.HomeAway = 'H')
		JOIN fm#getLeagueYear.leagueCodeYear#.division d ON d.ID = c.DivisionID
		JOIN zmast.lk_division zlkd ON zlkd.#getLeagueYear.leagueCodeYear#id = d.ID
		JOIN zmast.lk_constitution zlkc1 ON c.ID = zlkc1.#getLeagueYear.leagueCodeYear#id
	WHERE
		f.fixturedate = '#MostRecentDatePlayed#'
		AND d.leaguecode = '#arguments.league_code#'
		AND a.playerID = #playerID#
	UNION ALL
	SELECT 
		zlkc1.id AS teamID, zlkd.id AS divisionID, zlkd.divisionname
 	FROM
		fm#getLeagueYear.leagueCodeYear#.fixture f
		JOIN fm#getLeagueYear.leagueCodeYear#.appearance a ON a.fixtureID = f.ID
		JOIN fm#getLeagueYear.leagueCodeYear#.constitution c ON 
			(c.ID = f.AwayID AND a.HomeAway = 'A')
		JOIN fm#getLeagueYear.leagueCodeYear#.division d ON d.ID = c.DivisionID
		JOIN zmast.lk_division zlkd ON zlkd.#getLeagueYear.leagueCodeYear#id = d.ID
		JOIN zmast.lk_constitution zlkc1 ON c.ID = zlkc1.#getLeagueYear.leagueCodeYear#id
	WHERE
		f.fixturedate = '#MostRecentDatePlayed#'
		AND d.leaguecode = '#arguments.league_code#'
		AND a.playerID = #playerID#
</cfquery>	
<!--- 
removed from between second and third joins above: 
JOIN fm#getLeagueYear.leagueCodeYear#.team t ON t.ID = c.TeamID
JOIN zmast.lk_team zlkt ON zlkt.#getLeagueYear.leagueCodeYear#id = t.ID
--->	