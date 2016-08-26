<!--- Called by inclLeagueInfo.cfm --->
<cfquery name="QUpdateCounter01" datasource="FMPageCount">
	UPDATE
		pagecounter01
	SET 
		CounterValue = CounterValue + 1 
	WHERE
		CounterLeagueID = #request.LeagueID#
</cfquery>
