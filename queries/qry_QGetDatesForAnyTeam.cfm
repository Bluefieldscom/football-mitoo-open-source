<!--- called by FutureScheduledDates.cfm  --->
<cfquery NAME="QGetDatesForAnyTeam" datasource="#request.DSN#">
	SELECT
		f.ID as FID
	FROM
		fixture f
	WHERE
		f.leaguecode='#LeagueCodePrefix#'
		AND f.fixturedate = '#DateFormat(ThisDate,"YYYY-MM-DD")#'
</cfquery>
