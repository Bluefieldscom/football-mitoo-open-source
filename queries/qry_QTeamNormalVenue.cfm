<!--- called by LUList.cfm for Team output --->
<cfquery name="QTeamNormalVenue" datasource="#request.DSN#">
	SELECT 
		DISTINCT CASE
			WHEN o.longcol IS NULL THEN t.longcol
			ELSE CONCAT(t.longcol, ' ', o.longcol)
		END
			as TeamName,
		t.ID as ThisTeamID,
		o.ID as ThisOrdinalID
	FROM
		constitution c, 
		team t, 
		ordinal o
	WHERE 
		c.LeagueCode =  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND Trim(t.shortcol) <> 'Guest'
		AND CONCAT(c.teamid,' ',c.ordinalid) NOT IN (SELECT CONCAT(teamid,' ',ordinalid) FROM teamdetails WHERE leaguecode=c.LeagueCode AND VenueID > 0 )
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID
	ORDER BY
		TeamName		
</cfquery>
