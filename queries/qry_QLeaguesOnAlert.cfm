<!--- called by LeaguesOnAlert.cfm --->

<cfquery name="QLeaguesOnAlert" datasource="ZMAST" >
SELECT
	namesort,
	defaultleaguecode
FROM
	leagueinfo
WHERE
	alert=1
ORDER BY
	namesort
</cfquery>
