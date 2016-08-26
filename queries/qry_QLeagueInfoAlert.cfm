<!--- called by SecurityCheck.cfm --->

<cfquery name="QLeagueInfoAlert" datasource="zmast">
	SELECT
		LeagueName,
		Alert
	FROM
		leagueinfo
	WHERE
		DefaultLeagueCode = '#form.LeagueCode#'
</cfquery>
