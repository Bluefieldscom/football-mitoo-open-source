<cfquery name="MergeAppearance" datasource="#request.DSN#" >
	UPDATE
		appearance
	SET
		PlayerID = #url.ID2#
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID =  #url.ID1#;
</cfquery>



