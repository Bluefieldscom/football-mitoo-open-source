<!--- called by RegistrationInfo.cfm --->

<cfquery name="QRegnInfo" datasource="ZMAST" >
	SELECT
		name,
		email,
		info,
		DateRegistered
	FROM
		registration
	WHERE
		LeagueCode = <cfqueryparam value = '#LeagueCode#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	ORDER BY
		DateRegistered
</cfquery>
