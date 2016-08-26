<cfquery name="QAllRegistn" datasource="#request.DSN#">
	SELECT
		LEFT(p.Surname,1) as Alpha,
		p.Surname,
		p.Forename,
		p.MediumCol as PlayerDOB ,
		t.LongCol as ClubName , 
		r.FirstDay as FirstDayOfRegistration,
		r.LastDay as LastDayOfRegistration,
		r.RegType
	FROM
		register AS r, 
		player AS p, 
		team AS t
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND
		r.PlayerID=p.ID 
		AND r.TeamID=t.ID
	ORDER BY
		Surname, Forename, PlayerDOB, FirstDayOfRegistration
</cfquery>

