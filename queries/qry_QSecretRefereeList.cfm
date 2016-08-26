<!--- called by RSecretWordList.cfm --->
<cfquery name="QGetSecretRefereeList" datasource="#request.DSN#">
	SELECT ID, LongCol, Surname, Forename
	FROM referee
	WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND	ID NOT IN
					(SELECT ID FROM referee WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
						AND (forename IS NULL OR forename = "" OR forename LIKE '%TBA%' OR forename IS NULL OR forename = "" OR forename LIKE '%TBA%'))
	ORDER BY
		LongCol
</cfquery>
