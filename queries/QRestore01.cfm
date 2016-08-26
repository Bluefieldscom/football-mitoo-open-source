<!--- called from RestoreBackFromMisc.cfm --->


<!--- get the Miscellaneous row for the withdrawn team --->
<cfquery name="Step001" datasource="#request.DSN#" >
	SELECT  
		TeamID, OrdinalID, ThisMatchNoID, NextMatchNoID
	FROM 
		Constitution 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #WithdrawnCID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<!--- make sure it is not already in the constitution of its original division --->
<cfquery name="Check01" datasource="#request.DSN#" >
	SELECT  
		ID 
	FROM 
		Constitution 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND DivisionID = <cfqueryparam value = #OriginalDivisionID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND TeamID = <cfqueryparam value = #Step001.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OrdinalID = <cfqueryparam value = #Step001.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<cfif Check01.RecordCount GT 1>
	ERROR IN Restore01.cfm. Aborting ........
	<cfabort>
<cfelseif Check01.RecordCount IS 1>
	WARNING - already back in original division
<cfelse>
	<!--- add it back into the constitution of its original division --->
	<cfquery name="Insert01" datasource="#request.DSN#" >
		INSERT INTO
			constitution 
			(DivisionID, TeamID, OrdinalID, ThisMatchNoID, NextMatchNoID, LeagueCode)
		VALUES
			(<cfqueryparam value = #OriginalDivisionID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			 <cfqueryparam value = #Step001.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			 <cfqueryparam value = #Step001.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			 <cfqueryparam value = #Step001.ThisMatchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			 <cfqueryparam value = #Step001.NextMatchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			 <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
	</cfquery>
</cfif>

<!--- get the Constitution ID of the row we just inserted  --->
<cfquery name="Step002" datasource="#request.DSN#" >
	SELECT  
		ID as NewCID
	FROM 
		Constitution 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND DivisionID = <cfqueryparam value = #OriginalDivisionID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND TeamID = <cfqueryparam value = #Step001.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OrdinalID = <cfqueryparam value = #Step001.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
