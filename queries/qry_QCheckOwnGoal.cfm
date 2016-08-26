<!--- called by RegisteredList1.cfm and RegisteredList2.cfm --->

<cfquery name="QCheckOwnGoal" datasource="#request.DSN#" >
	SELECT
		r.TeamID, 
		t.LongCol as ClubName
	FROM
		player AS p,
		register AS r,
		team AS t
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.shortCol = 0 
		AND p.ID = r.PlayerID 
		AND r.TeamID = t.ID
</cfquery>
