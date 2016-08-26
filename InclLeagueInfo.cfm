<cfsilent>
<cfset DefaultTblName = "Matches" >
<CFPARAM name="LeagueCode" default="XXXX">
<!---
Get all the specific League Information from the row in table LeagueInfo (in ZMAST database) 
which has matching LeagueCode
--->
<cfinclude template="queries/qry_QLeagueCode.cfm">
</cfsilent>

<cfif QLeagueCode.RecordCount IS 0>
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfsilent>
<cfset LeagueName = QLeagueCode.LeagueName >
<cfset Namesort = QLeagueCode.Namesort >
<cfset SeasonStartDate = QLeagueCode.SeasonStartDate >
<cfset SeasonEndDate = QLeagueCode.SeasonEndDate >
<cfset SeasonName = QLeagueCode.SeasonName >
</cfsilent>

<cfif DateCompare( SeasonStartDate, SeasonEndDate ) IS NOT "-1" >
	<cfoutput>
	<span class="pix14boldred">
	Season Start Date #DateFormat(SeasonStartDate, 'DDDD, DD MMMM YYYY')# is not before 
		Season End Date #DateFormat(SeasonEndDate, 'DDDD, DD MMMM YYYY')# ....ABORTING....
	</span>
	</cfoutput>
	<CFABORT>
</cfif>

<cfsilent>
<cfset LeagueTblCalcMethod = QLeagueCode.LeagueTblCalcMethod >
<cfset DefaultLeagueCode = #LeagueCode# >
<cfset BadgeJpeg = QLeagueCode.BadgeJpeg >
<cfset WebsiteLink = QLeagueCode.WebsiteLink >
<cfset DefaultDivisionID = QLeagueCode.DefaultDivisionID >
<cfset CountiesList = QLeagueCode.CountiesList >
<cfset DefaultYouthLeague = QLeagueCode.DefaultYouthLeague >
<cfset LeagueBrand = QLeagueCode.LeagueBrand >
<cfset GoalrunTeamSheet = QLeagueCode.GoalrunTeamSheet >
<cfset HideThisSeason = QLeagueCode.HideThisSeason >
<cfset NoPlayerReRegistrationForm = QLeagueCode.NoPlayerReRegistrationForm >
<cfset ShowOnGoalrunOnly = QLeagueCode.ShowOnGoalrunOnly >
<cfset HideSuspensions = QLeagueCode.HideSuspensions >
<cfset MatchBasedSuspensions = QLeagueCode.MatchBasedSuspensions >
<cfset SuspensionStartsAfter = QLeagueCode.SuspensionStartsAfter >
<cfset KickOffTimeOrder = QLeagueCode.KickOffTimeOrder >
<cfset ClubsCanInputSportsmanshipMarks = QLeagueCode.ClubsCanInputSportsmanshipMarks >
<cfset ShowAssessor = QLeagueCode.ShowAssessor >
<cfset DefaultRulesAndFines = QLeagueCode.DefaultRulesAndFines >
<cfset DefaultGoalScorers = QLeagueCode.DefaultGoalScorers >
<cfset Alert = QLeagueCode.Alert >
<cfset VenueAndPitchAvailable = QLeagueCode.VenueAndPitchAvailable >
<cfset RandomPlayerRegNo = QLeagueCode.RandomPlayerRegNo > 
<cfset FANPlayerRegNo = QLeagueCode.FANPlayerRegNo >
<cfset request.LeagueID = QLeagueCode.ID >
<cfset LeagueCodePrefix = QLeagueCode.LeagueCodePrefix >
<cfset LeagueCodeYear = QLeagueCode.LeagueCodeYear >
<cfset LeagueType = QLeagueCode.LeagueType >
<cfset SuppressTeamSheetEntry = QLeagueCode.SuppressTeamSheetEntry >
<cfset SuppressRedYellowCardsEntry = QLeagueCode.SuppressRedYellowCardsEntry >
<cfset SuppressTeamCommentsEntry = QLeagueCode.SuppressTeamCommentsEntry >
<cfset SuppressTeamDetailsEntry = QLeagueCode.SuppressTeamDetailsEntry >
<cfset SuppressKOTimeEntry = QLeagueCode.SuppressKOTimeEntry >
<cfset SuppressLeadingGoalscorers = QLeagueCode.SuppressLeadingGoalscorers >
<cfset SuppressScorelineEntry = QLeagueCode.SuppressScorelineEntry >
<cfset PointsForWin  = QLeagueCode.PointsForWin >
<cfset PointsForDraw = QLeagueCode.PointsForDraw >
<cfset PointsForLoss = QLeagueCode.PointsForLoss >
<cfset MatchBanReminder = QLeagueCode.MatchBanReminder >
<cfset HideDoubleHdrMsg = QLeagueCode.HideDoubleHdrMsg >
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.RefMarksOutOfHundred = QLeagueCode.RefMarksOutOfHundred >
	<cfset session.SportsmanshipMarksOutOfHundred = QLeagueCode.SportsmanshipMarksOutOfHundred >
	<cfset session.RefereeLowMarkWarning = QLeagueCode.RefereeLowMarkWarning >
	<cfset session.SeeOppositionTeamSheet = QLeagueCode.SeeOppositionTeamSheet >
	<cfset session.RefereeMarkMustBeEntered = QLeagueCode.RefereeMarkMustBeEntered >
	<cfset session.spare01 = QLeagueCode.spare01 >
	<cfset session.spare02 = QLeagueCode.spare02 >
	<cfset session.HideDoubleHdrMsg = QLeagueCode.HideDoubleHdrMsg >
	<cfset session.LeagueCodePrefix = QLeagueCode.LeagueCodePrefix >
	<cfset session.SeasonStartDate = QLeagueCode.SeasonStartDate >
	<cfset session.SeasonEndDate = QLeagueCode.SeasonEndDate >
	<cfset session.LeagueType = QLeagueCode.LeagueType >
	<cfset session.LeagueID = request.LeagueID >
</cflock>

<cfset CounterText = "">
<!---
<cfoutput>
	<cfif Find("Football Association",LeagueName) AND NOT Find("League",LeagueName)>
		<cfset SiteType = "County F.A.">
	<cfelseif Find("Referees",LeagueName)>
		<cfset SiteType = "R.A.">
	<cfelse>
		<cfset SiteType = "league">
	</cfif>
</cfoutput>
--->
<!--- all counter data now on a single table in fmpagecount (MySQL) --->
<cfinclude template="queries/upd_QUpdateCounter.cfm">

<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cfinclude template="queries/qry_QReadCounter.cfm">
	<cfset CounterText = "#NumberFormat(QReadCounter.CounterValue, '999,999,999')# page requests since #DateFormat(QReadCounter.CounterStartDateTime, 'DD MMMM YYYY')#">
</cfif>

<cfinclude template="queries/qry_QCompetition.cfm">

<cfif VenueAndPitchAvailable IS "Yes">
	<cfinclude template="queries/qry_QVenue.cfm">
	<cfinclude template="queries/qry_QTeamOrdinal.cfm">
	
</cfif>

</cfsilent>
