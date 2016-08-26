<!--- called by EventCalendarShow.cfm --->

<cfquery name="GetEvents" datasource="#request.DSN#">
	SELECT
		ID ,
		EventText ,
		EventDate
	FROM
		event 
	WHERE
		LeagueID = #request.LeagueID#
		AND #URL.event_date# = EventDate 
</cfquery>