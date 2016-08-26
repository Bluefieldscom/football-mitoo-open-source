<!--- called by getDivisionFixtures function within QFixtures_query2 --->

<cfquery name="QEventText" datasource="#variables.dsn#">

	SELECT 
		e.EventText 
	FROM 
		zmast.leagueinfo zmli
		JOIN zmast.lk_division zmlkd ON zmlkd.#getLeagueYear.leagueCodeYear#id =  zmli.defaultdivisionid
		JOIN fm#getLeagueYear.leagueCodeYear#.event e ON zmli.id = e.leagueid
	WHERE 
		zmlkd.id = #arguments.division_id#
		AND eventDate = '#FixtureDate#'

</cfquery>


