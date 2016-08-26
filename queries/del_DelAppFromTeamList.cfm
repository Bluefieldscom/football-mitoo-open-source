<!--- caled from UpdateTeamList.cfm --->

<cftry>

	<cfquery datasource="#request.DSN#">
		DELETE FROM
			appearance
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND FixtureID = <cfqueryparam value = #FID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
			AND PlayerID = <cfqueryparam value = #PID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>

	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="appearance"><cfabort>
	</cfcatch>
	
</cftry>
