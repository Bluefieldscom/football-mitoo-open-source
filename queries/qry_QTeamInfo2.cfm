<!--- called by ClubList.cfm --->

<cfquery name="QTeamInfo2" datasource="zmast">
	SELECT
		ClubInfoID,
		ClubName,
		Location
	FROM 
		teaminfo,
		clubinfo
	WHERE 
		teaminfo.fmTeamID = #ListGetAt(IDList, RowN)#
		AND teaminfo.LeagueInfoID = #request.LeagueID#
		AND teaminfo.ClubInfoID = clubinfo.ID
</cfquery>
