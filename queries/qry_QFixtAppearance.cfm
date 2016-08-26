<!--- Called by MissingAppearances.cfm and MissingGoalScorers.cfm --->

<cfquery name="QFixtAppearance" datasource="#request.DSN#" >
	SELECT
		DISTINCT a.FixtureID as ID
	FROM
		appearance AS a,
		fixture AS f
	WHERE
		f.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID = a.FixtureID
</cfquery>
