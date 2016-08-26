<!--- called by RefsHist.cfm, RefsHistPublic.cfm --->

<CFQUERY NAME="QRefereeHistory" datasource="#request.DSN#">
	<!---
	Present the user with a list of ALL the Matches officiated by the specified Referee
	across ALL competitions  (but still excludes F.A. Cup Competitions)
	--->
	SELECT
		f.FixtureDate ,
		f.ID as FID,
		k.LongCol as RoundName,
		f.Result ,
		f.HomeID ,
		f.AwayID ,
		f.HomeGoals ,
		f.AwayGoals ,
		f.RefereeID,
		f.AsstRef1ID,
		f.AsstRef2ID,
		f.FourthOfficialID,
		f.AssessorID,
		f.RefereeMarksH,
		f.RefereeMarksA,
		f.AsstRef1Marks,
		f.AsstRef2Marks,
		f.AsstRef1MarksH,
		f.AsstRef1MarksA,
		f.AsstRef2MarksH,
		f.AsstRef2MarksA,
		f.HomeSportsmanshipMarks,
		f.AwaySportsmanshipMarks,
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
				f.RefereeReportReceived, f.HideMatchOfficials, f.RefMatchCardAnswers, f.RefMatchCardProblems,
		</cfif>
		t1.LongCol as HomeTeam ,
		t2.LongCol as AwayTeam ,
		t1.ID as HomeTeamID,
		t2.ID as AwayTeamID,
		o1.LongCol as HomeOrdinal ,
		o2.LongCol as AwayOrdinal ,
		d.LongCol as CompetitionName,
		d.ID as DID,
		c1.ID as HID,
		c2.ID as AID,
		IF(d.notes LIKE '%HideDivision%','Yes','No') as HideScore
	FROM
		fixture AS f,
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
		AND ( f.RefereeID = <cfqueryparam value = #RI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
			OR f.AsstRef1ID = <cfqueryparam value = #RI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">   
			OR f.AsstRef2ID = <cfqueryparam value = #RI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
			OR f.FourthOfficialID = <cfqueryparam value = #RI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
			OR f.AssessorID = <cfqueryparam value = #RI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">	 ) 
		AND c1.ID = HomeID 
		AND c2.ID = AwayID 
		AND t1.ID = c1.TeamID 
		AND t2.ID = c2.TeamID 
		AND o1.ID = c1.OrdinalID 
		AND o2.ID = c2.OrdinalID 
		AND k.ID = f.KORoundID 
		AND d.ID = c1.DivisionID
	ORDER BY FixtureDate
</CFQUERY>

