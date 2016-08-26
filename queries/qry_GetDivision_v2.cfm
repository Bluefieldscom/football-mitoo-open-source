<!--- called by InclCheckFixtureDate.cfm, InclInsrtGroupOfFixtures.cfm --->

<CFQUERY NAME="GetDivision" datasource="#request.DSN#">
	SELECT 	
		LongCol as DesiredDivisionName, 
		Notes
	FROM
	 	division as Division
	WHERE
		LeagueCode = <cfqueryparam value ='#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #DivisionID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
