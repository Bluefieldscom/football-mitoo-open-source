<!--- called by InclSpecifyWinner.cfm --->
<cftry>
	<cfquery name="DltConstit" datasource="#request.DSN#" >
		DELETE FROM
			constitution
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #QSW00.ID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</CFQUERY>
	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Constitution"><cfabort>
	</cfcatch>
</cftry>





	
<!---
<cfstoredproc procedure="delete_item" datasource="zmast">
	<cfprocparam variable="changetable" 	type="In" 	value="constitution" 			cfsqltype="cf_sql_varchar">
	<cfprocparam variable="item_id" 		type="In"  	value=#QSW00.ID# 				cfsqltype="cf_sql_numeric">
	<cfprocparam variable="season" 			type="In" 	value=#RIGHT(request.DSN,4)# 	cfsqltype="cf_sql_char">
	<cfprocparam variable="accepted"		type="Out"  								cfsqltype="cf_sql_numeric">
</cfstoredproc>

<cfif accepted IS 0>
	<cfmodule template = "../dberrorpage.cfm" source="Constitution">	
	<cfabort>
</cfif>
--->
