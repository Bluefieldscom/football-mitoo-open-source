<cfquery name="UpdtFixture" datasource="#request.DSN#" >
UPDATE
	fixture
SET
	<cfif IsDate(form.KOTime)>
		KOTime = '#TimeFormat(form.KOTime, "HH:mm")#'
	<cfelse>
		KOTime = NULL
	</cfif>,

	<cfif KO IS "No">
		HomePointsAdjust = #Form.HomePointsAdjust#,
		AwayPointsAdjust = #Form.AwayPointsAdjust#,
	</cfif>
	HomeGoals = 
		<cfif Trim(Form.HomeGoals) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.HomeGoals# 
				cfsqltype="CF_SQL_INTEGER" maxlength="3">
		</cfif>,
	AwayGoals = 
		<cfif Trim(Form.AwayGoals) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AwayGoals# 
				cfsqltype="CF_SQL_INTEGER" maxlength="3">
		</cfif>,
	Result =
	<cfif Form.RadioButton IS "Result">
		NULL
	<cfelseif Form.RadioButton IS "Home Win">
		'H'
	<cfelseif Form.RadioButton IS "Away Win">
		'A'
	<cfelseif Form.RadioButton IS "Home Win on penalties">
		'U'
	<cfelseif Form.RadioButton IS "Away Win on penalties">
		'V'
	<cfelseif Form.RadioButton IS "Drawn">
		'D'
	<cfelseif Form.RadioButton IS "Postponed">
		'P'
	<cfelseif Form.RadioButton IS "Abandoned">
		'Q'
	<cfelseif Form.RadioButton IS "Void">
		'W'
	<cfelseif Form.RadioButton IS "TEMP">
		'T'
	<cfelse>
		NULL
	</cfif>,
	HomeTeamNotes = '#Left(Trim(Form.HomeTeamNotes),255)#',
	AwayTeamNotes = '#Left(Trim(Form.AwayTeamNotes),255)#',
	FixtureNotes = 	
		<cfif Trim(#TextNotes#) IS "" >
			NULL  
		<cfelse>
			'#Trim(TextNotes)#' 
		</cfif>,
	PrivateNotes = '#Trim(PrivateNotes)#',	
	RefereeID = <cfqueryparam value = #Form.RefereeID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
	AsstRef1ID = <cfqueryparam value = #Form.AsstRef1ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
	AsstRef2ID = <cfqueryparam value = #Form.AsstRef2ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
	FourthOfficialID = <cfqueryparam value = #Form.FourthOfficialID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
	AssessorID = <cfqueryparam value = #Form.AssessorID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
	RefereeMarksH = 
		<cfif Trim(Form.RefereeMarksH) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.RefereeMarksH# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,	
	RefereeMarksA = 
		<cfif Trim(Form.RefereeMarksA) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.RefereeMarksA# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,	
	AsstRef1Marks = 
		<cfif Trim(Form.AsstRef1Marks) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AsstRef1Marks# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,			
	AsstRef2Marks = 
		<cfif Trim(Form.AsstRef2Marks) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AsstRef2Marks# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,
	AssessmentMarks = 
		<cfif Trim(Form.AssessmentMarks) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AssessmentMarks# cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,		
				
	Attendance = 
		<cfif Trim(Form.Attendance) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.Attendance# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,
	HospitalityMarks = 
		<cfif Trim(Form.HospitalityMarks) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.HospitalityMarks# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,
	HomeClubOfficialsBenches =
	<cfif Form.HomeClubOfficialsBenches IS "">
		NULL
	<cfelseif Form.HomeClubOfficialsBenches IS "Excellent">
		'Excellent'
	<cfelseif Form.HomeClubOfficialsBenches IS "Good">
		'Good'
	<cfelseif Form.HomeClubOfficialsBenches IS "Satisfactory">
		'Satisfactory'
	<cfelseif Form.HomeClubOfficialsBenches IS "Poor">
		'Poor'
	<cfelse>
		Error: HomeClubOfficialsBenches in upd_UpdtFixture.cfm
		<cfabort>
	</cfif>	,
	AwayClubOfficialsBenches =
	<cfif Form.AwayClubOfficialsBenches IS "">
		NULL
	<cfelseif Form.AwayClubOfficialsBenches IS "Excellent">
		'Excellent'
	<cfelseif Form.AwayClubOfficialsBenches IS "Good">
		'Good'
	<cfelseif Form.AwayClubOfficialsBenches IS "Satisfactory">
		'Satisfactory'
	<cfelseif Form.AwayClubOfficialsBenches IS "Poor">
		'Poor'
	<cfelse>
		Error: AwayClubOfficialsBenches in upd_UpdtFixture.cfm
		<cfabort>
	</cfif>	,
	StateOfPitch =
	<cfif Form.StateOfPitch IS "">
		NULL
	<cfelseif Form.StateOfPitch IS "Excellent">
		'Excellent'
	<cfelseif Form.StateOfPitch IS "Good">
		'Good'
	<cfelseif Form.StateOfPitch IS "Satisfactory">
		'Satisfactory'
	<cfelseif Form.StateOfPitch IS "Poor">
		'Poor'
	<cfelse>
		Error: StateOfPitch in upd_UpdtFixture.cfm
		<cfabort>
	</cfif>	,
	ClubFacilities =
	<cfif Form.ClubFacilities IS "">
		NULL
	<cfelseif Form.ClubFacilities IS "Excellent">
		'Excellent'
	<cfelseif Form.ClubFacilities IS "Good">
		'Good'
	<cfelseif Form.ClubFacilities IS "Satisfactory">
		'Satisfactory'
	<cfelseif Form.ClubFacilities IS "Poor">
		'Poor'
	<cfelse>
		Error: ClubFacilities in upd_UpdtFixture.cfm
		<cfabort>
	</cfif>	,
	Hospitality =
	<cfif Form.Hospitality IS "">
		NULL
	<cfelseif Form.Hospitality IS "Excellent">
		'Excellent'
	<cfelseif Form.Hospitality IS "Good">
		'Good'
	<cfelseif Form.Hospitality IS "Satisfactory">
		'Satisfactory'
	<cfelseif Form.Hospitality IS "Poor">
		'Poor'
	<cfelse>
		Error: Hospitality in upd_UpdtFixture.cfm
		<cfabort>
	</cfif>	,
	HomeSportsmanshipMarks = 
		<cfif Trim(Form.HomeSportsmanshipMarks) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.HomeSportsmanshipMarks# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,		
	AwaySportsmanshipMarks = 
		<cfif Trim(Form.AwaySportsmanshipMarks) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AwaySportsmanshipMarks# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,		
	KORoundID = <cfqueryparam value = #Form.KORoundID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
	FixtureDate = '#DateFormat(MatchDate,"YYYY-MM-DD")#',
	AsstRef1MarksH = 
		<cfif Trim(Form.AsstRef1MarksH) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AsstRef1MarksH# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,			
	AsstRef2MarksH = 
		<cfif Trim(Form.AsstRef2MarksH) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AsstRef2MarksH# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,		
	AsstRef1MarksA = 
		<cfif Trim(Form.AsstRef1MarksA) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AsstRef1MarksA# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,			
	AsstRef2MarksA = 
		<cfif Trim(Form.AsstRef2MarksA) IS "">
			NULL
		<cfelse>
			<cfqueryparam value = #Form.AsstRef2MarksA# 
				cfsqltype="CF_SQL_SMALLINT" maxlength="5">
		</cfif>,
	PitchAvailableID = <cfqueryparam value = #Form.PitchAvailableID# cfsqltype="CF_SQL_INTEGER" maxlength="8">,
	<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			RefereeReportReceived = #Form.RefereeReportReceived#,			
		</cfif>
	MatchOfficialsExpenses = 
		<cfif Trim(Form.MatchOfficialsExpenses) IS "">
			0.00
		<cfelse>
			#Form.MatchOfficialsExpenses#
		</cfif>
WHERE 
	LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #id# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

