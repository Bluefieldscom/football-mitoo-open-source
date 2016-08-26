<!--- called by InclInsrtConstit.cfm --->

<cfquery name="InsertConst" datasource="#request.DSN#">
	INSERT INTO constitution
		(DivisionID, TeamID, OrdinalID, ThisMatchNoID, NextMatchNoID, LeagueCode)
	VALUES
		(<cfqueryparam value = #form.DivisionID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = #form.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = #form.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = #form.ThisMatchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = #form.NextMatchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		 <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
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
		<cfprocparam variable="divisionid" 		type="In" 	value=#form.DivisionID#			cfsqltype="cf_sql_integer">
		<cfprocparam variable="teamid"	 		type="In" 	value=#form.TeamID# 			cfsqltype="cf_sql_integer">
		<cfprocparam variable="ordinalid" 		type="In" 	value=#form.OrdinalID# 			cfsqltype="cf_sql_integer">
		<cfprocparam variable="thismatchnoid" 	type="In" 	value=#form.ThisMatchNoID# 		cfsqltype="cf_sql_integer">
		<cfprocparam variable="nextmatchnoid" 	type="In" 	value=#form.NextMatchNoID# 		cfsqltype="cf_sql_integer">
		<cfprocparam variable="leaguecode" 		type="In" 	value=#request.filter# 			cfsqltype="cf_sql_varchar">
		<cfprocparam variable="accepted"		type="Out"  								cfsqltype="cf_sql_numeric">
	</cfstoredproc>
	
	<cfif accepted IS 0>
		<cfmodule template = "../dberrorpage.cfm" source="generic">
		<cfabort>
	</cfif>
</cfif>
--->