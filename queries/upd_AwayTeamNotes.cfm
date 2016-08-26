<!--- called by TeamList.cfm --->
<cfif Trim(Form.AwayTeamNotes) IS "">
	<cfquery name="QUpdtAwayTeamNotes" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			AwayTeamNotes = NULL
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelse>
	<cfquery name="QUpdtAwayTeamNotes" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			AwayTeamNotes = '#Trim(Form.AwayTeamNotes)#'
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
