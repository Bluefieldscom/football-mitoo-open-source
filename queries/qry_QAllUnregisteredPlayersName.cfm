<!--- called by RegisteredList1.cfm and RegisteredList2.cfm --->

<cfquery name="QAllUnregisteredPlayersName" datasource="#request.DSN#">
	SELECT
		p.ID as PlayerID,
		p.Surname,
		p.Forename,
		p.MediumCol as PlayerDOB ,
		p.ShortCol as PlayerRegNo,
		p.Notes as PlayerNotes
	FROM
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID NOT IN 
			(SELECT p2.ID 
			FROM register AS r, 
				player AS p2, team AS t 
			WHERE 
				t.LeagueCode = <cfqueryparam value = '#request.filter#' 
								cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
				AND p2.ID = r.PlayerID 
				AND t.ID = r.TeamID )
		AND NOT p.ShortCol = 0
	ORDER BY
		Surname, Forename
</cfquery>
