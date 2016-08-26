<!--- called by MtchDayGSXLS.cfm --->
<cfquery NAME="QGoalscorersH" dbtype="query">
	SELECT 
		PlayerSurname,
		PlayerForename,
		GoalsScored
	FROM
		QAllHomeGoalScorers
	WHERE
		FixtureID = #QFixtures.FID#
	ORDER BY
		PlayerSurname, PlayerForename
</cfquery>
