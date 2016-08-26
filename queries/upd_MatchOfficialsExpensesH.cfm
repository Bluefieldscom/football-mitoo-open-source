<!--- called by TeamList.cfm --->
<cfif Trim(Form.MatchOfficialsExpenses) IS "" >
	<cfquery name="QUpdtRefereeMarksH" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			MatchOfficialsExpenses = 0
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelseif IsNumeric(Trim(Form.MatchOfficialsExpenses))>
	<cfquery name="QUpdtRefereeMarksH" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			MatchOfficialsExpenses = #Form.MatchOfficialsExpenses#
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
