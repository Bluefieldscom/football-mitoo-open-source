
<cfoutput>
<cfsilent>
<!--- Competition Description for Headings --->		
<cfinclude template="queries\qry_QGetLong.cfm">
<cfset ThisCompetitionDescription = "" >
<cfif GetLong.RecordCount IS 1>
	<cfset ThisCompetitionDescription = "#GetLong.CompetitionDescription#" >
</cfif>

<cfif TblName IS "Register">
	<cfinclude template="queries\qry_QGetTeam_v2.cfm">
</cfif>
</cfsilent>
<cfif FindNoCase("News.cfm", CGI.Script_Name)>
	<cfset heading01 = "Home Page">
	<cfset heading02 = ""><!---#DateFormat(Now(), 'DDDD, DD MMM YYYY')#"> --->
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("LeagueTab.cfm", CGI.Script_Name) >
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "League Table">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("LeagueTabExpand.cfm", CGI.Script_Name) >
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Expanded League Table">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MtchDay.cfm", CGI.Script_Name)>
	<cfset heading01 = "Match Day">

	<cfloop index="I" from="1" to="#ListLen(ListOfDistinctDates)#" step="1" >
		<cfset OldDateValue = ListGetAt(ListOfDistinctDates, I)>
		<cfset NewDateValue = DateFormat(OldDateValue)>
		<cfset ListOfDistinctDates = ListSetAt(ListOfDistinctDates, I, NewDateValue)>
	</cfloop>
	<cfset request.ThisMDateNo = #ListFind(ListOfDistinctDates, DateFormat(MDate))#>
	<cfif request.ThisMDateNo GT 1>
		<cfset request.PrevMDateNo = request.ThisMDateNo - 1>
		<cfset request.PrevMDate = ListGetAt(ListOfDistinctDates, request.PrevMDateNo)>
	<cfelse>
		<cfset request.PrevMDateNo = 0>
	</cfif>
	<cfif request.ThisMDateNo LT ListLen(ListOfDistinctDates)>
		<cfset request.NextMDateNo = request.ThisMDateNo + 1>
		<cfset request.NextMDate = ListGetAt(ListOfDistinctDates, request.NextMDateNo)>
	<cfelse>
		<cfset request.NextMDateNo = 0>
	</cfif>
	<cfset heading02 = "#DateFormat(MDate, 'DDDD, DD MMMM YYYY')#">
	<cfset SearchAdd = "No">
	
<cfelseif FindNoCase("FixtResMonth.cfm", CGI.Script_Name)>
	<cfset request.ThisMonthNo = #ListFind(ListOfDistinctMonths, MonthNo)#>
	<cfif request.ThisMonthNo GT 1>
		<cfset request.PrevMonthNo = request.ThisMonthNo - 1>
		<cfset request.PrevMonth = ListGetAt(ListOfDistinctMonths, request.PrevMonthNo)>
	<cfelse>
		<cfset request.PrevMonthNo = 0>
	</cfif>
	<cfif request.ThisMonthNo LT ListLen(ListOfDistinctMonths)>
		<cfset request.NextMonthNo = request.ThisMonthNo + 1>
		<cfset request.NextMonth = ListGetAt(ListOfDistinctMonths, request.NextMonthNo)>
	<cfelse>
		<cfset request.NextMonthNo = 0>
	</cfif>

	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Fixtures & Results for #MonthAsString(MonthNo)#" >
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ResultsGrid.cfm", CGI.Script_Name)>
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Fixtures & Results Grid">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("KOHist.cfm", CGI.Script_Name)>
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Knock Out History">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("Unsched.cfm", CGI.Script_Name)>
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Unscheduled Matches">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TeamHist.cfm", CGI.Script_Name)>
	<cfset heading02 = "#ThisCompetitionDescription#">
	<cfset heading01 = "#QTeam.Name#" & " " & "#QTeam.Ord#">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TeamHistAll.cfm", CGI.Script_Name)>
	<cfset heading02 = "All Competitions">
	<cfset heading01 = "#QTeam.Name#" & " " & "#QTeam.Ord#">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ListChoose.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfif TblName IS "Constitution">
		<cfset heading02 = "Constitution">
	<cfelseif TblName IS "PitchAvailable">
		<cfset heading02 = "Pitch Availability">
	<cfelseif TblName IS "Register">
		<cfset heading02 = "Registered Players">
	<cfelse>
		<cfset heading02 = "xxxxxxxxxxxxxx">
	</cfif>
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("LeagueTabXLS.cfm", CGI.Script_Name) >
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "League Table">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("LeagueTabExpandXLS.cfm", CGI.Script_Name) >
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Expanded League Table">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ConstitList.cfm", CGI.Script_Name)>
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Constitution">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PitchAvailableList.cfm", CGI.Script_Name) >
	<cfif StructKeyExists(url,"PA") >
		<cfif url.PA IS "Venue">
			<!--- get Venue Description for Heading using url.VenueID --->
			<cfset ThisVenueID = url.VenueID >
			<cfset HeadingVenueID = url.VenueID >		
			<cfinclude template="queries\qry_QGetVenueDescription.cfm">
			<cfset heading01 = "#GetVenueDescription.VenueDescription#">
			<cfset heading02 = "Pitch Availability by Venue">
			<cfset SearchAdd = "No">
		<cfelseif url.PA IS "Team">
			<!--- get Team Description for Heading using url.TeamID --->
			<cfset ThisTeamID = url.TeamID >
			<cfset ThisOrdinalID = url.OrdinalID >
			<cfset HeadingTeamID = url.TeamID >
			<cfset HeadingOrdinalID = url.OrdinalID >
			<cfinclude template="queries\qry_QGetTeamOrdinalDescription.cfm">
			<cfset heading01 = "#GetTeamOrdinalDescription.TeamOrdinalDescription#">
			<cfset heading02 = "Pitch Availability by Team">
			<cfset SearchAdd = "No">
		</cfif>
	<cfelseif  StructKeyExists(form,"PA") >
		<cfif form.PA IS "Venue">
			<!--- get Venue Description for Heading using form.VenueID --->
			<cfset ThisVenueID = form.VenueID >
			<cfset HeadingVenueID = form.VenueID >		
			<cfinclude template="queries\qry_QGetVenueDescription.cfm">
			<cfset heading01 = "#GetVenueDescription.VenueDescription#">
			<cfset heading02 = "Pitch Availability by Venue">
			<cfset SearchAdd = "No">
		<cfelseif form.PA IS "Team">
			<!--- get Team Description for Heading using form.TeamID --->
			<cfset ThisTeamID = GetToken(form.TeamIDOrdinalID, 1, '^' ) >
			<cfset ThisOrdinalID = GetToken(form.TeamIDOrdinalID, 2, '^' ) >
			<cfset HeadingTeamID = GetToken(form.TeamIDOrdinalID, 1, '^' ) >
			<cfset HeadingOrdinalID = GetToken(form.TeamIDOrdinalID, 2, '^' ) >
			
			<cfinclude template="queries\qry_QGetTeamOrdinalDescription.cfm">
			<cfset heading01 = "#GetTeamOrdinalDescription.TeamOrdinalDescription#">
			<cfset heading02 = "Pitch Availability by Team">
			<cfset SearchAdd = "No">
		</cfif>
	<cfelse>
		PitchAvailableList.cfm in Toolbar2.cfm - error - aborting <cfabort>
	</cfif>
<cfelseif FindNoCase("UpdateForm.cfm", CGI.Script_Name) AND TblName IS "PitchAvailable" AND StructKeyExists(url,"PA") AND url.PA IS "Venue">
	<!--- get Venue Description for Heading using URL.VenueID --->
	<cfset ThisVenueID = URL.VenueID >
	<cfset HeadingVenueID = URL.VenueID >
	<cfinclude template="queries\qry_QGetVenueDescription.cfm">
	<cfset heading01 = "#GetVenueDescription.VenueDescription#">
	<cfset heading02 = "Pitch Availability by Venue">
	<cfset SearchAdd = "No">
	
<cfelseif FindNoCase("UpdateForm.cfm", CGI.Script_Name) AND TblName IS "PitchAvailable" AND StructKeyExists(url,"PA") AND url.PA IS "Team">
	<!--- get Team & Ordinal Description for Heading using URL.TeamID and URL.OrdinalID --->
	<cfset ThisTeamID = URL.TeamID >
	<cfset ThisOrdinalID = URL.OrdinalID >
	<cfset HeadingTeamID = URL.TeamID >
	<cfset HeadingOrdinalID = URL.OrdinalID >
	
	<cfinclude template="queries\qry_QGetTeamOrdinalDescription.cfm">
	<cfset heading01 = "#GetTeamOrdinalDescription.TeamOrdinalDescription#">
	<cfset heading02 = "Pitch Availability by Team">
	<cfset SearchAdd = "No">
	
<cfelseif FindNoCase("UpdateForm.cfm", CGI.Script_Name) AND TblName IS "Constitution" >
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Constitution">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("UpdateForm.cfm", CGI.Script_Name) >
	<cfset heading01 = "#TblName#">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif TblName IS "MatchReport" OR FindNoCase("SeeMatchReport.cfm", CGI.Script_Name)>
	<cfset heading01 = "Match Report">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TopTwenty.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Top Twenty Goalscorers and Star Players in all Competitions">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("AttendanceStats.cfm", CGI.Script_Name)>
	<cfset heading01 = "#Getlong.CompetitionDescription#">
	<cfset heading02 = "Attendance Statistics">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PlayersHistory.cfm", CGI.Script_Name) OR FindNoCase("PlayersHistory2.cfm", CGI.Script_Name) OR FindNoCase("PlayersHistory3.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Player's Appearances">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TeamList.cfm", CGI.Script_Name)>
	<cfset heading01 = "Team Sheet">
	<cfset heading02 = "Player Appearances, Goals Scored, Yellow & Red Cards">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("StartingLineUpList.cfm", CGI.Script_Name)>
	<cfset heading01 = "Starting Line-Up and Substitutes">
	<cfset heading02 = "Players">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RegisteredList1.cfm", CGI.Script_Name) >
	<cfset heading01 = "#QGetTeam.ClubName#">
	<cfset heading02 = "Players with Current and Future Registrations">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RegisteredList2.cfm", CGI.Script_Name) >
	<cfset heading01 = "#QGetTeam.ClubName#">
	<cfset heading02 = "Players with Expired Registrations">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefsHist.cfm", CGI.Script_Name) >
	<cfset heading02 = "Referee's History">
	<cfif QReferee.RefsCode IS "">
		<cfset heading01 = "#QReferee.RefsName#">
	<cfelse>
		<cfset heading01 = "#QReferee.RefsName# ( #QReferee.RefsCode# )">
	</cfif>
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefsHistPublic.cfm", CGI.Script_Name) >
	<cfset heading02 = "Referee's History">
	<cfif QReferee.RefsCode IS "">
		<cfset heading01 = "#QReferee.RefsName#">
	<cfelse>
		<cfset heading01 = "#QReferee.RefsName# ( #QReferee.RefsCode# )">
	</cfif>
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ViewChange.cfm", CGI.Script_Name) >
	<cfset heading01 = "Change the mode in which you view <em>football.mitoo</em> screens">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
	
<cfelseif FindNoCase("RegisteredPlayers.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Registered Players Analysis">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PlayedUnderSuspension.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Played while under suspension">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PlayedWhileUnregistered.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Played while unregistered">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("Register.cfm", CGI.Script_Name) >
	<cfset heading01 = "">
	<cfset heading02 = "Registration of Interest">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("CheckPlayerAppearances.cfm", CGI.Script_Name) >
	<cfset heading01 = "">
	<cfset heading02 = "Check Player Appearances">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("EmailSetUpForm.cfm", CGI.Script_Name) >
	<cfset heading01 = "">
	<cfset heading02 = "Email Set Up">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ListOfReferees.cfm", CGI.Script_Name) >
	<cfset heading01 = "League Report">
	<cfset heading02 = "List of Referees">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefAnalysis.cfm", CGI.Script_Name) >
	<cfset heading01 = "League Report">
	<cfset heading02 = "Referee Coverage">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefAppoints.cfm", CGI.Script_Name) >
	<cfset heading01 = "League Report">
	<cfset heading02 = "Fixtures and Referee Appointments - Report 1">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefereesAvailability.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Referees' Availability by Date">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefereesAvailability2.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Referees' Availability by Name">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("FixturesTxt.cfm", CGI.Script_Name) >
	<cfset heading01 = "League Report">
	<cfset heading02 = "Fixtures and Referee Appointments - Report 2">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("SeeGoalscorers.cfm", CGI.Script_Name) >
	<cfset heading01 = "League Report">
	<cfset heading02 = "List of Goalscorers">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("SearchClubForm.cfm", CGI.Script_Name) >
	<cfset heading01 = "">
	<cfset heading02 = "Club Search">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("Help.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Telephone Support">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("LoginHistory.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Recent LogIn History">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("JLogInQuery.cfm", CGI.Script_Name) >
	<cfset heading01 = "JAB Only">
	<cfset heading02 = "LogIn Query">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("AsstRefsRanking.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Assistant Referees' Rankings">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefsRanking.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Referees' Rankings">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("SportsmanshipTable.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Sportsmanship Table">
	<cfif URL.Order IS "HighAtTop"><cfset heading02 = "#heading02# - High Marks at Top"></cfif>
	<cfif URL.Order IS "LowAtTop"><cfset heading02 = "#heading02# - Low Marks at Top"></cfif>					
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("SuspendPlayer.cfm", CGI.Script_Name) >
	<cfset heading01 = "Player Suspension">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RegisterPlayer.cfm", CGI.Script_Name) >
	<cfset heading01 = "Player Registration">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
	
<cfelseif FindNoCase("LeagueLeadingGoalscorers.cfm", CGI.Script_Name) >
	<cfset heading01 = "#Getlong.CompetitionDescription#">
	<cfset heading02 = "Leading Goalscorers">
	<cfset SearchAdd = "No">
	
<cfelseif FindNoCase("MissingRefereesMarks.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Referees with missing marks">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MissingSportsmanshipMarks.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Missing Sportsmanship marks">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MissingAppearances.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Matches with missing player appearances">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MissingGoalscorers.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Matches with missing/too many goalscorers">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RedCardSuspens.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Red Cards and Suspensions">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("YellowRedCards.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "See Player: Yellow & Red Cards">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("Goalscorer.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "See Player: Goals Scored">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("DiscipAnalysis.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Team Disciplinary Analysis">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PlayersHist.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Player's Appearances">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("CardAnalysis.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "See Club: Card Analysis">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("AverageRefMarks.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Average Marks Awarded to Referee by Team">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("AppearanceAnalysis.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "See Club: Player Appearances & Goals Analysis">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("AppearancesQuery.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Appearances Query">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PenaltyDeciders.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Check Penalty Deciders">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ReferToDiscipline.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Check Refer To Discipline">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PlayerUnusedNos.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Unused Player Registration Numbers">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefsPromotionReport.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Referee's Promotion Report">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("Noticeboard.cfm", CGI.Script_Name) >
	<cfset heading01 = "Noticeboard">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("BatchInput.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Batch Input">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("SecurityCheck.cfm", CGI.Script_Name)>
	<cfset heading01 = "Log In">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ClubList.cfm", CGI.Script_Name)>
	<cfset heading01 = "Club Information">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("GatherTeamsUnderClub.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Gather Teams under one Club">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TransferTeamToMisc.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Transfer Team to Miscellaneous">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("LeagueInfoUpdate.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "League Info Update">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TeamDetailsUpdate.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Team Details Update">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("SecretWordList.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Club Password List">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ContributoryReport.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Contributory League Report - #url.ReportType#">
	<cfset SearchAdd = "No">					
<cfelseif FindNoCase("LeagueTabMonth.cfm", CGI.Script_Name)>
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfif StructKeyExists(url, "FormDate")>
		<cfset heading02 = "#DateFormat(url.FormDate, 'MMMM')# Form Table">
	<cfelse>
		<cfset heading02 = "">
	</cfif>
	<cfset SearchAdd = "No">					
<cfelseif FindNoCase("DateRange.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "#DateFormat(Now(), 'DDDD, DD MMMM YYYY')#">
	<cfset SearchAdd = "No">					
<cfelseif FindNoCase("CheckRule12SineDie.cfm", CGI.Script_Name)>
	<cfset heading01 = "Rule 12 or Sine Die Check<br />Middx County FA List">
	<cfset heading02 = "#DateFormat(Now(), 'DDDD, DD MMMM YYYY')#">
	<cfset SearchAdd = "No">					
<cfelseif FindNoCase("ExportCommitteeDetails.cfm", CGI.Script_Name)>
	<cfset heading01 = "Export Committee Details">
	<cfset heading02 = "#DateFormat(Now(), 'DDDD, DD MMMM YYYY')#">
	<cfset SearchAdd = "No">					
<cfelseif FindNoCase("GatherTeamsUnderClubProcess2.cfm", CGI.Script_Name)>
	<cfset heading01 = "Club Umbrella Process">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("UmbrellaCompare.cfm", CGI.Script_Name)>
	<cfset heading01 = "Umbrella Compare Process for #LeagueCodeYear#">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelse>
	<cfset heading01 = "#TblName#">
	<cfset heading02 = "">
	<cfset SearchAdd = "Yes">
</cfif>
<table width="100%" cellspacing="0" cellpadding="0" border="0">		
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
				<tr>
					<td valign="top">
						<table  border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table align="left" border="0" cellpadding="0" cellspacing="0">
									<tr>
									<cfif BadgeJpeg IS "blank">
									<cfelse>
											<td valign="top" align="left">
												<cfif WebsiteLink IS NOT "">
													<a href="#WebsiteLink#" target="_blank"><IMG border="0" src="LeagueBadges/#BadgeJpeg#.jpg" alt="Go to their Website"></a>
												<cfelse>
													<IMG border="0" src="LeagueBadges/#BadgeJpeg#.jpg">
												</cfif>
											</td>
									</cfif>
									<td>
									<table border="0" align="left" cellpadding="2" cellspacing="2">
									<tr>
										<td valign="top" align="left">
											<span class="pix16brand">#LeagueName#</span>
										</td>
									</tr>
									<!--- LeagueBrand: 0=Normal,1=NationalLeagueSystem,2=WomensFootballPyramid, 4=FootballAssociation,5=RefereesAssociation --->
									<CFSWITCH expression="#LeagueBrand#">
										<CFCASE VALUE="1"> <!--- National League System --->
											<tr>
												<td align="left"><span class="pix10brand">Member of the National League System</span></td>
											</tr>
										</CFCASE>
										<CFCASE VALUE="2"> <!--- Womens Football Pyramid --->
											<tr>
												<td align="left"><span class="pix10brand">Member of the Women's Football Pyramid</span></td>
											</tr>
										</CFCASE>
									</CFSWITCH>
									<tr>
										<td valign="top" height="20" align="left">
											<span class="pix10brand">#SeasonName#</span>
										</td>
									</tr>
							<tr>
								<td valign="top"  align="left"><span class="pix10brand"><b>#DateFormat(Now(), 'DDDD, DD MMMM YYYY')#</b></span></td>
							</tr>
							<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel)>
							<tr>
								<td align="left"><span class="pix10brand">#CounterText#</span></td>
							</tr>
							</cfif>
									</table>
									
									</td>
									
									
									
									</tr>
										
									</table>
								</td>
							</tr>
							<tr>
								<td bgcolor="white">
									<div><img src="trans.gif" height="10" width="1" /></div>
								</td>
							</tr>
							
							
								<tr>
									<td align="left">
										<!--/* OpenX iFrame Tag v2.6.2 */-->
										<iframe id='a20f26cb' name='a20f26cb' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?zoneid=29&amp;cb=INSERT_RANDOM_NUMBER_HERE' framespacing='0' frameborder='no' scrolling='no' width='200' height='25'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=a068dab7&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=29&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a068dab7' border='0' alt='' /></a>
										</iframe>
										<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
									</td>
								</tr>
							<tr>
								<td bgcolor="white">
									<div><img src="trans.gif" height="10" width="1" /></div>
								</td>
							</tr>
							
							<tr>
								<td align="left">
									<div id="under_name_ad" style="width:235px; height:60px; border:0px;">
									<cfif NOT ListFind("Silver,Skyblue,Green",request.SecurityLevel)>
										<cfif DefaultYouthLeague IS 0>
											<!--/* OpenX iFrame Tag v2.6.2 */--><!-- adult in line 234x60-->
											<iframe id='a0984b4d' name='a0984b4d' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?n=a0984b4d&amp;zoneid=14&amp;target=_blank&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' framespacing='0' frameborder='no' scrolling='no' width='234' height='60'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=afaf66b2&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=14&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=afaf66b2&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a>
											</iframe>
											<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
										<cfelse><!--- straight ---> 
											<iframe id='a86e81f3' name='a86e81f3' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?refresh=0&amp;n=a86e81f3&amp;zoneid=7&amp;target=_blank&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' framespacing='0' frameborder='no' scrolling='no' width='234' height='60'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=a348df0c&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=7&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a348df0c&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a>
											</iframe>
											<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
										</cfif>
									</cfif>
									</div>

								</td>
							</tr>
							<tr>
								<td bgcolor="white">
									<div><img src="trans.gif" height="10" width="1" /></div>
								</td>
							</tr>

							<tr>
								<td bgcolor="white">
									<cfinclude template="Announcement.cfm">
								</td>
							</tr>

									
							<tr>
								<td bgcolor="white">
									<div><img src="trans.gif" height="10" width="1" /></div>
								</td>
							</tr>
							
						</table>	
					</td>
					
		</cfoutput>

		<cfset ShowRefereeAvailability = "No">
		<cfif FindNoCase("UpdateForm.cfm", CGI.Script_Name) AND TblName IS "Referee">
			<cfif StructKeyExists(url, "ID")>
				<cfset ShowRefereeAvailability = "Yes">
				<cfset RefereeID = URL.ID >
			</cfif>
		<cfelseif FindNoCase("RefsHist.cfm", CGI.Script_Name) >
			<cfif StructKeyExists(url, "RI")>
				<cfset ShowRefereeAvailability = "Yes">
				<cfset RefereeID = URL.RI >
			</cfif>
		</cfif>
		
		<cfif ListFind("Green",request.SecurityLevel) >
			<cfset ShowRefereeAvailability = "No">
		</cfif>
		
		<td valign="top" align="left" >
			
			<cfoutput>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
			<!---
			<cfif ShowRefereeAvailability IS "No"  and FindNoCase("News.cfm", CGI.Script_Name) >
				<iframe src="EventCalendar.cfm?LeagueCode=#LeagueCode#" name="EventCalendar" marginwidth="5" marginheight="5" scrolling="auto" frameborder="0" id="EventCalendar">
					<!--- info for non-compliant browsers here --->
					If you are seeing this text, your browser is unable to accept iframes.<br />
					We suggest downloading and installing a browser which will accept them <br />
					 if you wish to use the Calendar facility.
				</iframe>
			</cfif>
			--->
			<cfif ShowRefereeAvailability IS "Yes">
				<iframe src="RefAvailable.cfm?LeagueCode=#LeagueCode#&RefereeID=#RefereeID#" name="RefAvailable" marginwidth="5" marginheight="5" scrolling="auto" frameborder="0" id="RefAvailable">
					<!--- info for non-compliant browsers here --->
					If you are seeing this text, your browser is unable to accept iframes.<br />
					We suggest downloading and installing a browser which will accept them <br />
					 if you wish to use the Calendar facility.
				</iframe>
			</cfif>
			
					</td>
				</tr>
				<tr>
					<cfif DefaultYouthLeague OR LeagueBrand IS 2>
						<td align="center" valign="top">
							<a href="http://www.sci-footballfestivals.co.uk" target="_blank">
							<img src="gif/SCI-WebBut09-195x100.gif" alt="Sports Club International" border="0">
							</a>
						</td>
					</cfif>
				</tr>
				<cfif heading01 IS "Club Information"> <!--- AND LeagueCodePrefix IS "MDX"   was XMDX --->
					<tr>
						<td align="center">
							<!--/* OpenX iFrame Tag v2.6.2 */-->
							<iframe id='ae38cac3' name='ae38cac3' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?zoneid=27&amp;cb=INSERT_RANDOM_NUMBER_HERE' framespacing='0' frameborder='no' scrolling='no' width='300' height='80'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=aa029dc5&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=27&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=aa029dc5' border='0' alt='' /></a>
							</iframe>
							<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
						</td>
					</tr>
				<cfelse>
				</cfif>
			</table>
			</cfoutput>
		</td>
		<script type="text/javascript">
		<!--
		function loadIframe(iframeName, url) {
	 		if ( window.frames[iframeName] ) {
	    		window.frames[iframeName].location = url;   
	    	return false;
	  		}
	  	else return true;
		}
		//-->
		</script>
	
		<td valign="top" align="right">
		<cfif NOT ListFind("Silver,Skyblue,Green",request.SecurityLevel)>
			<cfif DefaultYouthLeague IS 0>		
				<!--/* OpenX iFrame Tag v2.6.2 */--><!--MPU adult-->
				<iframe id='a8b2a3a0' name='a8b2a3a0' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?n=a8b2a3a0&amp;zoneid=12&amp;target=_blank&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' framespacing='0' frameborder='no' scrolling='no' width='300' height='250'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=addd767a&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=12&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=addd767a&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a>
				</iframe>
				<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
			<cfelse><!--- straight --->
				<iframe id='af6880bf' name='af6880bf' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?refresh=0&amp;n=af6880bf&amp;zoneid=1&amp;target=_blank&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' framespacing='0' frameborder='no' scrolling='no' width='300' height='250'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=a9ab5791&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=1&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a9ab5791&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a>
				</iframe>
				<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
			</cfif>
		</cfif>
		</td>
	</tr>
	<cfoutput>
		<tr>
			<td width="100%" colspan="3">
				<table class="mainHeading" width="100%" border="0">
					<tr>
						<td><span class="pix16brand">#heading01#<cfif Len(Trim(heading01)) GT 0 AND Len(Trim(heading02)) GT 0>&nbsp;:&nbsp;</cfif></span>
						
						
							<cfif StructKeyExists(request, "PrevMDateNo") >
							 	<cfif request.PrevMDateNo IS NOT 0 AND request.ThisMDateNo IS NOT 0>
									<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.PrevMDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" >
									<img src="click_left_on.png" alt="#DateFormat(request.PrevMDate, 'DDDD, DD MMM YYYY')#" border="0" onmouseover="this.src='click_left_hover.png';" onMouseOut="this.src='click_left_on.png';" ></a>
								<cfelse>
									<img src="click_left_off.png" border="0" >
								</cfif>
							</cfif>
							
							<cfif StructKeyExists(request, "PrevMonthNo") >
								<cfif request.PrevMonthNo IS NOT 0 AND request.ThisMonthNo IS NOT 0 >
									<a href="FixtResMonth.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&MonthNo=#request.PrevMonth#" >
									<img src="click_left_on.png" alt="#MonthAsString(request.PrevMonth)#" border="0" onmouseover="this.src='click_left_hover.png';" onMouseOut="this.src='click_left_on.png';" ></a>
								<cfelse>
									<img src="click_left_off.png" border="0" >
								</cfif>
							</cfif>
							
							
							
							<cfif heading02 IS "Player's Appearances">
								<cfset heading02 = "#heading02# - #QPlayer.Surname# <span class='pix16normal'>#QPlayer.Forename#</span>">
							</cfif>
							<span class="pix16brand">#heading02#</span>
							
							<cfif StructKeyExists(request, "NextMDateNo") >
								<cfif request.NextMDateNo IS NOT 0 AND request.ThisMDateNo IS NOT 0>
									<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.NextMDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" >
									<img src="click_right_on.png" alt="#DateFormat(request.NextMDate, 'DDDD, DD MMM YYYY')#" border="0" onmouseover="this.src='click_right_hover.png';" onMouseOut="this.src='click_right_on.png';" ></a>
								<cfelse>
									<img src="click_right_off.png" border="0" >
								</cfif>
							</cfif>	
							<cfif StructKeyExists(request, "NextMonthNo") >
								<cfif request.NextMonthNo IS NOT 0 AND request.ThisMonthNo IS NOT 0 >
									<a href="FixtResMonth.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&MonthNo=#request.NextMonth#" >
									<img src="click_right_on.png" alt="#MonthAsString(request.NextMonth)#" border="0" onmouseover="this.src='click_right_hover.png';" onMouseOut="this.src='click_right_on.png';" ></a>
								<cfelse>
									<img src="click_right_off.png" border="0" >
								</cfif>
							</cfif> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
				<tr>
					<cfif heading02 IS "Player's Appearances">
						<span class="pix13bold">- <cfoutput>#QPlayer.Surname#</cfoutput></span>
						<span class="pix13"> <cfoutput>#QPlayer.Forename#</cfoutput></span>
					</cfif>
					
					<cfif SearchAdd IS "Yes">
						<table class="mainMenu">
							<tr>
								<td align="left">
									<a href="SearchForm.cfm?TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13boldwhite">Search</span></a>
								</td>
								<td width="150">
									<span class="pix13bold">&nbsp;</span>
								</td>
								<td align="right" >
									<a href="UpdateForm.cfm?TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13boldwhite">Add</span></a>
								</td>
							</tr>
						</table>
					</cfif>
					
					</td>
				</tr>
		
	</cfoutput>
	</table>
		</td>
	</tr>
</table>