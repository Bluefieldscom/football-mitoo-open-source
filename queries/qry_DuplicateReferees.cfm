<!--- Called by LUList.cfm --->

<cfquery name="QDuplicateReferees" datasource="#request.DSN#">
	SELECT
		COUNT(id) as counter,
		surname,
		forename 
	FROM
		referee 
	WHERE
		leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND Length(Trim(surname)) > 0
	GROUP BY
		concat(surname,forename)
	HAVING
		counter > 1
	ORDER BY
		surname,forename
</cfquery>		


<cfquery name="QDuplicateSurnameInitial" datasource="#request.DSN#">
	SELECT
		COUNT(id) as counter,
		surname,
		forename 
	FROM
		referee 
	WHERE
		leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND Length(Trim(surname)) > 0
		AND Length(Trim(mediumcol)) = 0
	GROUP BY
		concat(surname,Left(forename,1))
	HAVING
		counter > 1
	ORDER BY
		surname,forename
</cfquery>		