<!--- called by LUList.cfm --->
<!--- Get rid of any warnings. We are using this table to store them afresh each time. --->
<cfquery name="DeletePlayerDuplicateWarnings" datasource="#request.DSN#" >
	DELETE FROM
		playerduplicatewarnings
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
