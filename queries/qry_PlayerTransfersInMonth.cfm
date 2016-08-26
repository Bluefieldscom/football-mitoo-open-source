<!--- called by PlayerTransfersInMonth.cfm --->
<cfquery name="MultipleRegistrations" datasource="#request.DSN#">
	SELECT PlayerID FROM register
	WHERE leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		GROUP BY PlayerID HAVING count(PlayerID) > 1 
</cfquery>
<cfset PlayerIDList = ValueList(MultipleRegistrations.PlayerID)>
<cfif PlayerIDList IS ''>
	<span class="pix13"><br />None</span>
	<cfabort>
</cfif>
<cfquery name="PlayerMovementList" datasource="#request.DSN#">
	SELECT
		r.ID as RI, 
		r.RegType,
		r.FirstDay as FirstDayOfRegistration,
		r.LastDay as LastDayOfRegistration,
		p.Surname,
		p.Forename,
		p.ID as ID, 
		p.Notes as PlayerNotes, 
		t.LongCol as TeamName, 
		t.ID as TeamID,
		p.MediumCol as DOB, 
		p.ShortCol as RegNo
	FROM
		(player AS p LEFT OUTER JOIN register AS r 
			ON p.ID = r.PlayerID) 
			LEFT OUTER JOIN team AS t 
				ON r.TeamID = t.ID 
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND NOT (r.PlayerID IS NOT NULL AND r.TeamID  IS NULL)
		AND p.shortcol <> 0 <!--- ignore Own Goal --->
			AND p.ID IN (#PlayerIDList#)
		AND (#url.MonthNo# = MONTH(r.FirstDay) OR #url.MonthNo# = MONTH(r.LastDay))
	ORDER BY
			Surname, Forename, FirstDayOfRegistration
</cfquery>
