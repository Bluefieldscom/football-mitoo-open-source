<!--- called by TeamList.cfm --->
<cfif Trim(Form.AwaySportsmanshipMarks) IS "">
	<cfquery name="QUpdtAwaySportsmanshipMarks" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			AwaySportsmanshipMarks = NULL
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelse>
	<cfquery name="QUpdtAwaySportsmanshipMarks" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			AwaySportsmanshipMarks = <cfqueryparam value = #Form.AwaySportsmanshipMarks# cfsqltype="CF_SQL_INTEGER" maxlength="3">
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
