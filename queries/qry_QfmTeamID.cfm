<!--- called by GatherTeamsUnderClub.cfm  --->
<cfquery name="QfmTeamID" dbtype="query">
	SELECT
		DISTINCT fmTeamID, LeagueInfoID, ClubName, LeagueName, Season, CountiesList
	FROM
		QGatheredTeam 
	WHERE
		fmTeamID NOT IN (#fmTeamIDList#) <!--- don't consider any that are already showing in the Included list above --->
	ORDER BY
		ClubName, LeagueName, Season DESC
</cfquery>
