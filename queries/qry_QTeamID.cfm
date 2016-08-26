<!--- called by AppearanceAnalysis.cfm --->

<cfquery name="QTeamID" datasource="#request.DSN#" >
	SELECT
		t.LongCol as TName
	FROM
		register AS r,
		player AS p,
		team AS t
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND p.ID = #ListGetAt(PlayerIDList,y)# 
		AND r.PlayerID = p.ID 
		AND r.TeamID = t.ID 
		AND t.ID = <cfqueryparam value = #URL.TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
