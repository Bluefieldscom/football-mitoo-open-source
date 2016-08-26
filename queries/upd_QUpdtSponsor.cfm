<!--- called by Action.cfm --->

<CFQUERY name="UpdtSponsor" datasource="#request.DSN#">
	UPDATE
		sponsor
	SET
		LastUpdated = #CreateODBCDate(Now())# ,
		Button = <cfqueryparam value = '#Form.Button#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
		DID = <cfqueryparam value = #Form.DID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		TID = <cfqueryparam value = #Form.TID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		OID = <cfqueryparam value = #Form.OID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		SponsorsHTML = <cfqueryparam value = '#Form.SponsorsHTML#' 
					cfsqltype="CF_SQL_LONGVARCHAR">,
		SponsorsName = <cfqueryparam value = '#Form.SponsorsName#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="50"> ,
		Notes = <cfqueryparam value = '#Form.Notes#' 
					cfsqltype="CF_SQL_LONGVARCHAR">,
		TeamHTML = <cfqueryparam value = '#Form.TeamHTML#' 
					cfsqltype="CF_SQL_LONGVARCHAR">
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #ID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
