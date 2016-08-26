<!--- Called by inclLeagueInfo.cfm --->
<cfquery name="QUpdateCounter" datasource="FMPageCount">
	UPDATE
		pagecounter
	SET 
		CounterValue = CounterValue + 1 
	WHERE
		CounterLeagueID = #request.LeagueID#
</cfquery>
