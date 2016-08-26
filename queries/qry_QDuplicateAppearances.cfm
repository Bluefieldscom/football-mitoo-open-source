<!--- called by CheckSpuriousDuplicates.cfm --->

<cfquery name="QDuplicateAppearances" datasource="#request.DSN#" >
	SELECT
		COUNT(PlayerID) as cnt,
		PlayerID,
		FixtureID,
		HomeAway, 
		Concat(LeagueCode,'2004') as Leaguecode
	FROM
		appearance
	GROUP BY
		FixtureID, HomeAway, PlayerID
	HAVING
		cnt > 1 <!--- COUNT(PlayerID) > 1 --->
	ORDER BY FixtureID	
</cfquery>
