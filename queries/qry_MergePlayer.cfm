<!--- called by PlayerMerge.cfm --->

<!--- get details from the player record we are about to delete --->
<cfquery name="Player00001" datasource="#request.DSN#" >
	SELECT
		mediumcol, shortcol, Notes
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID =  #url.ID1#;
</cfquery>
