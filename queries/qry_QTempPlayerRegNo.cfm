<!--- called by InclBatchTempRegNonContract.cfm --->
<cfquery name="QTempPlayerRegNo" datasource="#request.DSN#" >
	SELECT
		id,
		surname,
		forename
	FROM
		player
	WHERE
		leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND shortcol=#PlayerRegNo#
</cfquery>
