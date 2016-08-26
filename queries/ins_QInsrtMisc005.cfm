<!--- called from MoveToMisc.cfm --->
<cfquery name="QInsrtMisc005" datasource="#request.DSN#" >
	INSERT INTO constitution
		(LeagueCode, DivisionID, TeamID, OrdinalID, ThisMatchNoID, NextMatchNoID)
	VALUES
		(<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
		<cfqueryparam value = #request.MiscID# cfsqltype="CF_SQL_INTEGER" maxlength="8">, 
		<cfqueryparam value = #QMisc005.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">, 
		<cfqueryparam value = #QMisc005.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		<cfqueryparam value = #QMisc005.ThisMatchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">, 
		<cfqueryparam value = #QMisc005.NextMatchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">)
</cfquery>



<!--- for seasons 2007 and earlier do not use the stored procedure in zmast, instead execute code immediately below
<cfif RIGHT(request.DSN,4) LT 2008 >
etc
etc
etc
<cfelse>
	<cfset accepted = 0>
	<!-- returns 0=fail or 1=success -->
	<cfstoredproc procedure="insert_constitution" datasource="zmast">
		<cfprocparam variable="season" 			type="In" 	value=#RIGHT(request.DSN,4)# 	cfsqltype="cf_sql_char">
		<cfprocparam variable="divisionid" 		type="In" 	value=#request.MiscID#			cfsqltype="cf_sql_integer">
		<cfprocparam variable="teamid"	 		type="In" 	value=#QMisc005.TeamID# 			cfsqltype="cf_sql_integer">
		<cfprocparam variable="ordinalid" 		type="In" 	value=#QMisc005.OrdinalID# 		cfsqltype="cf_sql_integer">
		<cfprocparam variable="thismatchnoid" 	type="In" 	value=#QMisc005.ThisMatchNoID# 	cfsqltype="cf_sql_integer">
		<cfprocparam variable="nextmatchnoid" 	type="In" 	value=#QMisc005.NextMatchNoID# 	cfsqltype="cf_sql_integer">
		<cfprocparam variable="leaguecode" 		type="In" 	value=#request.filter# 			cfsqltype="cf_sql_varchar">
		<cfprocparam variable="accepted"		type="Out"  								cfsqltype="cf_sql_numeric">
	</cfstoredproc>
	
	<cfif accepted IS 0>
		<cfmodule template = "../dberrorpage.cfm" source="generic">
		<cfabort>
	</cfif>
</cfif>
--->