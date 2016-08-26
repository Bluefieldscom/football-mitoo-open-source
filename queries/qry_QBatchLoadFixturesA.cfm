<cfquery name="QBatchLoadFixturesA" datasource="#request.DSN#">
	SELECT
		c.ID as AwayID
	FROM
		constitution c,
		team t,
		division d
	WHERE
		c.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND
		t.LongCol = '#AwayString#' AND
		d.shortcol='#DivisionString#' AND
		c.TeamID = t.ID AND
		c.DivisionID = d.ID
</cfquery>		
