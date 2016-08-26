<!--- called by RemoveSuppressedWarning.cfm --->
<!--- Get rid of a specified suppressed warning --->
<cfquery name="DeletePlayerDuplicateNoWarnings1" datasource="#request.DSN#" >
	DELETE FROM
		playerduplicatenowarnings
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #ThisPlayerDuplicateNoWarningsID#
</cfquery>
