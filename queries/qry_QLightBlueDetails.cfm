<!--- Called by ExportLightBlueXLS.cfm --->

<CFQUERY NAME="QLightBlueDetails" datasource="#request.DSN#">
	SELECT
		li.namesort,
		c.leaguecode,
		c.longCol as Position,
		c.EmailAddress1,
		c.EmailAddress2,
		c.Surname,
		c.Forename
	FROM
		committee c,
		zmast.leagueinfo li
	WHERE
		li.leaguecodeprefix = c.leaguecode
		AND li.leaguecodeyear = '#right(request.dsn,4)#'
	ORDER BY
		li.namesort, c.Surname, c.Forename
</cfquery>
