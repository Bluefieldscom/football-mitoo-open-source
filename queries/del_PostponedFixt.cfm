<!--- called by InclUpdtGoals.cfm 
....no longer in use ..........
<cftry>

	<cfquery name="FixtGoals" datasource="#request.DSN#" >
		DELETE 
		FROM 
			fixture 
		WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #id# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
	
	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Fixture"><cfabort>
	</cfcatch>
	
</cftry>	
--->