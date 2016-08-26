<!--- called multiple times from ResultsGrid.cfm --->

<cfquery name="QGridAwayGames" dbtype="query">
	SELECT
		COUNT(*) as AwayGames
	FROM 
		QResults 
	WHERE 
		AwayID = #QTeamList.CID#
</cfquery>
