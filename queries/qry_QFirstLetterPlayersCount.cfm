<!--- called by LUList.cfm --->

<cfquery name="QFirstLetterPlayersCount" datasource="#request.DSN#" >
	SELECT
		COUNT(*) as cnt
	FROM
		player as p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND LEFT(p.surname,1) = <cfqueryparam value = '#FirstLetter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="1">
</cfquery>


