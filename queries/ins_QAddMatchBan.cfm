<!--- called from SuspendPlayer.cfm --->
<cfquery name="QAddMatchBan" datasource="#request.DSN#" >
	INSERT INTO
		matchban
		(MatchbanheaderID, 
		ItemNumber, 
		LeagueCode
		) 
	VALUES
		( #ThisMatchbanheaderID#,
		 #ThisMatch#,
		<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		)
</cfquery>
