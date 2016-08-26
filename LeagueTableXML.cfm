<!--- e.g. LeagueTableXML.cfm?LeagueCode=MDX2007&DivisionID=1332 --->

<cfif NOT StructKeyExists(url, "LeagueCode") >
	LeagueCode parameter missing
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "DivisionID") >
	DivisionID parameter missing
	<cfabort>
</cfif>
<cfset datasourcename = "fm#right(LeagueCode,4)#">
<cfquery name="QLeagueTable" datasource="#datasourcename#">
	SELECT
		l.ConstitutionID,
		l.TeamID,
		l.PointsAdjustment,
		l.Name as TeamName,
		l.rank,
		l.HomeGamesPlayed,
		l.HomeGamesWon,
		l.HomeGamesDrawn,
		l.HomeGamesLost,
		l.HomeGoalsFor,
		l.HomeGoalsAgainst,
		l.HomePoints,
		l.HomePointsAdjust,
		l.AwayGamesPlayed,
		l.AwayGamesWon,
		l.AwayGamesDrawn,
		l.AwayGamesLost,
		l.AwayGoalsFor,
		l.AwayGoalsAgainst,
		l.AwayPoints,
		l.AwayPointsAdjust,
		d.longcol as DivisionName
	FROM
		leaguetable l,
		division d
	WHERE
		l.DivisionID = #url.DivisionID#
		AND d.ID = l.DivisionID
	ORDER BY
		Rank
</cfquery>
<cfoutput>
	<xml>
    <leaguetable>
    <division>#QLeagueTable.DivisionName#</division>
</cfoutput>
<cfoutput query="QLeagueTable">
<cfset TotalPoints = HomePoints + HomePointsAdjust + AwayPoints + AwayPointsAdjust + PointsAdjustment> 
<cfset TotalPlayed = HomeGamesPlayed + AwayGamesPlayed> 
<cfset TotalGoalsFor = HomeGoalsFor + AwayGoalsFor>
<cfset TotalGoalsAgainst = HomeGoalsAgainst + AwayGoalsAgainst>
<cfset TotalGamesWon = HomeGamesWon + AwayGamesWon>
<cfset TotalGamesDrawn = HomeGamesDrawn + AwayGamesDrawn>
<cfset TotalGamesLost = HomeGamesLost + AwayGamesLost>
<cfset TotalPointsAdjustment = HomePointsAdjust + AwayPointsAdjust + PointsAdjustment> 
<row rank="#rank#">
	<teamname>#TeamName#</teamname>
	<gamesplayed>#TotalPlayed#</gamesplayed>
	<gameswon>#TotalGamesWon#</gameswon>
	<gamesdrawn>#TotalGamesDrawn#</gamesdrawn>
	<gameslost>#TotalGamesLost#</gameslost>
	<goalsfor>#TotalGoalsFor#</goalsfor>
	<goalsagainst>#TotalGoalsAgainst#</goalsagainst>
	<goaldiff>#(TotalGoalsFor-TotalGoalsAgainst)#</goaldiff>
	<points>#TotalPoints#</points>
	<pointsadjustment>#TotalPointsAdjustment#</pointsadjustment>
</row>	
</cfoutput>
<cfoutput>
    </leaguetable>
	</xml>
</cfoutput>
