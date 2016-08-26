<!--- called by LUList.cfm --->

<cfquery name="QFirstNumberPlayersCount" datasource="#request.DSN#" >
	SELECT
		COUNT(*) as cnt
	FROM
		player as p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND p.ShortCol 
				BETWEEN  
				<cfqueryparam value = #FirstNumber# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
				AND 
				<cfqueryparam value = #LastNumber# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
