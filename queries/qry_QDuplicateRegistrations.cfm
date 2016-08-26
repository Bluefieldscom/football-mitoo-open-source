<!--- called by CheckSpuriousDuplicates.cfm --->

<cfquery name="QDuplicateRegistrations" datasource="#request.DSN#" >
	SELECT
		COUNT(PlayerID) as cnt,
		PlayerID,
		TeamID,
		Concat(LeagueCode,'2004') as Leaguecode
	FROM
		register
	GROUP BY
		PlayerID, TeamID
	HAVING
		cnt > 1
	ORDER BY Leaguecode, TeamID, PlayerID
</cfquery>
