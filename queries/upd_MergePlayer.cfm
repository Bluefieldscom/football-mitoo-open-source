<!--- called by PlayerMerge.cfm --->

<!---  update the retained player record with the lost details --->
<cfquery name="Player00003" datasource="#request.DSN#" >
	UPDATE
		player
	SET Notes = Concat(Notes, ' {Merged with player no. #Player00001.shortCol# #Player00001.mediumCol# #Player00001.Notes#}')
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID =  #url.ID2#;
</cfquery>
