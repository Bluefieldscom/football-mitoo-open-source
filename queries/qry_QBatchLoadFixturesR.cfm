<cfquery name="QBatchLoadFixturesR" datasource="#request.DSN#">
	SELECT
		ID as NullRefereeID
	FROM
		referee
	WHERE
		leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND
		longcol IS NULL
</cfquery>
