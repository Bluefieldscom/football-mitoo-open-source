<!--- called by InclCheckOfficials.cfm --->
<cfquery name="QCheckRef" datasource="#request.DSN#">
	SELECT
		id
	FROM
		referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND longcol IS NULL
</cfquery>
<cfif QCheckRef.RecordCount IS NOT 1>
	There should only be one blank referee record - aborting - please contact Julian<cfabort>
</cfif>
