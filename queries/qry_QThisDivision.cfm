<!--- called by TeamList.cfm --->
<cfquery name="QThisDivision" datasource="#request.DSN#" >
	SELECT
		d.ID as DID,
		IF (Notes LIKE '%MatchNumbers%', 'Yes','No') as MatchNumbers
	FROM
		fixture f,
		constitution c,
		division d
	WHERE 
		f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND f.HomeID = c.ID
		AND c.DivisionID = d.ID
</cfquery>
