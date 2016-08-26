<!--- called by inclCautionThresholdsPI.cfm --->

<CFQUERY NAME="CautionThresholds1" datasource="#request.DSN#" >
	SELECT
		a.playerid,
		sum(a.card) as totalcard,
		p.surname,
		p.forename
	FROM
		appearance a,
		fixture f,
		player p
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #PI# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND f.FixtureDate <= '#CutOffDate1#'
		AND a.Card = 1
		AND a.FixtureID = f.id 
		AND a.PlayerID = p.ID
	GROUP BY
		a.playerid
	HAVING 
		totalcard >= #MaxCardCount1#
	ORDER BY
		totalcard DESC		
</CFQUERY>

<CFQUERY NAME="CautionThresholds2" datasource="#request.DSN#" >
	SELECT
		a.playerid,
		sum(a.card) as totalcard,
		p.surname,
		p.forename
	FROM
		appearance a,
		fixture f,
		player p
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #PI# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND f.FixtureDate <= '#CutOffDate2#'
		AND a.Card = 1
		AND a.FixtureID = f.id 
		AND a.PlayerID = p.ID
	GROUP BY
		a.playerid
	HAVING 
		totalcard >= #MaxCardCount2#
	ORDER BY
		totalcard DESC		
</CFQUERY>

<CFQUERY NAME="CautionThresholds3" datasource="#request.DSN#" >
	SELECT
		a.playerid,
		sum(a.card) as totalcard,
		p.surname,
		p.forename
	FROM
		appearance a,
		fixture f,
		player p
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND PlayerID = <cfqueryparam value = #PI# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND f.FixtureDate <= '#CutOffDate3#'
		AND a.Card = 1
		AND a.FixtureID = f.id 
		AND a.PlayerID = p.ID
	GROUP BY
		a.playerid
	HAVING 
		totalcard >= #MaxCardCount3#
	ORDER BY
		totalcard DESC		
</CFQUERY>
