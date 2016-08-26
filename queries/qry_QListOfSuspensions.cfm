<!--- called by ExportSuspendedPlayers.cfm --->

<CFQUERY NAME="QListOfSuspensions" datasource="#request.DSN#">
	SELECT
		s.FirstDay as FirstDayOfSuspension, 
		s.LastDay as LastDayOfSuspension, 
		s.NumberOfMatches,
		p.Surname,
		p.Forename,
		p.ID as ID, 
		p.Notes as PlayerNotes, 
		p.MediumCol as DOB, 
		p.ShortCol as RegNo,
		t.LongCol as TeamName
	FROM
		player AS p LEFT OUTER JOIN suspension AS s 
				ON s.PlayerID = p.ID
				LEFT OUTER JOIN register AS r 
				ON s.PlayerID = r.PlayerID
				LEFT OUTER JOIN team AS t 
				ON r.TeamID = t.ID
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.surname IS NOT NULL
		AND p.shortcol <> 0 
		AND (s.ID IS NOT NULL AND s.FirstDay IS NOT NULL)
		AND ( now() BETWEEN 
						CASE
						WHEN r.FirstDay IS NULL
						THEN '1900-01-01'
						ELSE r.FirstDay
						END
					 AND 
						CASE
						WHEN r.LastDay IS NULL
						THEN '2999-12-31'
						ELSE r.LastDay
						END )		
	ORDER BY
		Surname, Forename, RegNo, FirstDayOfSuspension;
</cfquery>	
