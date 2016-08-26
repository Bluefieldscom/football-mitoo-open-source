<!--- called by getTeamAllConsFixtures and getLeagueFixtures functions --->

<cfquery name="QLeagueEventText" datasource="#variables.dsn#">
	SELECT 
		EventText 
	FROM 
		fm#getLeagueYear.leagueCodeYear#.event
	WHERE 
		eventdate = '#FixtureDate#'
		AND leaguecode = '#arguments.league_code#'		
</cfquery>


