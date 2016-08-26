<!--- called from TeamDetailsUpdate.cfm --->

<cfquery name="InsrtTeamDetails" datasource="#request.DSN#" >
	INSERT INTO teamdetails
		(LeagueCode, TeamID, OrdinalID)
	VALUES
		(<cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">, 	
		<cfqueryparam value = #ThisTeamID# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		<cfqueryparam value = #ThisOrdinalID# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8">
		)
</cfquery>
