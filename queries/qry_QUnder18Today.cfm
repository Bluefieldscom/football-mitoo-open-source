<!--- Called by RegisteredPlayers.cfm --->
<cfquery name="QUnder18Today" datasource="#request.DSN#" >
SELECT
	t.longcol as clubname,
	p.shortcol as regno,
	p.surname,
	p.forename,
	p.mediumcol as DOB,
	firstday,
	lastday 
FROM 
	 register r, 
	 team t, 
	 player p 
WHERE
	r.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND	
		CASE
		WHEN p.MediumCol IS NULL
		THEN 0
		ELSE p.MediumCol BETWEEN '#DateFormat(DateAdd("d", 1, CutOffDate),"YYYY-MM-DD")#' AND '#DateFormat(DateAdd("yyyy", 1, CutOffDate),"YYYY-MM-DD")#'
		END
	AND r.teamID=t.id 
	AND r.playerID=p.ID 
ORDER BY 
	t.longcol, p.surname, p.forename, firstday
</cfquery>