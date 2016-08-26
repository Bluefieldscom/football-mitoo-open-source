<!--- called by MtchDayGSXLS.cfm --->
<cfquery NAME="QGoalscorersA" dbtype="query">
	SELECT 
		PlayerSurname,
		PlayerForename,
		GoalsScored
	FROM
		QAllAwayGoalScorers
	WHERE
		FixtureID = #QFixtures.FID#
	ORDER BY
		PlayerSurname, PlayerForename
</cfquery>
