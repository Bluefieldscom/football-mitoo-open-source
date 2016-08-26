<!--- called by ConstitList.cfm --->
<cfquery name="UpdtConstitBlank" datasource="#request.DSN#">
	UPDATE
		constitution
	SET
		ThisMatchNoID = <cfqueryparam value = #GetBlankMatchNo.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		NextMatchNoID = <cfqueryparam value = #GetBlankMatchNo.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #CID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
