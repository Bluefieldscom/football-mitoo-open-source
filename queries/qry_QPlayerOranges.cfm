<!--- called by PlayersHist.cfm --->

<CFQUERY NAME="QPlayerOranges" datasource="#request.DSN#">
	SELECT
		COUNT(Card) as CardCount
	FROM
		appearance
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #PI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND Card = 4
</CFQUERY>
