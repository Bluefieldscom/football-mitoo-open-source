<!--- called by InclLookUpPlayer.cfm --->

<cfquery name="QUniquePlayerRegNo" datasource="#request.DSN#">
	SELECT
		ID
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ShortCol = #ThisRandomPlayerRegNo#			
</cfquery>
