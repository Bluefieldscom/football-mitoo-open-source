<cfquery name="QHide_Fixtures" datasource="#request.DSN#">
	SELECT 
		EventDate
	FROM
		event 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND EventText like '%Hide_Fixtures%'
</cfquery>
<!---- get a list of dates for hidden fixtures --->