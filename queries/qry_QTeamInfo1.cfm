<!--- called by ClubList.cfm --->

<cfquery name="QTeamInfo1" datasource="zmast">
	SELECT
		ti.ClubInfoID as CIID,
		ti.ID as TIID,
		ti.fmTeamID,
		ti.LeagueInfoID,
		ti.ClubInfoID,
		li.id as LIID
	FROM 
		teaminfo ti,
		leagueinfo li
	WHERE 
		li.ID = #request.LeagueID# 
		AND ti.fmTeamID = #url.fmTeamID#
		AND ti.LeagueInfoID = li.ID
</cfquery>
