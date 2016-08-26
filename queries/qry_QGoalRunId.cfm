<!--- called by toolbar2.cfm --->
<cfquery name="QGoalRunId" datasource="zmast">
	SELECT
		m.MitooDotComID,
		m.DefaultDID,
		li.namesort as ThisLeagueName
	FROM
		migration2 m,
		leagueinfo li
	WHERE
		m.LeagueCodePrefix = '#LeagueCodePrefix#'
		AND m.leaguecodeprefix=li.leaguecodeprefix
		AND li.leaguecodeyear=#LeagueCodeYear#
		AND RIGHT(DefaultLeagueCode,4) = #CopyrightYear# <!--- needs to be changed for a new season --->
		AND LEFT(CountiesList,4) <> 'TEST'
		AND LENGTH(LeagueName) > 8
		
</cfquery>
