<!--- called by ClubList.cfm --->
<cfquery name="QSeasonsTeamInfo" datasource="zmast" >
	SELECT
		ti.id,
		ti.fmTeamID,
		ti.LeagueInfoID,
		ti.ClubInfoID,
		li.LeagueCodeYear, 
		li.NameSort, 
		li.SeasonName,
		li.DefaultLeagueCode,
		li.badgejpeg
	FROM
		teaminfo ti, 
		leagueinfo li
	WHERE
		ti.ClubInfoID = #ClubInfoID#
		AND li.ID = ti.LeagueInfoID
		AND li.LeagueCodeYear = #ThisLeagueCodeYear#
	ORDER BY
		li.NameSort
</cfquery>
