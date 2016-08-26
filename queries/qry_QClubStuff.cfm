<!--- called by ClubList.cfm --->

<CFQUERY NAME="QClubStuff" datasource="#request.DSN#">
	SELECT 
		t.LongCol as ClubName,
		t.Notes as TeamInfo,
		t.ID as TeamID,
		t.ShortCol as HomeGuest,
		t.FACharterStandardType,
		t.ParentCountyFA,
		t.AffiliationNo,
		c.DivisionID,
		o.LongCol as OrdnlName,
		o.ID as OrdinalID,
		d.LongCol as DivnName,
		d.ShortCol as DivnAbbrev,
		d.MediumCol,
		d.Notes as DivNotes
	FROM
		team AS t,
		constitution AS c,
		division AS d,
		ordinal AS o
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND t.ID = <cfqueryparam value = #fmTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c.TeamID = <cfqueryparam value = #fmTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c.DivisionID = d.ID 
		AND c.OrdinalID = o.ID
	ORDER BY
		OrdnlName, MediumCol <!--- o.LongCol, d.MediumCol --->
</CFQUERY>
