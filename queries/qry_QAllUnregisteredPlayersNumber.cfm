<!--- called by RegisteredList1.cfm and RegisteredList2.cfm --->

<cfquery name="QAllUnregisteredPlayersNumber" datasource="#request.DSN#">
	SELECT
		p.ID as PlayerID,
		CONCAT(p.Surname, " ", p.Forename) as PlayerName ,
		p.MediumCol as PlayerDOB ,
		p.ShortCol as PlayerRegNo
	FROM
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID NOT IN 
			(SELECT p2.ID 
			 FROM register AS r, 
				  player AS p2, team AS t 
		 	 WHERE t.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
				   AND p2.ID = r.PlayerID 
				   AND t.ID = r.TeamID )
		AND NOT p.ShortCol = 0
	ORDER BY
		PlayerRegNo <!--- p.ShortCol --->
</cfquery>
