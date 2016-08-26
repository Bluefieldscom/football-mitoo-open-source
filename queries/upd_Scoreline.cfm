<!--- called by TeamList.cfm --->
<cfif Trim(Form.HomeGoals) IS "" OR Trim(Form.AwayGoals) IS "" >
	<cfquery name="QUpdtScoreline" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			HomeGoals = NULL,
			AwayGoals = NULL
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelse>
	<cfquery name="QUpdtScoreline" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			HomeGoals = <cfqueryparam value = #Form.HomeGoals# cfsqltype="CF_SQL_INTEGER" maxlength="3">,
			AwayGoals = <cfqueryparam value = #Form.AwayGoals# cfsqltype="CF_SQL_INTEGER" maxlength="3">
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
