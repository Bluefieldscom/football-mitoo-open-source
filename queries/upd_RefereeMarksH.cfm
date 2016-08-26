<!--- called by TeamList.cfm --->
<cfif Trim(Form.RefereeMarksH) IS "">
	<cfquery name="QUpdtRefereeMarksH" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			RefereeMarksH = NULL
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelse>
	<cfquery name="QUpdtRefereeMarksH" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			RefereeMarksH = <cfqueryparam value = #Form.RefereeMarksH# cfsqltype="CF_SQL_INTEGER" maxlength="3">
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
