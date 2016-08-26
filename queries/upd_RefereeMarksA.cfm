<!--- called by TeamList.cfm --->
<cfif Trim(Form.RefereeMarksA) IS "">
	<cfquery name="QUpdtRefereeMarksA" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			RefereeMarksA = NULL
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelse>
	<cfquery name="QUpdtRefereeMarksA" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			RefereeMarksA = <cfqueryparam value = #Form.RefereeMarksA# cfsqltype="CF_SQL_INTEGER" maxlength="3">
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
