<!--- called by Calendar.cfm and RefAvailable.cfm --->

<cfquery name="RefYesAvailable" datasource="#request.DSN#">
	SELECT
		DAY(MatchDate) as s_day ,
		MONTH(MatchDate) as s_month
	FROM
		refavailable
	WHERE
		LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND RefereeID = #ThisRefereeID#
		AND MONTH(MatchDate) = #ThisMonth#
		AND Available = 'Yes'
	ORDER BY
		s_day
</cfquery>