<!--- Called by inclLeagueInfo.cfm --->
<cfquery name="QUpdateCounter02" datasource="FMPageCount">
	UPDATE
		pagecounter02
	SET 
		CounterValue = CounterValue + 1 
	WHERE
		CounterLeagueID = #request.LeagueID#
</cfquery>
