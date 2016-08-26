<cfquery name="RefYesAvailable" datasource="#request.DSN#">
	SELECT
		DAY(MatchDate) as s_day,
		MONTH(MatchDate) as s_month
	FROM
		refavailable 
	WHERE
		LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND RefereeID = #URL.RefereeID#
		AND MONTH(MatchDate) = #URL.month_to_view#
		AND Available = 'Yes'
	ORDER BY
		s_day
</cfquery>