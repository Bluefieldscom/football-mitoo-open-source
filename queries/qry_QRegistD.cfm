<!--- called by RegListText.cfm--->

<CFQUERY NAME="QRegistD" datasource="#request.DSN#">
	SELECT
		<!--- CONCAT(p.Surname, " ", p.Forename) as PlayerName , --->
		p.Surname as Surname ,
		p.Forename as Forename ,
		p.MediumCol as PlayerDOB ,
		p.ShortCol as PlayerRegNo ,
		p.notes as PlayerNotes ,
		p.FAN as FAN ,
		t.LongCol as ClubName , 
		r.ID as RID ,
		r.PlayerID as RPID ,
		r.TeamID as RTID ,
		r.FirstDay as FirstDayOfRegistration,
		r.LastDay as LastDayOfRegistration,
		r.RegType,
		IF(DateDiff(Now(),r.LastDay) > 0, 'B', 'A') as ExpiredReg
	FROM
		register AS r, 
		player AS p, 
		team AS t
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND
			r.TeamID = <cfqueryparam value = #TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
			AND
		r.PlayerID=p.ID 
		AND r.TeamID=t.ID
	ORDER BY
		ClubName, ExpiredReg, Surname, Forename, FirstDayOfRegistration
</CFQUERY>

