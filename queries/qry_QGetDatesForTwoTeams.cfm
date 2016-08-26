<!--- called by FutureScheduledDates.cfm  --->
<cfquery NAME="QGetDatesForTwoTeams" datasource="#request.DSN#">
	SELECT
		f.ID as FID,
		d.ID as DID,
		c1.ID as HID,
		c2.ID as AID,
		f.fixturedate,
		t1.ID as TID1,
		t2.ID as TID2,
		t1.longcol,
		t2.longcol,
		IF(o1.longcol IS NULL, t1.longcol, CONCAT(t1.longcol, ' ', o1.longcol)) as HomeTeam, 
		IF(o2.longcol IS NULL, t2.longcol, CONCAT(t2.longcol, ' ', o2.longcol)) as AwayTeam, 
		d.longcol as DivisionName
	FROM
		fixture f,
		division d,
		constitution c1,
		team t1,
		ordinal o1,
		constitution c2,
		team t2,
		ordinal o2
	WHERE
	
		f.leaguecode='#LeagueCodePrefix#'
		AND f.fixturedate = '#DateFormat(ThisDate,"YYYY-MM-DD")#'
		AND
		(
		f.homeid IN 
		(select c.ID from constitution c where c.leaguecode='#LeagueCodePrefix#' 
		AND ((c.teamID=#Request.TIDSelected1# AND c.ordinalID=#Request.OIDSelected1#) OR (c.teamID=#Request.TIDSelected2# AND c.ordinalID=#Request.OIDSelected2#))) 
		or 
		f.awayid IN 
		(select c.ID from constitution c where c.leaguecode='#LeagueCodePrefix#' 
		AND ((c.teamID=#Request.TIDSelected1# AND c.ordinalID=#Request.OIDSelected1#) OR (c.teamID=#Request.TIDSelected2# AND c.ordinalID=#Request.OIDSelected2#))) 
		)
		AND f.homeid=c1.id
		AND f.awayid=c2.id
		AND c1.teamid=t1.id
		AND c2.teamid=t2.id
		AND c1.ordinalid=o1.id
		AND c2.ordinalid=o2.id
		AND c1.divisionid=d.id
	ORDER BY
		t1.longcol,
		t2.longcol
</cfquery>
