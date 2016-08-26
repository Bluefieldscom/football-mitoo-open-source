<!--- called by GatherTeamsUnderClub.cfm --->
<cfquery name="QGetClubNames" datasource="zmast">
	SELECT
		ID,
		ClubName,
		CountyInfoID
	FROM
		clubinfo
	WHERE
		CountyInfoID = #CountyInfoID#
	ORDER BY
		ClubName
</cfquery>

