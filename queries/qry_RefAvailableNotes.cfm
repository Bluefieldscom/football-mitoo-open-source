<cfquery name="RefAvailableNotes" datasource="#request.DSN#">
	SELECT
		DAY(MatchDate) as s_day ,
		MONTH(MatchDate) as s_month,
		Notes
	FROM
		refavailable
	WHERE
		LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND RefereeID = #ThisRefereeID#
		AND MONTH(MatchDate) = #ThisMonth#
		AND Length(Trim(Notes)) > 0
	ORDER BY
		s_day
</cfquery>
