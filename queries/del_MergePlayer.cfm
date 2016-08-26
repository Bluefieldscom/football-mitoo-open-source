<!--- called by PlayerMerge.cfm --->
<cfabort>


<!---  delete the player record 
<cfquery name="Player00002" datasource="#request.DSN#" >
	DELETE FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID =  #url.ID1#;
</cfquery>
--->