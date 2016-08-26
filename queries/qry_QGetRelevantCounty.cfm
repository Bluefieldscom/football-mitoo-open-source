<!--- called by News.cfm --->

<cfquery name="QGetRelevantCounty" datasource="ZMAST">	
	SELECT
		CountiesList
	FROM
		leagueinfo
	WHERE
		DefaultLeagueCode = <cfqueryparam value = '#LeagueCode#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>