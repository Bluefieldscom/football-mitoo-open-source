<!--- called by PlayedUnderSuspension.cfm --->

<cfquery NAME="PlayedWhileSuspended" datasource="#request.DSN#">
	SELECT
		a.HomeAway ,
		f.fixturedate ,
		f.ID as FID ,
		s.firstday, 
		s.lastday,
		p.surname, 
		p.forename,
		t.LongCol as RegTeam,
		t1.Longcol as HomeClub,
		o1.LongCol as HomeOrdinal,
		t2.LongCol as AwayClub, 
		o2.LongCol as AwayOrdinal
	FROM 
		fixture f ,
		appearance a ,
		suspension s ,
		player p ,
		register r ,
		team t ,
		constitution c1 ,
		constitution c2 ,
		team t1 ,
		team t2 ,
		ordinal o1 ,
		ordinal o2
	WHERE 
		s.leaguecode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND a.fixtureid = f.id
		AND c1.ID = f.HomeID
		AND c2.ID = f.AwayID
		AND p.id = a.playerid
		AND r.playerid = p.id
		AND t.ID = r.TeamID
		AND a.playerid = s.playerid
		AND t1.ID = c1.TeamID
		AND o1.ID = c1.OrdinalID
		AND t2.ID = c2.TeamID
		AND o2.ID = c2.OrdinalID
		AND f.fixturedate >= s.firstday
		AND f.fixturedate <=s.lastday
	order by 
		f.fixturedate;
</cfquery>