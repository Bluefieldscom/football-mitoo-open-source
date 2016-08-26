<!--- called by ClubList.cfm --->
<cfquery name="QClubInfo1" datasource="zmast">
	SELECT
		ClubName,
		Location
	FROM 
		clubinfo
	WHERE 
		ID = #QTeamInfo1.CIID#
</cfquery>
