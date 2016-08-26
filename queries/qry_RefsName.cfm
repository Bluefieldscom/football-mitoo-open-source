<cfquery name="RefInfo" datasource="#request.DSN#">
	SELECT
		CASE 
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0 
		THEN r.LongCol 
		ELSE CONCAT(r.Forename, " ", r.Surname) 
		END
		as RefsName
	FROM
		referee r
	WHERE
		r.LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND r.ID = #ThisRefereeID#
</cfquery>
