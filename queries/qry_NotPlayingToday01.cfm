<!--- called by TeamsNotPlayingToday.cfm --->

<CFQUERY NAME="NotPlayingToday01" datasource="#request.DSN#" >
	SELECT
		c1.TeamID as HomeTeamTID,
		c1.OrdinalID as HomeTeamOID,
		c2.TeamID as AwayTeamTID,
		c2.OrdinalID as AwayTeamOID
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.FixtureDate = '#DateFormat(MDate, "YYYY-MM-DD")#' 
		AND c1.ID = f.HomeID 
		AND c2.ID = f.AwayID
</CFQUERY>
