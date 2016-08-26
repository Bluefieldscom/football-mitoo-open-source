<!--- called by TeamsNotPlayingToday.cfm --->

<cfquery name="NotPlayingToday02" datasource="#request.DSN#" >
	SELECT
		DISTINCT t.LongCol as TeamName,
		o.LongCol as OrdinalName,
		d.shortcol as DivisionName,
		t.ID as TID,
		o.ID as OID
	FROM
		division AS d,
		constitution AS c,
		team AS t,		
		ordinal AS o
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.ID NOT IN (#CIDList#) 
		AND t.ID NOT IN
			(SELECT ID 
				FROM team 
				WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND (LEFT(Notes,7) = 'NoScore' 
					OR ShortCol = 'GUEST' 
					OR LongCol IS NULL )) 
		AND c.TeamID = t.ID 
		AND c.OrdinalID = o.ID 
		AND c.DivisionID = d.ID 
		AND d.ID NOT IN 
			(SELECT ID 
				FROM division 
				WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
					 AND (LongCol = 'Miscellaneous' OR LEFT(Notes,2) = 'KO'))
	ORDER BY
		 d.mediumcol, TeamName, OrdinalName
</cfquery>
