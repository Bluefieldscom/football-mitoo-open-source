<cfquery name="MonthsEvents" datasource="#request.DSN#">
	SELECT
		DAY(EventDate) as s_day,
		MONTH(EventDate) as s_month
	FROM
		event 
	WHERE
		LeagueID = #request.LeagueID#
		AND MONTH(eventdate) = #URL.month_to_view#
	ORDER BY
		s_day
</cfquery>