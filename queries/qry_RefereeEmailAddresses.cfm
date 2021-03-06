<!--- called by LUList.cfm for Referee output --->
<cfquery name="QRefereeEmailAddresses" datasource="#request.DSN#">
	SELECT DISTINCT
		emailaddress1 AS emailaddr,
		concat(forename,' ',surname) as CName  
	FROM
		referee
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND length(trim(emailaddress1)) <> '' 
	UNION
	SELECT DISTINCT
		emailaddress2 AS emailaddr,
		concat(forename,' ',surname) as CName  
	FROM
		referee
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND length(trim(emailaddress2)) <> '' 
	ORDER BY
		emailaddr
</cfquery>
