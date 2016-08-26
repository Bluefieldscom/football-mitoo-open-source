<!--- called by DateRange.cfm --->

<cfquery name="MultipleRegistrations" datasource="#request.DSN#">
	SELECT
		PlayerID
	FROM 
		register
	WHERE 
		leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND 
		((FirstDay BETWEEN '#request.Date001#' AND '#request.Date002#')	OR (LastDay BETWEEN '#request.Date001#' AND '#request.Date002#'))
	GROUP BY 
		PlayerID 
	HAVING 
		count(PlayerID) > 1 
</cfquery>

<cfset PlayerIDList = ValueList(MultipleRegistrations.PlayerID)>
<cfif ListLen(PlayerIDList) IS 0 >
	<cfset PlayerIDList = ListAppend(PlayerIDList, 0)>
</cfif>


<cfquery name="TransferredPlayersByDate" datasource="#request.DSN#">
	SELECT
		r.ID as RI, 
		r.RegType,
		r.FirstDay as FirstDayOfRegistration,
		r.LastDay as LastDayOfRegistration,
		p.Surname,
		p.Forename,
		p.ID as PID, 
		p.MediumCol as DOB, 
		p.ShortCol as RegNo,
		t.LongCol as TeamName, 
		t.ID as TeamID
	FROM
		register r, 
		player p,
		team t
	WHERE
		p.ID IN (#PlayerIDList#)
		AND r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND NOT (r.PlayerID IS NOT NULL AND r.TeamID  IS NULL)
		AND p.shortcol <> 0 <!--- ignore Own Goal --->
		AND p.ID = r.PlayerID
		AND r.TeamID = t.ID
		
		ORDER BY 
			CONCAT(Surname,Forename,p.ID), FirstDayOfRegistration
</cfquery>
