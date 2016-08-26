<cfquery name="QBatchLoadFixturesK" datasource="#request.DSN#">
	SELECT
		ID as NullKORoundID
	FROM
		koround
	WHERE
		leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND
		longcol IS NULL
</cfquery>
