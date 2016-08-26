<!--- called by AppearanceAnalysis.cfm --->

<cfquery name="QApps" datasource="#request.DSN#" >
	SELECT
		COUNT(*) as AppCount
	FROM
		appearance AS a ,
		player AS p ,
		fixture AS f,
		constitution AS c
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.PlayerID = #ListGetAt(PlayerIDList,y)# 
		AND c.ID = #ListGetAt(ConstitIDList,x)# 
		AND ((a.HomeAway = 'H' 
				AND c.ID = f.HomeID) 
			OR (a.HomeAway = 'A' 
				AND c.ID = f.AwayID)) 
		AND p.ID = a.PlayerID 
		AND a.FixtureID = f.ID
</cfquery>
