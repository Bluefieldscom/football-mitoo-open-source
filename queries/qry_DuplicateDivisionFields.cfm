<!--- Called by LUList.cfm --->
<CFQUERY NAME="QDuplicateLongCol" datasource="#request.DSN#">
	SELECT
		id
	FROM
		division 
	WHERE
		leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol = '#Trim(form.LongCol)#'
</cfquery>		
<CFQUERY NAME="QDuplicateMediumCol" datasource="#request.DSN#">
	SELECT
		id
	FROM
		division 
	WHERE
		leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND MediumCol = '#form.MediumCol#'
</cfquery>		
<CFQUERY NAME="QDuplicateShortCol" datasource="#request.DSN#">
	SELECT
		id
	FROM
		division 
	WHERE
		leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ShortCol = '#form.ShortCol#'
</cfquery>		
