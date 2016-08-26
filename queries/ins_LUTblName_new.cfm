<!--- called by InclInsrtLookUp.cfm --->
<!--- this excludes player, matchreport  which have their own inserts --->		  
	<cfquery name="InsrtLookUpTblName" datasource="#request.DSN#" >
		INSERT INTO 
			#LCase(TblName)# 
				(LongCol, 
				MediumCol, 
				ShortCol, 
				Notes, 
				LeagueCode) 
			VALUES 
				('#LongCol#', 
				'#MediumCol#', 
				'#ShortCol#', 
				'#Notes#', 
				<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
	</cfquery>



<!--- for seasons 2007 and earlier do not use the stored procedure in zmast, instead execute code immediately below 
<cfif RIGHT(request.DSN,4) LT 2008 >
etc
etc
etc
<cfelse>
	<cfset accepted = 0>
	<!--- returns 0=fail or 1=success --->
	<cfstoredproc procedure="insert_LUTable" datasource="zmast">
		<cfprocparam variable="changetable"		type="In"	value=#Lcase(TblName)#			cfsqltype="cf_sql_varchar">	
		<cfprocparam variable="season" 			type="In" 	value=#RIGHT(request.DSN,4)# 	cfsqltype="cf_sql_char">
		<cfprocparam variable="longcol" 		type="In" 	value=#TRIM(LongCol)#			cfsqltype="cf_sql_varchar">
		<cfprocparam variable="mediumcol" 		type="In" 	value=#MediumCol# 				cfsqltype="cf_sql_varchar">
		<cfprocparam variable="shortcol" 		type="In" 	value=#ShortCol# 				cfsqltype="cf_sql_varchar">
		<cfprocparam variable="notes" 			type="In" 	value=#Notes# 					cfsqltype="cf_sql_text">
		<cfprocparam variable="leaguecode" 		type="In" 	value=#request.filter# 			cfsqltype="cf_sql_varchar">
		<cfprocparam variable="accepted"		type="Out"  								cfsqltype="cf_sql_numeric">
	</cfstoredproc>
	<cfif accepted IS 0>
		<cfmodule template = "../dberrorpage.cfm" source="generic">
		<cfabort>
	</cfif>
</cfif>
--->