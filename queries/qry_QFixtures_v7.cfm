<!--- called by RefAnalysis.cfm --->

<cfquery name="QFixtures" datasource="#request.DSN#" >
	SELECT
		COUNT(*) AS GamesPlayed
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
