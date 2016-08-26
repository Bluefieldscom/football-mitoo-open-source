<!--- Called by MissingHospitalityMarks.cfm --->
<cfquery name="QMissingHospitalityMarks" datasource="#request.DSN#" >
	SELECT
		t1.longCol as HomeTeam,
		t2.longCol as AwayTeam,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.longCol as HomeOrdinal,
		o2.longCol as AwayOrdinal,
		k.LongCol as RoundName,
		f.MatchNumber as MatchNumber,
		f.HomeID,
		f.AwayID,
		f.HospitalityMarks,
		f.FixtureDate,
		f.FixtureNotes,
		f.HomeGoals,
		f.AwayGoals,
		f.Result,
		f.ID as FID,
		d.LongCol as DivName,
		d.ID as DID
	FROM
		fixture AS f,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		koround AS k,
		division AS d
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID NOT IN 
			(SELECT ID 
				FROM fixture 
				WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND FixtureNotes LIKE '%TEAM SHEET MISSING%') 
		AND f.FixtureDate < #CreateODBCDate(NOW()- 3 )# 
		AND f.ID NOT IN 
			(SELECT ID 
				FROM fixture 
				WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND result IN ('H','A','D')) 
		AND d.ID NOT IN 
			(SELECT ID 
				FROM division 
				WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND notes LIKE '%External%') 
		AND f.HospitalityMarks IS NULL 
		AND f.HomeID = c1.ID 
		AND f.AwayID = c2.ID 
		AND t1.ID = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.ID = c2.TeamID 
		AND o2.id = c2.OrdinalID 
		AND f.KORoundID = k.ID 
		AND d.id = c1.DivisionID 
	ORDER BY
		FixtureDate DESC, d.MediumCol, MatchNumber, HomeTeam, AwayTeam 
</cfquery>
