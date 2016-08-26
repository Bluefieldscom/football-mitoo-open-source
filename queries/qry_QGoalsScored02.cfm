<!--- called by LeagueTab.cfm --->

<!--- get every scoring player --->

<cfquery name="QGoals000" datasource="#request.DSN#">	
	SELECT
		DISTINCT PlayerID
	FROM
		appearance
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND goalsscored > 0
</cfquery>

<!--- save these players who scored in a list --->
<cfset PlayerIDList = ValueList(QGoals000.PlayerID)>
<!--- Get the total games played, total goals scored by each of these players in a specific Division
If they didn't score in this specific division, but scored in another division, ignore them (HAVING Goals > 0) --->
<cfquery name="QGoals001" datasource="#request.DSN#">	
	SELECT
		COUNT(a.PlayerID) as GamesPlayed,
		COALESCE(SUM(a.GoalsScored),0) as Goals,
		a.PlayerID
	FROM
		appearance a,
		fixture f ,
		constitution c
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND	a.playerid IN (#PlayerIDList#)
		AND a.FixtureID = f.ID
		AND f.HomeID = c.ID
		AND c.DivisionID = <cfqueryparam value = #DivisionID# cfsqltype="CF_SQL_INTEGER">
	GROUP BY
			a.PlayerID
	HAVING
		Goals > 0 
</cfquery>
<!--- get the scoring players' names --->
<cfquery name="QGoals002" datasource="#request.DSN#" >	
	SELECT
		ID,
		Surname,
		Forename 
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND id IN (#PlayerIDList#)
</cfquery>

<!--- get the club names,  only for the most recent ( i.e. MAX(r.lastday) ) club the player is registered to --->
<cfquery name="QGoals003" datasource="#request.DSN#" >	
SELECT
	t.LongCol as TeamName,
	r.playerid as PID,
	MAX(r.lastday) AS LD
FROM
	register r,
	team t
WHERE
	r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND r.PlayerID IN (#PlayerIDList#)
	AND r.TeamID = t.ID
GROUP BY
	playerid;
</cfquery>
<!--- combine columns using Query of Queries  --->
<cfquery name="QGoals004" dbtype="query">
	SELECT
		GamesPlayed,
		Goals,
		Surname,
		Forename,
		PlayerID
	FROM
		QGoals001,
		QGoals002
	WHERE
		QGoals001.PlayerID = QGoals002.ID
</cfquery>
<!--- further combine columns using Query of Queries  --->
<cfquery name="QGoalsScored02" dbtype="query" maxrows="20">
	SELECT
		GamesPlayed,
		Goals,
		Surname,
		Forename,
		TeamName
	FROM
		QGoals003,
		QGoals004
	WHERE
		QGoals003.PID = QGoals004.PlayerID
	ORDER BY
		Goals DESC, Surname, Forename
</cfquery>

