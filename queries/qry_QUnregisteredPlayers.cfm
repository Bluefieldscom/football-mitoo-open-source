<!--- called by RegisteredList1.cfm and RegisteredList2.cfm --->

<CFQUERY NAME="QUnregisteredPlayers" datasource="#request.DSN#">
	SELECT
		p.ID as PlayerID,
		CONCAT(p.Surname, " ", p.Forename) as PlayerName ,
		p.MediumCol as PlayerDOB ,
		p.ShortCol as PlayerRegNo
	FROM
		player AS p 
		LEFT OUTER JOIN register AS r 
			ON p.ID = r.PlayerID
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.TeamID IS NULL 
		AND NOT p.ShortCol = 0
	ORDER BY
		PlayerName <!--- p.LongCol --->
</CFQUERY>
