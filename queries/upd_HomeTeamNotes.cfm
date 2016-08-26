<!--- called by TeamList.cfm --->
<cfif Trim(Form.HomeTeamNotes) IS "">
	<cfquery name="QUpdtHomeTeamNotes" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			HomeTeamNotes = NULL
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelse>
	<cfquery name="QUpdtHomeTeamNotes" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			HomeTeamNotes = '#Trim(Form.HomeTeamNotes)#'
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
