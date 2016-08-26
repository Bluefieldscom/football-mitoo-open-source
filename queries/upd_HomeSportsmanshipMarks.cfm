<!--- called by TeamList.cfm --->
<cfif Trim(Form.HomeSportsmanshipMarks) IS "">
	<cfquery name="QUpdtHomeSportsmanshipMarks" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			HomeSportsmanshipMarks = NULL
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelse>
	<cfquery name="QUpdtHomeSportsmanshipMarks" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			HomeSportsmanshipMarks = <cfqueryparam value = #Form.HomeSportsmanshipMarks# cfsqltype="CF_SQL_INTEGER" maxlength="3">
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
