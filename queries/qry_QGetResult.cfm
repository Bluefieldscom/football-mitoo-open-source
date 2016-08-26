<!--- called multiple times from ResultsGrid.cfm --->

<CFQUERY NAME="QGetResult" dbtype="query">
	SELECT
		FID, HomeID, AwayID, HomeGoals, AwayGoals, Result, FixtureDate, HomePointsAdjust, AwayPointsAdjust, Attendance, HideScore
	FROM 
		QResults 
	WHERE 
		HomeID = #QTeamList.CID# AND
		AwayID = #ListGetAt(CIDList, ColN)#
</cfquery>
