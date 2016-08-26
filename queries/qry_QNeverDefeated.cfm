<!--- called by Unsched.cfm --->
		
<cfquery name="QNeverDefeated" dbtype="query" >
	SELECT
		ConstitutionID
	FROM
		QNewLeagueTable
	WHERE
		((HomeGamesPlayed + AwayGamesPlayed) = 0) OR ((HomeGamesLost + AwayGamesLost) = 0)
</cfquery>

<!--- this query is to see if a team has lost in a cup competition on penalties (see NeverDefeatedList),
the score should be a draw, used for KO matches
to see if a team is included in the unscheduled list of matches in the next round --->
