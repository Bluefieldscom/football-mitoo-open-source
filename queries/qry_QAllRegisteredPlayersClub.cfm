<!--- called by RegisteredList1.cfm and RegisteredList2.cfm --->

<CFQUERY NAME="QAllRegisteredPlayersClub" datasource="#request.DSN#">
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
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID = r.PlayerID 
		AND t.ID = r.TeamID
	ORDER BY
		ClubName, PlayerName <!--- t.LongCol , p.LongCol --->
</CFQUERY>
