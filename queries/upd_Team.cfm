<!--- called by Action.cfm --->

<cfquery name="QUpdtTeamRecord" datasource="#request.DSN#" >
	UPDATE
		team 
	SET 
		LongCol = <cfqueryparam value = '#TRIM(Form.LongCol)#' cfsqltype="CF_SQL_VARCHAR" maxlength="50">, 
		MediumCol = <cfqueryparam value = '#Form.MediumCol#' cfsqltype="CF_SQL_VARCHAR" maxlength="25">, 
		ShortCol = <cfqueryparam value = '#Form.ShortCol#' 	cfsqltype="CF_SQL_VARCHAR" maxlength="15">,
		FACharterStandardType = <cfqueryparam value = #Form.FACharterStandardType# cfsqltype="CF_SQL_INTEGER" maxlength="1">,
		<cfif Form.ParentCountyFA IS "">
			ParentCountyFA = NULL,
		<cfelse>
			ParentCountyFA = <cfqueryparam value = '#Form.ParentCountyFA#' cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
		</cfif>
		<cfif Form.AffiliationNo IS "">
			AffiliationNo = NULL,
		<cfelse>
			AffiliationNo = <cfqueryparam value = '#Form.AffiliationNo#' cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
		</cfif>
		<cfif Form.Notes IS "">
			Notes = NULL
		<cfelse>
			Notes = '#Form.Notes#'
		</cfif>
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
