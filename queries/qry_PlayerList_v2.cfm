<!--- Called by UpdateMatchBans.cfm --->

<!--- added July 18 2010 to get rid of any uunwanted suspensions --->
<!--- get rid of any unused suspensions --->
<cfinclude template = "del_QDeleteAllEmptySuspension.cfm">
<CFQUERY NAME="PlayerList" datasource="#request.DSN#">
	SELECT
		r.ID as RI, 
		r.RegType,
		r.FirstDay as FirstDayOfRegistration,
		r.LastDay as LastDayOfRegistration,
		s.ID as SI, 
		s.FirstDay as FirstDayOfSuspension, 
		s.LastDay as LastDayOfSuspension, 
		s.NumberOfMatches,
		p.Surname,
		p.Forename,
		p.ID as ID, 
		p.Notes as PlayerNotes, 
		t.LongCol as TeamName, 
		t.ID as TeamID,
		IF(p.MediumCol IS NULL, '', p.MediumCol) as DOB,
		p.ShortCol as RegNo
	FROM
		((player AS p LEFT OUTER JOIN register AS r 
			ON p.ID = r.PlayerID) 
			LEFT OUTER JOIN team AS t 
				ON r.TeamID = t.ID) 
			LEFT OUTER JOIN suspension AS s 
				ON s.PlayerID = p.ID
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND t.ID IN (SELECT TeamID FROM leaguetable WHERE DivisionID = #ThisDivisionID#)
		AND NOT (r.PlayerID IS NOT NULL AND r.TeamID  IS NULL)
		AND p.shortcol <> 0 <!--- ignore Own Goal --->
		AND s.ID IS NOT NULL AND s.FirstDay IS NOT NULL AND	s.NumberOfMatches > 0
	ORDER BY
			Surname, Forename, RegNo, FirstDayOfRegistration, FirstDayOfSuspension
</CFQUERY>
