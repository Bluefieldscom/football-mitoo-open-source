<!--- called from LUList.cfm --->

<CFQUERY NAME="UpdSuspension" datasource="#request.DSN#">
	UPDATE
		suspension
	SET
		LastDay = '#ThisLastDay#'
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #ThisSuspensionID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
</CFQUERY>
