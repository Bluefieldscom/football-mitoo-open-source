<!--- called from YellowRedCards.cfm --->

<cfquery name="QYellowRedCards" datasource="#request.DSN#" >
	SELECT
		a.PlayerID as PlayerID ,
		CONCAT(p.Surname, " ", p.forename) as PlayerName,
		p.ShortCol as PlayerNo ,
		COUNT(p.ID) as GamesPlayed ,
		COALESCE(SUM(a.Card),0) as Points
	FROM
		appearance AS a ,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID = a.PlayerID
	GROUP BY
		PlayerID <!--- , PlayerName, PlayerNo --->
	HAVING
		Points > 0
	ORDER BY
		Points DESC, PlayerName 
</cfquery>