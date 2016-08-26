<!--- called multiple times from ResultsGrid.cfm --->

<CFQUERY NAME="QGetMOExpenses" dbtype="query">
	SELECT
		MatchOfficialsExpenses
	FROM 
		QMatchOfficialsExpenses2 
	WHERE 
		HomeID = #QTeamList.CID# AND
		AwayID = #ListGetAt(CIDList, ColN)#
</cfquery>
