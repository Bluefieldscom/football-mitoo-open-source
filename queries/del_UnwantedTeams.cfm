<!--- called by DeleteUnwantedTeams --->

<!---  delete the redundant non-guest team records [JAB only] --->
<cfquery name="DelTeams" datasource="#request.DSN#" >
	DELETE FROM
		team
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID IN (#DeletionIDs#)
</cfquery>






<!--- for seasons 2007 and earlier do not use the stored procedure in zmast, instead execute code immediately below 
<cfif RIGHT(request.DSN,4) LT 2008 >
etc
etc
etc
<cfelse>
	<cfset accepted = 0>
	<!-- returns 0=fail or 1=success -->
	<cfstoredproc procedure="delete_multiple_items" datasource="zmast">
		<cfprocparam variable="changetable" 	type="In" 	value="team"				 	cfsqltype="cf_sql_varchar">
		<cfprocparam variable="season" 			type="In" 	value=#RIGHT(request.DSN,4)# 	cfsqltype="cf_sql_char">
		<cfprocparam variable="inlist" 			type="In" 	value=#DeletionIDs# 			cfsqltype="cf_sql_varchar">
		<cfprocparam variable="accepted"		type="Out"  								cfsqltype="cf_sql_numeric">
	</cfstoredproc>
	
	<cfif accepted IS 0>
		<cfmodule template = "../dberrorpage.cfm" source="team">
		<cfabort>
	</cfif>
</cfif>
--->