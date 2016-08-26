<!--- called by Goalscorer.cfm --->

<cfquery name="QGoalscorer" datasource="#request.DSN#" >
	SELECT
		a.PlayerID as PlayerID,
		p.Surname,
		p.Forename,
		p.ShortCol as PlayerNo,
		COUNT(p.ID) as GamesPlayed,
		COALESCE(SUM(a.GoalsScored),0) as Goals
	FROM
		appearance AS a,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND p.shortcol <> 0 <!--- ignore own goal --->
		AND p.ID = a.PlayerID
	GROUP BY
		PlayerID, Surname, Forename, PlayerNo
	HAVING
		Goals > 0
	ORDER BY
		Goals DESC, Surname, Forename
</cfquery>
