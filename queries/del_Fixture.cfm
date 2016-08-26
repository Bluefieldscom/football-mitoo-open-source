<!--- called by MtchDay.cfm --->

<cftry>
			
	<CFQUERY NAME="DelFixture" datasource="#request.DSN#">
		DELETE FROM
			fixture
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #ThisFixtureID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</CFQUERY>
	
	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Fixture"><cfabort>
	</cfcatch>
	
</cftry>	
