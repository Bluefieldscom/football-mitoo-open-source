<!--- Called by Marketplace.cfm, Noticeboard.cfm --->

<cfquery name="QCountiesList" datasource="ZMAST" >
	SELECT
		CountiesList
	FROM
		leagueinfo
	WHERE
		DefaultLeagueCode = <cfqueryparam value = '#DefaultLeagueCode#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="9">
</cfquery>

