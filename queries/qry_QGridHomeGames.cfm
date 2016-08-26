<!--- called multiple times from ResultsGrid.cfm --->

<cfquery name="QGridHomeGames" dbtype="query">
	SELECT
		COUNT(*) as HomeGames
	FROM 
		QResults 
	WHERE 
		HomeID = #QTeamList.CID#
</cfquery>
