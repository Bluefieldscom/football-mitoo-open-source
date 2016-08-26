<!--- called by MtchDay.cfm --->
<cfquery name="QTeamStartingLineUpAway" datasource="#request.DSN#" >
	SELECT
		s.NominalShirtNumber,
		s.ActualShirtNumber,
		a.Card,
		a.Activity,
		a.HomeAway,
		p.surname,
		p.forename
	FROM
		shirtnumber s,
		appearance a,
		player p
	WHERE 
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.FixtureID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND a.HomeAway = 'A'
		AND s.AppearanceID = a.ID
		AND a.playerid = p.ID
	ORDER BY 
		Activity, NominalShirtNumber
</cfquery>
