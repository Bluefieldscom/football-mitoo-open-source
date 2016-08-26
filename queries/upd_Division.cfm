<!--- called by Action.cfm --->
<cfquery name="QUpdtDivisionRecord" datasource="#request.DSN#" >
	UPDATE
		division 
	SET 
		LongCol = <cfqueryparam value = '#TRIM(Form.LongCol)#' cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
		MediumCol = <cfqueryparam value = '#TRIM(Form.MediumCol)#' cfsqltype="CF_SQL_VARCHAR" maxlength="25">, 
		ShortCol = <cfqueryparam value = '#TRIM(Form.ShortCol)#' 	cfsqltype="CF_SQL_VARCHAR" maxlength="15">,
		<cfif Form.Notes IS "">
			Notes = NULL
		<cfelse>
			Notes = '#TRIM(Form.Notes)#'
		</cfif>
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
