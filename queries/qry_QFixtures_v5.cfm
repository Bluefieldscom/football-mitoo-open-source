<!--- called by FixturesTxt.cfm --->

<cfquery name="QFixtures" datasource="#request.DSN#" >
	SELECT
		t1.longcol as HomeTeam ,
		t2.longcol as AwayTeam ,
		t1.shortcol as HomeGuest ,
		t2.shortcol as AwayGuest ,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.longcol as HomeOrdinal ,
		o2.longcol as AwayOrdinal ,
		r.ID as RefsID ,
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RefsName ,
		r.mediumcol as RefsNo ,
		r1.ID as AR1ID ,
		CASE
		WHEN LENGTH(TRIM(r1.Forename)) = 0 AND LENGTH(TRIM(r1.Surname)) = 0
		THEN r1.LongCol
		ELSE CONCAT(r1.Forename, " ", r1.Surname)
		END
		as AR1Name ,
		r1.mediumcol as AR1No ,
		r2.ID as AR2ID ,
		CASE
		WHEN LENGTH(TRIM(r2.Forename)) = 0 AND LENGTH(TRIM(r2.Surname)) = 0
		THEN r2.LongCol
		ELSE CONCAT(r2.Forename, " ", r2.Surname)
		END
		as AR2Name ,
		r2.mediumcol as AR2No ,
		r3.ID as FourthOfficialID ,
		CASE
		WHEN LENGTH(TRIM(r3.Forename)) = 0 AND LENGTH(TRIM(r3.Surname)) = 0
		THEN r3.LongCol
		ELSE CONCAT(r3.Forename, " ", r3.Surname)
		END
		as FourthOfficialName ,
		r3.mediumcol as FourthOfficialNo ,
		k.longcol as RoundName ,
		d.longcol as DivName ,
		f.HomeID as FHomeID,
		f.AwayID as FAwayID,
		f.MatchNumber as MatchNumber ,	
		f.FixtureDate ,
		f.FixtureNotes,
		f.KOTime,
		f.PrivateNotes,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as Homegoals,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as Awaygoals,
		f.Result as Result,
		(SELECT CONCAT(v.LongCol, IF(pn.LongCol=' 1','',CONCAT(' (Pitch', pn.LongCol, ')'))     ) FROM pitchavailable h, venue v, pitchno pn WHERE f.PitchAvailableID=h.ID AND h.VenueID = v.ID AND h.PitchNoID = pn.ID) as VenueDetails
	FROM
		fixture AS f,
		referee AS r,
		referee AS r1,
		referee AS r2,
		referee AS r3,
		koround AS k,
		constitution AS c1,
		constitution AS c2,
		team AS t1,
		team AS t2,
		ordinal AS o1,
		ordinal AS o2,
		division AS d
	WHERE
		c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >AND f.Result <> "T"</cfif>
		AND HomeID = c1.ID 
		AND AwayID = c2.ID 
		AND t1.ID = c1.TeamID 
		AND o1.id = c1.OrdinalID 
		AND t2.ID = c2.TeamID 
		AND o2.id = c2.OrdinalID 
		AND f.RefereeID = r.ID 
		AND f.AsstRef1ID = r1.ID 
		AND f.AsstRef2ID = r2.ID 
		AND f.FourthOfficialID = r3.ID 
		AND f.KORoundID = k.ID 
		AND d.id = c1.DivisionID
	ORDER BY
		FixtureDate, d.mediumcol, MatchNumber, HomeTeam, AwayTeam 
</cfquery>
