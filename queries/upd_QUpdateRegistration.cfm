<!--- called from RegisterPlayer.cfm --->

<cfquery name="QUpdateRegistration" datasource="#request.DSN#" >
	UPDATE
		register 
	SET
		TeamID = #Form.TeamID#,
		<cfif Form.FirstDay IS "">
			FirstDay = NULL,
		<cfelse>
			FirstDay = #CreateODBCDate(Form.FirstDay)#,
		</cfif>
		<cfif Form.LastDay IS "" AND Form.RegType IS "F" >
			<!--- for Temporary registrations add five days automatically --->
			LastDay = #CreateODBCDate(DateAdd('D',5,Form.FirstDay))#,
		<cfelseif Form.LastDay IS "" AND Form.RegType IS NOT "F" > 
			LastDay = NULL,
		<cfelse>
			LastDay = #CreateODBCDate(Form.LastDay)#,
		</cfif>
		RegType = '#Form.RegType#'
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #Form.RID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

