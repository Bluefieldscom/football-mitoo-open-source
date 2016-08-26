<!--- called by InclBatchTempRegNonContract.cfm --->
<cfquery name="RegisterF" datasource="#request.DSN#" >
	UPDATE
		register
	SET
		RegType = 'B', 
		LastDay=NULL
	WHERE
		leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND id=#QRegisterF.id#
</cfquery>
