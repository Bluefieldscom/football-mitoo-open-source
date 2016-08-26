<!---<cfinclude template="QgetLeagueYearFromDates2.cfm">--->
<!---

<cfset arguments.league_code = 'SSFL'>
<cfset arguments.division_id = '6610'>
<cfset arguments.start_date = '2010-07-01'>
<cfset arguments.end_date   = '2010-07-30'>
<cfset arguments.limit     = '20'>
<cfset arguments.order = 'DESC'>

<cfinclude template="QgetLeagueYearFromDates3.cfm">
<cfif inSeason IS 0>
	<cfscript> QFixtures[1] = StructNew(); </cfscript>
	<cfreturn QFixtures>
</cfif>	
--->



<cfquery name="QGoalsScored_query" datasource="#variables.dsn#" maxrows="40">
	SELECT
		DATE_FORMAT(MAX(f.FixtureDate), '%Y-%m-%d') AS MostRecentDatePlayed,
		a.PlayerID as PlayerID,
		p.Surname,
		p.Forename, 
		p.ShortCol as PlayerNo,
		o.LongCol as OrdinalName, 
		COUNT(p.ID) as GamesPlayed,
		COALESCE(SUM(a.GoalsScored),0) as GoalsScored,
		(SELECT t.LongCol as TeamName  FROM 
					fm#getLeagueYear.leagueCodeYear#.register r, 
					fm#getLeagueYear.leagueCodeYear#.team t 
				WHERE r.playerid=a.PlayerID AND r.teamid=t.id AND
				MAX(f.fixturedate) BETWEEN 
					CASE
					WHEN r.FirstDay IS NULL
					THEN '1900-01-01'
					ELSE r.FirstDay
					END
			 	AND 
					CASE
					WHEN r.LastDay IS NULL
					THEN '2999-12-31'
					ELSE r.LastDay
					END ) 
		as LastAppearedFor,
		(SELECT t.LongCol as TeamName  FROM 
				fm#getLeagueYear.leagueCodeYear#.register r, 
				fm#getLeagueYear.leagueCodeYear#.team t 
				WHERE r.playerid=a.PlayerID AND r.teamid=t.id AND
				Now() BETWEEN 
					CASE
					WHEN r.FirstDay IS NULL
					THEN '1900-01-01'
					ELSE r.FirstDay
					END
			 	AND 
					CASE
					WHEN r.LastDay IS NULL
					THEN '2999-12-31'
					ELSE r.LastDay
					END ) 
		as CurrentlyRegisteredTo
		<!---
		,
		(SELECT count(id)  FROM register r where r.playerid=a.PlayerID ) as NumberOfRegistrations
		--->
	FROM
		fm#getLeagueYear.leagueCodeYear#.appearance AS a,
		fm#getLeagueYear.leagueCodeYear#.player AS p,
		fm#getLeagueYear.leagueCodeYear#.division d,
		fm#getLeagueYear.leagueCodeYear#.constitution c,
		fm#getLeagueYear.leagueCodeYear#.ordinal o,
		fm#getLeagueYear.leagueCodeYear#.fixture f,
		zmast.lk_division zlkd
	WHERE 
		p.LeagueCode = '#arguments.league_code#'
		AND c.DivisionID = zlkd.#getLeagueYear.leagueCodeYear#id
		AND p.shortcol <> 0 
		AND p.ID = a.PlayerID
		AND c.DivisionID = d.ID
		AND a.fixtureid=f.id
		AND f.HomeID=c.id
		AND o.ID = c.OrdinalID
		AND  zlkd.id = '#arguments.division_id#'
	GROUP BY
		PlayerID, Surname, Forename, PlayerNo
	HAVING
		GoalsScored > 0
	ORDER BY
		GoalsScored DESC, Surname, Forename		
</cfquery>		





<cfif IsDefined("QGoalsScored_query") AND QGoalsScored_query.recordCount GT 0>
	<cfset i=1>
	<cfloop query="QGoalsScored_query">
		<cfinclude template="QCurrentTeam_query.cfm">
		<cfscript>
			QLeagueLeadingGoalScorers[#i#]							= StructNew();
			QLeagueLeadingGoalScorers[#i#].team_name				= #CurrentlyRegisteredTo#;
			QLeagueLeadingGoalScorers[#i#].ordinal_name				= #OrdinalName#;
			QLeagueLeadingGoalScorers[#i#].most_recent_date_played	= DateFormat(#MostRecentDatePlayed#,'yyyy-mm-dd');
			QLeagueLeadingGoalScorers[#i#].player_id				= #playerid#;
			QLeagueLeadingGoalScorers[#i#].player_last_name			= #surname#;
			QLeagueLeadingGoalScorers[#i#].player_first_name		= #forename#;
			QLeagueLeadingGoalScorers[#i#].played					= #gamesPlayed#;
			QLeagueLeadingGoalScorers[#i#].goals					= #GoalsScored#;
			QLeagueLeadingGoalScorers[#i#].team_id					= #QCurrentTeam.TeamID#;
			i++;
		</cfscript>
	</cfloop>
	<cfif i IS 1>
		<cfscript>
		QLeagueLeadingGoalScorers[#i#] = StructNew();
		i++;
	</cfscript>
	</cfif>
<cfelse>
	<cfset i=1>
	<!-- add message in here somewhere -->
	<cfscript>
		QLeagueLeadingGoalScorers[#i#] = StructNew();
		i++;
	</cfscript>
</cfif>	
<!---<cfdump var="#QLeagueLeadingGoalScorers#">--->