<!--- called from TeamList.cfm --->

<CFQUERY NAME="QSuspendedPlayers" datasource="#request.DSN#">
	SELECT
		p.ID as PlayerID
	FROM
		fixture AS f, 
		player AS p, 
		register AS r, 
		constitution AS c, 
		team AS t, 
		suspension AS s
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID = <cfqueryparam value = #FID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND f.FixtureDate BETWEEN s.FirstDay AND s.LastDay 
		AND 
		<cfif HA IS "H">
			f.HomeID = c.ID
		<cfelse>
			f.AwayID = c.ID
		</cfif> 
		AND c.TeamID = t.ID 
		AND t.ID = r.TeamID 
		AND r.PlayerID = p.ID 
		AND s.PlayerID = p.ID
</CFQUERY>
