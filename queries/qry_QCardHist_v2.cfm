<!--- called from YellowRedCards.cfm --->

<cfquery name="QCardHist" datasource="#request.DSN#" >
	SELECT
		'Red' as CardType,
		a.PlayerID,
		p.Surname, p.Forename,
		<!--- CONCAT(p.Surname, " ", p.forename) as PlayerName, --->
		p.ShortCol as PlayerNo
	FROM
		appearance AS a,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#	
		AND Card = 3	
		AND p.ID = a.PlayerID
	UNION ALL
	SELECT
		'Yellow' as CardType,
		a.PlayerID,
		p.Surname, p.Forename,
		<!--- CONCAT(p.Surname, " ", p.forename) as PlayerName, --->
		p.ShortCol as PlayerNo
	FROM
		appearance AS a,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#	
		AND Card = 1	
		AND p.ID = a.PlayerID
	UNION ALL
	SELECT
		'Orange' as CardType,
		a.PlayerID,
		p.Surname, p.Forename,
		<!--- CONCAT(p.Surname, " ", p.forename) as PlayerName, --->
		p.ShortCol as PlayerNo
	FROM
		appearance AS a,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.PlayerID = #ListGetAt(PlayerIDList,x)#	
		AND Card = 4	
		AND p.ID = a.PlayerID
	ORDER BY CardType
</cfquery>

