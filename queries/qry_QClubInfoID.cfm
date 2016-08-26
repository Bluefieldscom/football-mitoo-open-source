<!--- called by ClubList.cfm --->
<cfquery name="QClubInfoID" datasource="zmast">
	SELECT
		ClubInfoID,
		ClubName
	FROM 
		teaminfo,
		clubinfo
	WHERE 
		teaminfo.fmTeamID = #url.fmTeamID#
		AND teaminfo.LeagueInfoID = #request.LeagueID#
		AND teaminfo.ClubInfoID = clubinfo.ID
</cfquery>
