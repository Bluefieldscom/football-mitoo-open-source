<!--- called by InclCheckFixtureDate.cfm, InclInsrtGroupOfFixtures.cfm --->

<cfquery name="QHomeID" datasource="#request.DSN#">
	SELECT 
		TeamID, 
		OrdinalID 
	FROM 
		constitution 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #HomeID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>