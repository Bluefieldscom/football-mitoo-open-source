<!--- called from getTeamListByFixtureIdAndTeanID method of webServices.cfc --->

<!--- no need to run date query again, already run in 'played' query --->
<cfquery name="QPlayersWhoDidNotPlay_query" datasource="#variables.dsn#">
SELECT
	p.ID as PlayerID ,
	CASE
		WHEN p.Surname = '' THEN 'MISSING SURNAME' 
		ELSE p.Surname
	END
	as PlayerSurname,
	CASE
		WHEN p.Forename = '' THEN 'MISSING FORENAME' 
		ELSE p.Forename
	END
	as PlayerForename
FROM
	fixture AS f, 
	player AS p, 
	register AS r, 
	constitution AS c, 
	team AS t
WHERE
	c.LeagueCode = <cfqueryparam value = '#arguments.leaguecode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
 	AND f.ID = <cfqueryparam value = #arguments.fixture_id# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	<!--- AND 
	f.FixtureDate BETWEEN 
		IF(ISNULL(r.FirstDay), '1900-01-01', r.FirstDay)
		AND 
		IF(ISNULL(r.LastDay), '2099-12-31', r.LastDay) --->
	AND
	<cfif '#arguments.homeAway#' IS "H">
		f.HomeID = c.ID
	<cfelse>
		f.AwayID = c.ID
	</cfif>
	AND
	<cfif QPlayersWhoPlayed_query.RecordCount GT 0>
		p.ID NOT IN (#PlayerIDList#) AND
	</cfif>
 	c.TeamID = t.ID 
	AND t.ID = r.TeamID 
	AND r.PlayerID = p.ID
UNION <!--- this is for "Own Goal" --->
SELECT
	p.ID as PlayerID ,
	'        OG' as PlayerSurname, <!--- this is how get it to sort into first position , use spaces --->
	'        OG' as PlayerForename
FROM
	player p
WHERE
	p.LeagueCode = <cfqueryparam value = '#arguments.leaguecode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
 	AND p.ShortCol = 0 <!--- this is how we recognise "Own Goal" --->
 	<cfif QPlayersWhoPlayed_query.RecordCount GT 0>
		AND p.ID NOT IN (#PlayerIDList#)
	</cfif>	
ORDER BY
  	PlayerSurname, PlayerForename
</cfquery>

<cfloop query="QPlayersWhoDidNotPlay_query">
	<cfscript>
		QTeamListArray[#i#] 					= StructNew();
		QTeamListArray[#i#].player_id 			= #PlayerID#;
		QTeamListArray[#i#].player_first_name 	= #PlayerForename#;
		QTeamListArray[#i#].player_last_name 	= #PlayerSurname#;
		QTeamListArray[#i#].played 				= 'no';
		QTeamListArray[#i#].goals 				= 0;
		QTeamListArray[#i#].card				= 0;
		QTeamListArray[#i#].star				= 0;
		i++;				
	</cfscript>
</cfloop>
