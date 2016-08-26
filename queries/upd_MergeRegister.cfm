<cfquery name="MergeRegister" datasource="#request.DSN#" >
	UPDATE
		register
	SET
		PlayerID = #url.ID2#
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID =  #url.ID1#;
</cfquery>



