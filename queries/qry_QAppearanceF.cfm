<!--- called by CheckRule12SineDie.cfm --->
<cfquery Name="QAppearanceF"  datasource="#request.DSN#" >
	SELECT
		a.FixtureID
		<!---
		f.FixtureDate,
		a.HomeAway,
		c.DivisionID
		--->
	FROM
		appearance a
		<!---
		fixture f,
		constitution c
		--->
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.PlayerID = #QSurnamesDobs.ID#
		<!---
		AND a.FixtureID = f.ID
		AND f.HomeID = c.ID
		--->
</cfquery>
