<!--- called by RegistListForm.cfm --->
<cfquery name="GetReferee" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol
	FROM
		referee
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID NOT IN	(SELECT ID FROM referee WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND (forename IS NULL OR forename = ""  OR forename IS NULL OR forename = "" ))
	ORDER BY LongCol
</cfquery>
