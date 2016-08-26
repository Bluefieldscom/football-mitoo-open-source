<cfquery name="QBatchLoadFixturesH" datasource="#request.DSN#">
	SELECT
		c.ID as HomeID
	FROM
		constitution c,
		team t,
		division d
	WHERE
		c.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND
		t.LongCol = '#HomeString#' AND
		d.shortcol='#DivisionString#' AND
		c.TeamID = t.ID AND
		c.DivisionID = d.ID
</cfquery>		
