<!--- called by Action.cfm                    #ThisTableName# will be noticeboard OR noticeboard_old --->

<cfif TblName IS "Noticeboard">
	<cftry>
		<CFQUERY NAME="DeleteTblName" datasource="marketplace">
			DELETE FROM
				#form.ThisTableName#
			WHERE
				ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		</CFQUERY>
		<cfcatch type="database">
			<cfmodule template = "../dberrorpage.cfm" source="generic"><cfabort>
		</cfcatch>
	</cftry>
<cfelseif TblName IS "Document">
	<cftry>
		<CFQUERY NAME="DeleteTblName" datasource="zmast">
			DELETE FROM
				leaguedocs
			WHERE
				ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		</CFQUERY>
		<cfcatch type="database">
			<cfmodule template = "../dberrorpage.cfm" source="generic"><cfabort>
		</cfcatch>
	</cftry>
<cfelse>
		<cftry>		
			<CFQUERY NAME="DeleteTblName" datasource="#request.DSN#">
				DELETE FROM
					#LCase(TblName)#
				WHERE
					LeagueCode = <cfqueryparam value = '#request.filter#' 
									cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND ID = <cfqueryparam value = #Form.ID#
										cfsqltype="CF_SQL_INTEGER" maxlength="8">
			</CFQUERY>
			
			<cfcatch type="database">
				<cfoutput>#cfcatch.detail#</cfoutput>
				<cfmodule template = "../dberrorpage.cfm" source="generic">
				<cfabort>
			</cfcatch>
		</cftry>
</cfif>	







<!--- for seasons 2007 and earlier do not use the stored procedure in zmast, instead execute code immediately below 
	<cfif RIGHT(request.DSN,4) LT 2008 >
	etc
	etc
	etc
	<cfelse>
		<cfif #Lcase(TblName)# IS "team" OR #Lcase(TblName)# IS "division" OR #Lcase(TblName)# IS "ordinal">	
			<cfset accepted = 0>
				<!--- returns 0=fail or 1=success --->
				<cfstoredproc procedure="delete_item" datasource="zmast">
					<cfprocparam variable="changetable" type="In" 	value=#Lcase(TblName)# 		cfsqltype="cf_sql_varchar">
					<cfprocparam variable="item_id" 	type="In"  	value=#Form.ID# 			cfsqltype="cf_sql_numeric">
					<cfprocparam variable="season" 		type="In" 	value=#RIGHT(request.DSN,4)# cfsqltype="cf_sql_char">
					<cfprocparam variable="accepted"	type="Out"  							 cfsqltype="cf_sql_numeric">
				</cfstoredproc>
				<cfif accepted IS 0>
					<cfmodule template = "../dberrorpage.cfm" source="Team">	
					<cfabort>
				</cfif>		
		<cfelse>
			<cftry>		
				<CFQUERY NAME="DeleteTblName" datasource="#request.DSN#">
					DELETE FROM
						#LCase(TblName)#
					WHERE
						LeagueCode = <cfqueryparam value = '#request.filter#' 
										cfsqltype="CF_SQL_VARCHAR" maxlength="5">
						AND ID = <cfqueryparam value = #Form.ID#
											cfsqltype="CF_SQL_INTEGER" maxlength="8">
				</CFQUERY>
				<cfcatch type="database">
					<cfoutput>#cfcatch.detail#</cfoutput>
					<cfmodule template = "../dberrorpage.cfm" source="generic">
					<cfabort>
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
--->