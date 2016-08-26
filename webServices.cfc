<cfcomponent>

	<cffunction name="_methodVerifyUser" access="public">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfset variables.userpermitted = 0>
	</cffunction>

	<cffunction name="getAllLeagues" access="remote" returntype="array" output="no">
		<cfset var QAllLeagues = ArrayNew(1)>
		<cfquery name="QAllLeagues_query" datasource="ZMAST">
			SELECT
				id as mitoo_league_id,
				leaguename as gr_league_name,
				leaguecodeprefix as mitoo_league_prefix
			FROM
				(SELECT * FROM leagueinfo ORDER BY DEFAULTLEAGUECODE DESC) as temp
			GROUP BY
					LeagueCodePrefix
		</cfquery>
		<cfset i=1>
		<cfloop query="QAllLeagues_query">
			<cfscript>
				QAllLeagues[#i#] = StructNew();
				QAllLeagues[#i#].mitoo_league_id = #mitoo_league_id#;
				QAllLeagues[#i#].gr_league_name = #gr_league_name#;
				QAllLeagues[#i#].mitoo_league_prefix = #mitoo_league_prefix#;
			</cfscript>
			<cfset i=i+1>
		</cfloop>
		<cfreturn QAllLeagues>
	</cffunction>

	<cffunction name="getDivisionsByID" access="remote" returntype="array" output="no">
		<cfargument name="LeagueCode" type="string" required="true">
		<cfset var QDivisionsByLeagueIDArray = ArrayNew(1)>
		<cfquery name="QDivisionsByLeagueID" datasource="FM2008">
			SELECT
					id as mitoo_division_id,
					longcol as gr_division_name
			FROM
					division d
			WHERE
					d.LeagueCode = '#arguments.LeagueCode#'
		</cfquery>
		<cfset i=1>
		<cfloop query="QDivisionsByLeagueID">
			<cfscript>
				QDivisionsByLeagueIDArray[#i#] = StructNew();
				QDivisionsByLeagueIDArray[#i#].mitoo_division_id = #mitoo_division_id#;
				QDivisionsByLeagueIDArray[#i#].gr_division_name = #gr_division_name#;
			</cfscript>
			<cfset i=i+1>
		</cfloop>
		<cfreturn QDivisionsByLeagueIDArray>
	</cffunction>

	<cffunction name="getTeamsByDivision" access="remote" returntype="array" output="no">
		<cfargument name="divisionID" type="numeric" required="true">
		<cfset var QTeamsByDivisionArray = ArrayNew(1)>
		<cfquery name="QTeamsByDivision" datasource="FM2008">
			SELECT
				t.ID AS mitoo_team_id, t.longcol AS gr_team_name
			FROM
				team AS t
			JOIN
				constitution AS c ON t.ID = c.TeamID
			WHERE
				c.DivisionID = #arguments.divisionID#
				AND t.mediumcol IS NOT NULL
				AND shortcol != 'guest'
				AND shortcol != 'Guest'
			ORDER BY gr_team_name
		</cfquery>
		<cfset i=1>
		<cfloop query="QTeamsByDivision">
			<cfscript>
				QTeamsByDivisionArray[#i#] = StructNew();
				QTeamsByDivisionArray[#i#].mitoo_team_id = #mitoo_team_id#;
				QTeamsByDivisionArray[#i#].gr_team_name = #gr_team_name#;
			</cfscript>
			<cfset i = i+1>
		</cfloop>
		<cfreturn QTeamsByDivisionArray>
	</cffunction>

	<cffunction name="getPlayersByTeam" access="remote" returntype="array" output="no">
		<cfargument name="teamID" type="numeric" required="true">
		<cfset var QPlayersByTeamArray = ArrayNew(1)>
		<cfquery name="QPlayersByTeam" datasource="FM2008">
			SELECT
				p.ID AS mitoo_player_id, p.forename AS gr_player_firstname, p.surname AS gr_player_lastname
			FROM
				player p
			JOIN
				register AS r ON p.ID = r.PlayerID
			WHERE
				r.TeamID = #arguments.teamID#
				AND p.surname != 'OwnGoal'
			ORDER BY gr_player_lastname
		</cfquery>
		<cfset i=1>
		<cfloop query="QPlayersByTeam">
			<cfscript>
				QPlayersByTeamArray[#i#] = StructNew();
				QPlayersByTeamArray[#i#].mitoo_player_id = #mitoo_player_id#;
				QPlayersByTeamArray[#i#].gr_player_firstname = #gr_player_firstname#;
				QPlayersByTeamArray[#i#].gr_player_lastname = #gr_player_lastname#;
			</cfscript>
			<cfset i = i+1>
		</cfloop>
		<cfreturn QPlayersByTeamArray>
	</cffunction>


	<cffunction name="getMessage" access="remote" returntype="string" output="no">
		<cfargument name="name" type="string" required="yes">
		<cfreturn "Hello " & arguments.name & "! " & "I've been invoked as a web service.">
	</cffunction>

	<cffunction name="_methodConvertLeagueCode" access="public">
		<cfargument name="LeagueCode" type="string" required="true">
		<cfset request.LeagueCode = arguments.LeagueCode>
		<cfif IsNumeric(RIGHT(request.LeagueCode,4))>
			<cfset request.DSN = 'fm' & RIGHT(request.LeagueCode,4)>
			<cfset request.filter = Left(request.LeagueCode, (Len(TRIM(request.LeagueCode))-4))>
   		</cfif>
	</cffunction>

	<cffunction name="getLeagueTable" access="remote" returntype="struct" output="no">
		<cfargument name="LeagueCode" type="string" required="true">
		<cfargument name="DivisionID" type="numeric" required="true">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfset var QResult = StructNew()>
		<cfset _methodVerifyUser(arguments.username, arguments.password)>
		<cfif variables.userpermitted EQ 1>
			<cfset _methodConvertLeagueCode(arguments.LeagueCode)>

			<cfquery name="DivName" datasource="#request.DSN#">
				SELECT
					d.longcol as DivisionName
				FROM
					leaguetable l
					JOIN
					division d ON d.ID = l.DivisionID
				WHERE
					l.DivisionID = #arguments.DivisionID#
			</cfquery>
			<cfquery name="LeagueTable" datasource="#request.DSN#">
				SELECT
					l.Name AS `Team Name`,
					l.rank AS Rank,
					(l.HomePoints + l.HomePointsAdjust + l.AwayPoints +
							l.AwayPointsAdjust + l.PointsAdjustment) AS `Total Points`,
					(l.HomeGamesPlayed + l.AwayGamesPlayed) AS `Total Played`,
					(l.HomeGoalsFor + l.AwayGoalsFor) AS `Total Goals For`,
					(l.HomeGoalsAgainst + l.AwayGoalsAgainst) AS `Total Goals Against`,
					(l.HomeGamesWon + l.AwayGamesWon) AS `Total Games Won`,
					(l.HomeGamesDrawn + l.AwayGamesDrawn) AS `Total Games Drawn`,
					(l.HomeGamesLost + l.AwayGamesLost) AS `Total Games Lost`,
					(l.HomePointsAdjust + l.AwayPointsAdjust + l.PointsAdjustment) AS `Total Points Adjustment`
				FROM
					leaguetable l JOIN division d ON d.ID = l.DivisionID
				WHERE
					l.DivisionID = #arguments.DivisionID#
				ORDER BY
					Rank
			</cfquery>
			<cfset QResult.DivName = DivName.DivisionName>
			<cfset QResult.LeagueTable = LeagueTable>
		<cfelse>
			<cfset QResult.DivName = "No way Jose">
		</cfif>
		<cfreturn QResult>

	</cffunction>

	<cffunction name="getAnnouncementNotes" access="remote" returntype="any" output="no">
		<cfargument name="LeagueCode" type="string" required="yes">
		<cfset var Notes = ''>
		<cfset _methodConvertLeagueCode(arguments.LeagueCode)>
		<cfinclude template="queries/qry_Announcement.cfm">
		<cfset Notes = #Announcement.Notes#>
		<cfreturn Notes>
	</cffunction>

	<cffunction name="getCounties" access="remote" returntype="query" output="no">
		<cfset var QCounty = ''>
		<cfquery name="QCounty" datasource="zmast">
		SELECT
			countycode,
			countyname
		FROM
			countyinfo
		ORDER BY
			countyname
		</cfquery>
		<cfreturn QCounty>
	</cffunction>

</cfcomponent>
