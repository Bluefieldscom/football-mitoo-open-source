<!--- called by Action.cfm --->
<cftry>
	<CFQUERY NAME="DelConstit" datasource="#request.DSN#">
		DELETE FROM
			constitution
		WHERE
			LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value=#Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</CFQUERY>
	
	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Constitution"><cfabort>
	</cfcatch> 
</cftry>

<!--- before, for seasons 2007 and earlier do not use the stored procedure in zmast, instead execute code immediately below 
<cfif RIGHT(request.DSN,4) LT 2008 >
etc
etc
etc
<cfelse>
	<cfset accepted=0>
	<cfstoredproc procedure="delete_item" datasource="zmast">
		<cfprocparam variable="changetable" 	type="In" 	value="constitution" 			cfsqltype="cf_sql_varchar">
		<cfprocparam variable="item_id" 		type="In"  	value=#Form.ID# 				cfsqltype="cf_sql_numeric">
		<cfprocparam variable="season" 			type="In" 	value=#RIGHT(request.DSN,4)# 	cfsqltype="cf_sql_char">
		<cfprocparam variable="accepted"		type="Out"  								cfsqltype="cf_sql_numeric">
	</cfstoredproc>
	<!---<cfdump var=#form#><cfdump var=#request#><cfdump var=#accepted#><cfabort>--->
	<cfif accepted IS 0>
		<cfmodule template = "../dberrorpage.cfm" source="Constitution">	
		<cfabort>
	</cfif>		
</cfif>	
--->