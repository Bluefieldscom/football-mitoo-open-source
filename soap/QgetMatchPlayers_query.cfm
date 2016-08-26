<!--- 
	called from getTeamListByFixtureIdAndTeamID method of webServices.cfc 
	and twice from getAllFixtureInfoByIdAndLeagueCode method of webServices.cfc	
--->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery NAME="QPlayersWhoPlayed_query" datasource="#variables.dsn#">
SELECT
	CASE
		WHEN p.shortcol = 0 THEN '        OG' 
		WHEN p.Surname = '' THEN 'xxxxxxxxxx' 
		ELSE p.Surname
	END
	as PlayerSurname,
	CASE
		WHEN p.shortcol = 0 THEN '        OG' 
		WHEN p.Forename = '' THEN 'xxxxxxxxxx' 
		ELSE p.Forename
	END
	as PlayerForename,
	p.ID as PlayerID ,
	a.GoalsScored as GoalsScored ,
	a.Card as Card ,
	a.StarPlayer as StarPlayer
FROM
	player AS p, 
	appearance AS a
WHERE
	p.LeagueCode = <cfqueryparam value = '#arguments.leaguecode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND a.FixtureID = <cfqueryparam value = #arguments.fixture_id# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	AND a.HomeAway = '#arguments.homeAway#' 
	AND a.PlayerID = p.ID
ORDER BY
	PlayerSurname, PlayerForename
</cfquery>

<cfset PlayerIDList = ValueList(QPlayersWhoPlayed_query.PlayerID)>

<cfset i=1>
<!--- additional processing for undeclared players --->
<cfif QPlayersWhoPlayed_query.recordCount GT 0>
	<cfloop query="QPlayersWhoPlayed_query">
		<cfscript>
			QTeamListArray[#i#] 					= StructNew();
			QTeamListArray[#i#].player_id 			= #PlayerID#;
			QTeamListArray[#i#].player_first_name 	= #PlayerForename#;
			QTeamListArray[#i#].player_last_name 	= #PlayerSurname#;
			QTeamListArray[#i#].played 				= 'yes';
			QTeamListArray[#i#].goals 				= #GoalsScored#;
			QTeamListArray[#i#].card				= #Card#;
			QTeamListArray[#i#].star				= #StarPlayer#;
			i++;				
		</cfscript>
	</cfloop>
<cfelse>
		<cfset QTeamListArray = ArrayNew(1)>
</cfif>
