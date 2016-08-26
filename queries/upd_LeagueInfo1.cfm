<!--- called by LeagueInfoUpdate.cfm --->

<cfquery name="QUpdate" datasource="ZMAST" >
	UPDATE
		leagueinfo
	SET
		SeasonStartDate = #CreateODBCDate(Form.SeasonStartDate)#,
		SeasonEndDate = #CreateODBCDate(Form.SeasonEndDate)#,				
		CountiesList = '#Form.CountiesList#',
		NameSort ='#Form.NameSort#',
		LeagueName = <cfqueryparam value = '#Form.LeagueName#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="80">,
		BadgeJpeg = '#Form.BadgeJpeg#',
		WebsiteLink = '#Form.WebsiteLink#',
		VenueAndPitchAvailable = #Form.VenueAndPitchAvailable#,
		Alert = #Form.Alert#,
		RandomPlayerRegNo = #Form.RandomPlayerRegNo#,
		FANPlayerRegNo = #Form.FANPlayerRegNo#,
		DefaultDivisionID = #Form.DefaultDivisionID#,
		PointsForWin = '#Form.PointsForWin#',
		PointsForDraw = '#Form.PointsForDraw#',
		PointsForLoss = '#Form.PointsForLoss#',
		LeagueTblCalcMethod = '#Form.LeagueTblCalcMethod#',
		SeasonName = '#Form.SeasonName#',		
		DefaultYouthLeague = '#Form.DefaultYouthLeague#',
		DefaultGoalScorers = '#Form.DefaultGoalScorers#',
		ShowAssessor = '#Form.ShowAssessor#',
		RefMarksOutOfHundred = '#Form.RefMarksOutOfHundred#',
		SportsmanshipMarksOutOfHundred = '#Form.SportsmanshipMarksOutOfHundred#',
		SuppressTeamSheetEntry = '#Form.SuppressTeamSheetEntry#',
		SuppressRedYellowCardsEntry = '#Form.SuppressRedYellowCardsEntry#',
		SuppressTeamCommentsEntry = '#Form.SuppressTeamCommentsEntry#',
		SuppressTeamDetailsEntry = '#Form.SuppressTeamDetailsEntry#',
		SuppressKOTimeEntry = '#Form.SuppressKOTimeEntry#',
		SuppressLeadingGoalscorers = '#Form.SuppressLeadingGoalscorers#',
		SuppressScorelineEntry = '#Form.SuppressScorelineEntry#',
		GoalrunTeamSheet = '#Form.GoalrunTeamSheet#',
		HideThisSeason = '#Form.HideThisSeason#',
		NoPlayerReRegistrationForm = '#Form.NoPlayerReRegistrationForm#',
		ShowOnGoalrunOnly = '#Form.ShowOnGoalrunOnly#',
		MatchBasedSuspensions = '#Form.MatchBasedSuspensions#',
		HideSuspensions = '#Form.HideSuspensions#',
		SuspensionStartsAfter = '#Form.SuspensionStartsAfter#',
		KickOffTimeOrder = '#Form.KickOffTimeOrder#',
		ClubsCanInputSportsmanshipMarks = '#Form.ClubsCanInputSportsmanshipMarks#',
		LeagueType = '#Form.LeagueType#',
		RefereeLowMarkWarning = '#Form.RefereeLowMarkWarning#',
		SeeOppositionTeamSheet = '#Form.SeeOppositionTeamSheet#',
		RefereeMarkMustBeEntered = '#Form.RefereeMarkMustBeEntered#',
		spare01 = '#Form.spare01#',
		spare02 = '#Form.spare02#',
		HideDoubleHdrMsg = '#Form.HideDoubleHdrMsg#' 
	WHERE
		ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<cfquery name="QUpdate" datasource="zmast" >
	UPDATE
		identity
	SET
		Pwd = '#Form.Password#'		
	WHERE
		leaguecodeprefix = '#LeagueCodePrefix#';
</cfquery>

