<!--- called by RegisteredList1.cfm and RegisteredList2.cfm--->

<CFQUERY NAME="QAllRegisteredPlayersNumber" datasource="#request.DSN#">
	SELECT
		p.ID as PlayerID,
		CONCAT(p.Surname, " ", p.Forename) as PlayerName ,
		p.MediumCol as PlayerDOB ,
		p.ShortCol as PlayerRegNo ,
		p.Notes as PlayerNotes ,
		t.LongCol as ClubName
	FROM
		register AS r, 
		player AS p, 
		team AS t
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID = r.PlayerID 
		AND t.ID = r.TeamID
	ORDER BY
		PlayerRegNo <!--- p.ShortCol --->
</CFQUERY>
