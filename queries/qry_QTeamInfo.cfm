<!--- called by GatherTeamsUnderClub.cfm  --->
<cfquery name="QTeamInfo" datasource="zmast" >
	SELECT
		ti.id,
		ti.fmTeamID,
		ti.LeagueInfoID,
		ti.ClubInfoID,
		li.LeagueCodeYear, 
		li.NameSort, 
		li.SeasonName,
		li.DefaultLeagueCode
	FROM
		teaminfo ti, 
		leagueinfo li
	WHERE
		ti.ClubInfoID = #ClubInfoID#
		AND li.ID = ti.LeagueInfoID
	ORDER BY
		li.SeasonName DESC, li.NameSort
</cfquery>
