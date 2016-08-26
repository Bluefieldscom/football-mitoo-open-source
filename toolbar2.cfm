<cfoutput>
<cfsilent>
<!--- Competition Description for Headings --->
<cfif StructKeyExists(url, "DivisionID")>
	<cfset ThisCompetitionID = url.DivisionID>
<cfelseif StructKeyExists(form, "DivisionID")>
	<cfset ThisCompetitionID = form.DivisionID>
<cfelse>
	<cfset ThisCompetitionID = DefaultDivisionID >
</cfif>

<cfinclude template="queries\qry_QGetLong.cfm">
<cfset ThisCompetitionDescription = "" >
<cfif GetLong.RecordCount IS 1>
	<cfset ThisCompetitionDescription = "#GetLong.CompetitionDescription#" >
</cfif>

<cfset SponsorTokenStart = FindNoCase( "Sponsor[", GetLong.CompetitionNotes)>
<cfset SquareBracketEnd = FindNoCase( "]", GetLong.CompetitionNotes)>
<cfif SponsorTokenStart GT 0 AND SquareBracketEnd GT SponsorTokenStart >
	<cfset SponsorTokenEnd = Find( "]", GetLong.CompetitionNotes, SponsorTokenStart )>
	<cfset SponsorTokenLength = SponsorTokenEnd - SponsorTokenStart - 8>
	<cfset SponsoredByText = " sponsored by #Trim(MID(GetLong.CompetitionNotes, SponsorTokenStart+8, SponsorTokenLength))#" >
<cfelse>
	<cfset SponsoredByText = "">
</cfif>
<cfset ThisCompetitionDescription = "#ThisCompetitionDescription##SponsoredByText#">

<cfif TblName IS "Register">
	<cfinclude template="queries\qry_QGetTeam_v2.cfm">
</cfif>
</cfsilent>

<cfif HideThisSeason IS "0" > <!--- if set to 1 then Season is hidden from public --->
<cfelseif ListFind("Silver,Skyblue",request.SecurityLevel) > <!--- allow them through if logged in as administrator --->
<cfelseif FindNoCase("SecurityCheck.cfm", CGI.Script_Name)> <!--- allow the administrator a chance to log in ! --->
<cfelseif FindNoCase("News.cfm", CGI.Script_Name)> <!--- allow them to see the Home page --->
<cfelseif FindNoCase("Noticeboard.cfm", CGI.Script_Name)> <!--- allow them to see the Noticeboard page --->
<cfelse>	
	<cfoutput>
		<center>
			<span class="pix18boldred">
				<br><br>
				<br><br>#LeagueName#
				<br><br>#SeasonName# is under construction
				<br><br>Access is allowed to <u>LogIn</u> and <u>Home</u> and <u>Noticeboard</u> screens only
				<br><br>
			</span>
		</center>
	</cfoutput>
	<cfabort>
</cfif>
<!--- reminder: Orange security level -  gets cfmpwd and cfmlist which were added just for the North West Counties Football League 
 (John Deal requested it) so a person could update Team Sheets only	without needing to log in as each club separateley ---> 
<cfinclude template="queries\qry_QGoalRunId.cfm">
<cfset ExceptionList = "ClubList.cfm,LeagueTab.cfm,Latest.cfm,MtchDay.cfm,Unsched.cfm,FixtResMonth.cfm,TeamDetailsUpdate.cfm,RegistListText.cfm,RegistListPDF.cfm,KOTime.cfm,TeamList.cfm,ListOfReferees.cfm,RefAnalysis.cfm,RefAppointsXLS.cfm,SeeGoalscorers.cfm,ResultsGrid.cfm,LeagueLeadingGoalscorers.cfm,AttendanceStats.cfm,LeagueTabExpand.cfm,TeamHist.cfm,TeamHistAll.cfm,LeagueTabMonth.cfm,LeagueTabXLS.cfm,LeagueTabExpandXLS.cfm,ResultsGridXLS.cfm,RefAppoints.cfm,RefAppointsInWord.cfm,FixturesTxt.cfm,EmailSetUpForm.cfm,RefereesAvailability.cfm,RefereesAvailability2.cfm,StartingLineUpList.cfm">
<cfif FindNoCase("News.cfm", CGI.Script_Name)> <!--- allow them to see the Home page --->
<cfelseif FindNoCase("Noticeboard.cfm", CGI.Script_Name)> <!--- allow them to see the Noticeboard page --->
<cfelseif ListFind("Silver,Skyblue,Yellow,Orange",request.SecurityLevel) > <!--- allow them through if logged in at any security level --->
<cfelseif FindNoCase("SecurityCheck.cfm", CGI.Script_Name)> <!--- allow the administrator a chance to log in ! --->
<cfelseif ShowOnGoalrunOnly IS "1" AND QGoalRunId.RecordCount IS 1> <!--- this needs to be renamed as ShowOnMitooDotComOnly --->	
	<cfoutput>
		<cflocation url="http://www.mitoo.com/beta?league&lid=#QGoalRunId.MitooDotComID#&did=#QGoalRunId.DefaultDID#" addtoken="no">
	</cfoutput>
	<cfabort>
</cfif>
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
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
		<cfset heading01 = "Match Day - Standard View">
	<cfelse>
		<cfset heading01 = "Match Day">
	</cfif>

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
	
<cfelseif FindNoCase("MtchDayOfficials.cfm", CGI.Script_Name)>
	<cfset heading01 = "Match Day - Officials View">

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

<cfelseif FindNoCase("MtchDayQuick.cfm", CGI.Script_Name)>
	<cfset heading01 = "Match Day - Quick View">

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
<cfelseif TblName IS "Document">
	<cfset heading01 = "Document - JAB Only">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TopTwenty.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Top Goalscorers and Star Players in all Competitions">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("AttendanceStats.cfm", CGI.Script_Name)>
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Attendance Statistics">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PlayersHistory.cfm", CGI.Script_Name) OR FindNoCase("PlayersHistory2.cfm", CGI.Script_Name) OR FindNoCase("PlayersHistory3.cfm", CGI.Script_Name)>
	<cfset heading01 = "ALL COMPETITIONS">
	<cfset heading02 = "Player's Appearances">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TeamList.cfm", CGI.Script_Name)>
	<cfset heading01 = "Team Sheet">
	<cfset heading02 = "Player Appearances, Goals Scored, Yellow & Red Cards">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TeamReportsMenu.cfm", CGI.Script_Name)>
	<cfset heading01 = "Team Reports">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("KOTime.cfm", CGI.Script_Name)>
	<cfset heading01 = "KO Time">
	<cfset heading02 = "">
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
	<cfset heading01 = "#QReferee.RefsName#">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefsHistPublic.cfm", CGI.Script_Name) >
	<cfset heading02 = "Referee's History">
	<cfset heading01 = "#QReferee.RefsName#">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ViewChange.cfm", CGI.Script_Name) >
	<cfset heading01 = "Change the mode in which you view <em>football.mitoo</em> screens">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("EmailChange.cfm", CGI.Script_Name) >
	<cfset heading01 = "Do you use web based or desktop based email?">
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
<cfelseif FindNoCase("EmailEnvelopeForm.cfm", CGI.Script_Name) >
	<cfset heading01 = "Match Details Email">
	<cfset heading02 = "">
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
<cfelseif FindNoCase("LeagueInfoReport.cfm", CGI.Script_Name) >
	<cfset heading01 = "League Profile">
	<cfset heading02 = " - If you want an explanation of any item or want to change a setting please email us">
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
<cfelseif FindNoCase("HospitalityTable.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Hospitality Table">
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
<cfelseif FindNoCase("PlayersBanned.cfm", CGI.Script_Name) >
	<cfset heading01 = "Players with 5 or more Match Bans">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("LeagueLeadingGoalscorers.cfm", CGI.Script_Name) >
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset heading02 = "Leading Goalscorers">
	<cfset SearchAdd = "No">
	
<cfelseif FindNoCase("MissingRefereesMarks.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfif StructKeyExists(url, "External")>
		<cfif url.External IS "N">
			<cfset heading02 = "Referees with missing marks (Ignoring External Competitions)">
		<cfelse>
			<cfset heading02 = "Referees with missing marks">
		</cfif>
	<cfelse>
		<cfset heading02 = "Referees with missing marks">
	</cfif>
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MissingSportsmanshipMarks.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfif StructKeyExists(url, "External")>
		<cfif url.External IS "N">
			<cfset heading02 = "Matches with missing Sportsmanship marks (Ignoring External Competitions)">
		<cfelse>
			<cfset heading02 = "Matches with missing Sportsmanship marks">
		</cfif>
	<cfelse>
		<cfset heading02 = "Matches with missing Sportsmanship marks">
	</cfif>
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MissingHospitalityMarks.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Missing Hospitality marks">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MissingAppearances.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfif StructKeyExists(url, "External")>
		<cfif url.External IS "N">
			<cfset heading02 = "Matches with missing player appearances (Ignoring External Competitions)">
		<cfelse>
			<cfset heading02 = "Matches with missing player appearances">
		</cfif>
	<cfelse>
		<cfset heading02 = "Matches with missing player appearances">
	</cfif>
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MissingAppearances2.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Matches with team sheets where updating ALLOWED">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MissingGoalscorers.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Matches with missing/too many goalscorers">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RedCardSuspens.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Red Cards and Suspensions">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RedCardSuspensND.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Red Cards and Suspensions - Numbers Disagree">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("YellowRedCards.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "See Player: Yellow & Red Cards">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("Goalscorer.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "See Player: Goals Scored">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("CautionThresholds.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "See Player: Caution Thresholds">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TeamDiscipAnalysis.cfm", CGI.Script_Name) >
	<cfset heading01 = "Team Report">
	<cfset heading02 = "Team Disciplinary Analysis">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("DiscipAnalysis.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Team Disciplinary Analysis">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PlayersHist.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Player's Appearances">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MergeDuplicatePlayers.cfm", CGI.Script_Name) >
	<cfset heading01 = "Merge Duplicate Players">
	<cfset heading02 = "">
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
<cfelseif FindNoCase("FutureScheduledDates.cfm", CGI.Script_Name) >
	<cfset heading01 = "Future Scheduled Dates">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("PenaltyDeciders.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Check Penalty Deciders">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ReferToDiscipline.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Check Refer To Discipline">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("AwardedGames.cfm", CGI.Script_Name) >
	<cfset heading01 = "Administration Report">
	<cfset heading02 = "Awarded Games">
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
<cfelseif FindNoCase("RestoreBackFromMisc.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Restore Team back from Miscellaneous">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("LeagueInfoUpdate.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "League Info Update">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("TeamDetailsUpdate.cfm", CGI.Script_Name)>
	<cfset heading01 = "Team Details Update">
	<cfset heading02 = "click on Update button below to save changes">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MoveToMisc.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Move Match Details to Miscellaneous">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("SecretWordList.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Password List">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RCLogReport.cfm", CGI.Script_Name)>
	<cfset heading01 = "Referee Details, Referee Availability, Team Details">
	<cfif StructKeyExists(url,"Full")>
		<cfif url.Full IS "Yes">
				<cfset heading02 = "Full Update History">
		</cfif>
	<cfelse>
		<cfset heading02 = "Recent Update History">
	</cfif>
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("FreeDates.cfm", CGI.Script_Name)>
	<cfset heading01 = "Team - Dates Unavailable">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("ContributoryReport.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "Contributory League Report - #url.ReportType#">
	<cfset SearchAdd = "No">					
<cfelseif FindNoCase("LeagueTabMonth.cfm", CGI.Script_Name)>
	<cfset heading01 = "#ThisCompetitionDescription#">
	<cfset DateMinimum = "#DateFormat(url.FormDate, 'YYYY-MM-')#01">
	<cfset DateMaximum = "#DateFormat(DateAdd('m', (url.MPeriod-1), DateMinimum), 'YYYY-MM-')##DaysInMonth(DateAdd('m', (url.MPeriod-1), DateMinimum))#" >
	<cfset heading02 = "#url.MPeriod# Month Form Table for #DateFormat(DateMinimum, 'DD MMMM')# to #DateFormat(DateMaximum, 'DD MMMM')#">
	<cfset SearchAdd = "No">					
<cfelseif FindNoCase("DateRange.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
	<cfset heading02 = "#DateFormat(Now(), 'DDDD, DD MMMM YYYY')#">
	<cfset SearchAdd = "No">					
<cfelseif FindNoCase("DateRange1.cfm", CGI.Script_Name)>
	<cfset heading01 = "Referees' Marks Microsoft Excel Report">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("DateRangeF.cfm", CGI.Script_Name)>
	<cfset heading01 = "Fixture Information Microsoft Excel Report">
	<cfset heading02 = "">
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
<cfelseif FindNoCase("UploadLeaguePics_JPG.cfm", CGI.Script_Name)>
	<cfset heading01 = "Uploading JPG">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("UploadLeagueDocs_PDF.cfm", CGI.Script_Name)>
	<cfset heading01 = "Uploading PDF">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("UploadLeagueDocs_XLS.cfm", CGI.Script_Name)>
	<cfset heading01 = "Uploading XLS">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("FixtureDetailsXLS.cfm", CGI.Script_Name)>
	<cfset heading01 = "Fixture Details">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RefsHistMatchCard.cfm", CGI.Script_Name)>
	<cfset heading01 = "Referee's History and Match Cards">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("UploadLeagueDocs_DOC.cfm", CGI.Script_Name)>
	<cfset heading01 = "Uploading DOC">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("RegistListPDF.cfm", CGI.Script_Name)>
	<cfset heading01 = "Player Re-Registration Form (.PDF)">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("CheckPlayerDuplicateNoWarnings1.cfm", CGI.Script_Name)>
	<cfset heading01 = "Suppressed Warnings of Duplicate Forename(s), Surname and Date of Birth">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("CheckPlayerDuplicateNoWarnings2.cfm", CGI.Script_Name)>
	<cfset heading01 = "Suppressed Warnings of Duplicate Forename(s) and Date of Birth">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("CheckPlayerDuplicateNoWarnings3.cfm", CGI.Script_Name)>
	<cfset heading01 = "Suppressed Warnings of Duplicate Surname and Date of Birth">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("AppearanceRecord.cfm", CGI.Script_Name)>
	<cfset heading01 = "Appearance Record">
	<cfset heading02 = "#request.DropDownTeamName#">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("MatchCard.cfm", CGI.Script_Name) AND GetToken( CGI.Script_Name, 2, "/") IS "MatchCard.cfm">
	<cfset heading01 = "Referee's Match Card">
	<cfset heading02 = "">
	<cfset SearchAdd = "No">
<cfelseif FindNoCase("Testing01.cfm", CGI.Script_Name)>
	<cfset heading01 = "">
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

										<!-- Add follow button on league page -->
			
<!-- 										<tr>
											<td valign="top"  align="left">
												<br>
												<a class="mitoo-follow-button" href="http://www.mitoo.co/?q=#LeagueName#">Follow</a>
											</td>
										</tr> -->
			

										
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
				<cfif ListFind("Silver,Skyblue",request.SecurityLevel) > 
				<cfelse>
					<tr>
	<!---
				*****************************
				* See this League on MITOO  *
				*****************************
						
							<cfif QGoalRunId.RecordCount IS 1>
								<a href="http://www.mitoo.com/beta?league&amp;lid=#QGoalRunId.MitooDotComID#&amp;did=#QGoalRunId.DefaultDID#" target="_blank"><img src="images/mitoo_league_off.png" border="0" onMouseOver="this.src='images/mitoo_league_on.png'" onMouseOut="this.src='images/mitoo_league_off.png'" ></a>
							</cfif>
				************************
				* Go to your TEAM page *
				************************
	
							<cfif QGoalRunId.RecordCount IS 1>
								<a href="http://www.mitoo.com" target="_blank"><img src="images/gototeam_off.png" border="0" onMouseOver="this.src='images/gototeam_on.png'" onMouseOut="this.src='images/gototeam_off.png'" ></a>
							</cfif>
				************ 
				* Magazine *
				************ 
					<a href="http://mitoomag.com" target="_blank"><img src="images/magazine_off.png" border="0" onmouseover="this.src='images/magazine_on.png';" onMouseOut="this.src='images/magazine_off.png';"></a>
					
					
					
					
				************ 
				* RESPOND  *
				************ 
						<td align="left">
							<cfif DefaultYouthLeague IS 0>
								<respond_button title="youth football"></respond_button>
							<cfelse>
								<respond_button title="football"></respond_button>
							</cfif>
						</td>
	 --->
						
					</tr>
				</cfif>
				<tr>
					<td bgcolor="white">
						<div><img src="trans.gif" height="10" width="1" /></div>
					</td>
				</tr>
<!---
			*************************************
			* Left Hand Side  -  TWO 234 x 60   *
			*************************************
 --->
				<tr>
					<td align="left">
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td bgcolor="white"> <!--- slot 1  --->
									<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
										<div id="azk54565"></div>
									<!-------
										<cfif DefaultYouthLeague IS 0>
											<iframe id='aa056254' name='aa056254' src='http://d1.openx.org/afr.php?zoneid=124268&amp;cb=INSERT_RANDOM_NUMBER_HERE' frameborder='0' scrolling='no' width='234' height='60'><a href='http://d1.openx.org/ck.php?n=acff4ac4&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://d1.openx.org/avw.php?zoneid=124268&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=acff4ac4' border='0' alt='' /></a></iframe>
										<cfelse>
											<iframe id='af684560' name='af684560' src='http://d1.openx.org/afr.php?zoneid=125464&amp;cb=INSERT_RANDOM_NUMBER_HERE' frameborder='0' scrolling='no' width='234' height='60'><a href='http://d1.openx.org/ck.php?n=a8b161da&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://d1.openx.org/avw.php?zoneid=125464&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a8b161da' border='0' alt='' /></a></iframe>
										</cfif>
									------->
									</cfif>
								</td>
								<td bgcolor="white"> <!--- slot 2  --->
									<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
										<div id="azk55194"></div>
									<!-------
										<cfif DefaultYouthLeague IS 0>
											<iframe id='a782372e' name='a782372e' src='http://d1.openx.org/afr.php?zoneid=124270&amp;cb=INSERT_RANDOM_NUMBER_HERE' frameborder='0' scrolling='no' width='234' height='60'><a href='http://d1.openx.org/ck.php?n=aee8b14a&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://d1.openx.org/avw.php?zoneid=124270&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=aee8b14a' border='0' alt='' /></a></iframe>
										<cfelse>
											<iframe id='acc3eb41' name='acc3eb41' src='http://d1.openx.org/afr.php?zoneid=125465&amp;cb=INSERT_RANDOM_NUMBER_HERE' frameborder='0' scrolling='no' width='234' height='60'><a href='http://d1.openx.org/ck.php?n=a8726fff&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://d1.openx.org/avw.php?zoneid=125465&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a8726fff' border='0' alt='' /></a></iframe>
										</cfif>
									------->
									</cfif>
								</td>
								<td bgcolor="white"> <!--- slot 3  --->
									<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
										<cfif DefaultYouthLeague IS 1>
										<cfelseif LeagueBrand IS 2>	
										<cfelse> <!--- Adult --->
										</cfif>
									</cfif>
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
		<cfset ShowPitchAvailability = "No">
		<cfif FindNoCase("TeamDetailsUpdate.cfm", CGI.Script_Name) OR FindNoCase("PitchAvailableList.cfm", CGI.Script_Name) OR FindNoCase("UpdateForm.cfm", CGI.Script_Name) >
			<cfset ShowPitchAvailability = "Yes">
			<cfif StructKeyExists(url, "PA") >
				<cfif url.PA IS NOT "Team">
					<cfset ShowPitchAvailability = "No">
				</cfif>
			</cfif>
			<cfif StructKeyExists(form, "PA") >
				<cfif form.PA IS NOT "Team">
					<cfset ShowPitchAvailability = "No">
				</cfif>
			</cfif>
			
			<cfif StructKeyExists(url, "TblName") >
				<cfif url.TblName IS NOT "PitchAvailable">
					<cfset ShowPitchAvailability = "No">
				</cfif>
			</cfif>
 			<cfif StructKeyExists(url, "TID") >
				<cfset TID = URL.TID >
			</cfif>
			<cfif StructKeyExists(url, "TeamID") >
				<cfset TID = URL.TeamID >
			</cfif>
			<cfif StructKeyExists(url, "OID") >
				<cfset OID = URL.OID >
			</cfif>
			<cfif StructKeyExists(url, "OrdinalID") >
				<cfset OID = URL.OrdinalID >
			</cfif>
			<cfif StructKeyExists(url, "month_to_view") >
				<cfset month_to_view = URL.month_to_view >
			</cfif>
			<cfif StructKeyExists(url, "year_to_view") >
				<cfset year_to_view = URL.year_to_view >
			</cfif>
		</cfif>
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
		
		<td valign="top" align="left" >
			
			<cfoutput>
			<table border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td>
					<!--- only ever one iframe will be displayed, ShowPitchAvailability and ShowRefereeAvailability are mutually exclusive --->
						<cfif ShowRefereeAvailability IS "Yes">
							<iframe src="RefAvailable.cfm?LeagueCode=#LeagueCode#&RefereeID=#RefereeID#" name="RefAvailable" marginwidth="2" marginheight="2" scrolling="auto" frameborder="0" id="RefAvailable" height="150">
								<!--- info for non-compliant browsers here --->
								If you are seeing this text, your browser is unable to accept iframes.<br />
								We suggest downloading and installing a browser which will accept them <br />
								 if you wish to use the Calendar facility.
							</iframe>
						</cfif>
						
						<cfif ShowPitchAvailability IS "Yes">
							<cfif StructKeyExists(url,"year_to_view") AND StructKeyExists(url,"month_to_view")>
								<cfset year_to_view = url.year_to_view >
								<cfset month_to_view = url.month_to_view >
							<cfelse>
								<cfset year_to_view = "" >
								<cfset month_to_view = "" >
							</cfif>
							<cfif VenueAndPitchAvailable IS "Yes">
								<cfif FindNoCase("TeamDetailsUpdate.cfm", CGI.Script_Name)>
									<iframe src="PtchAvailable.cfm?LeagueCode=#LeagueCode#&TID=#TID#&OID=#OID#&year_to_view=#year_to_view#&month_to_view=#month_to_view#" name="PtchAvailable" marginwidth="2" marginheight="2" scrolling="auto" frameborder="0" id="PtchAvailable" height="200">
										<!--- info for non-compliant browsers here --->
										If you are seeing this text, your browser is unable to accept iframes.<br />
										We suggest downloading and installing a browser which will accept them <br />
										 if you wish to use the Calendar facility.
									</iframe>
								</cfif>
								<cfif FindNoCase("PitchAvailableList.cfm", CGI.Script_Name)>  
									<iframe src="PtchAvailable.cfm?LeagueCode=#LeagueCode#&TID=#ThisTeamID#&OID=#ThisOrdinalID#&year_to_view=#year_to_view#&month_to_view=#month_to_view#" name="PtchAvailable" marginwidth="2" marginheight="2" scrolling="auto" frameborder="0" id="PtchAvailable" height="200">
										<!--- info for non-compliant browsers here --->
										If you are seeing this text, your browser is unable to accept iframes.<br />
										We suggest downloading and installing a browser which will accept them <br />
										 if you wish to use the Calendar facility.
									</iframe>
								</cfif> 
								<cfif FindNoCase("UpdateForm.cfm", CGI.Script_Name)>
									<iframe src="PtchAvailable.cfm?LeagueCode=#LeagueCode#&TID=#TID#&OID=#OID#&year_to_view=#year_to_view#&month_to_view=#month_to_view#" name="PtchAvailable" marginwidth="2" marginheight="2" scrolling="auto" frameborder="0" id="PtchAvailable" height="200">
										<!--- info for non-compliant browsers here --->
										If you are seeing this text, your browser is unable to accept iframes.<br />
										We suggest downloading and installing a browser which will accept them <br />
										 if you wish to use the Calendar facility.
									</iframe>
								</cfif>
							</cfif>
						</cfif>
						
					</td>
				</tr>
<!---
			********************************
			* centre  -  SCI Advert        *
			********************************
				<tr>
					<cfif DefaultYouthLeague OR LeagueBrand IS 2>
						<td align="center" valign="top">
							<a href="http://www.sci-footballfestivals.co.uk" target="_blank">
							<img src="gif/SCI-WebBut09-195x100.gif" alt="Sports Club International" border="0">
							</a>
						</td>
					</cfif>
				</tr>
 --->
				
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
<!---
			***********************************
			* Right Hand Side MPU  300 x 250  *
			***********************************
 --->
		<!--- NIKE August 23rd start 
		<td valign="top" align="right">
			<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel)>
				<cfinclude template="adverts/inclNIKE_23AUG_EXP_MPU.cfm">						
			</cfif>
		</td>
		---> 
		<td align="right" valign="top" bgcolor="white">
			<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
 					<cfif DefaultYouthLeague IS 0> <!--- adult --->
							<cfif TimeFormat(Now(),'s') GE 20> 
								<cfinclude template="adverts/inclVIDEOperformgroup300x360.cfm">
							<cfelse>
								<cfinclude template="adverts/inclAdult300x250.cfm">
							</cfif>
					<cfelse>                   <!--- youth --->
							<cfif TimeFormat(Now(),'s') GE 20> 
								<cfinclude template="adverts/inclVIDEOperformgroup300x360.cfm">
							<cfelse>
								<cfinclude template="adverts/inclYouth300x250.cfm">
							</cfif>
					</cfif>
			</cfif>
		</td>
		
		
	</tr>
	<cfoutput>
		<tr>
			<td width="100%" colspan="3">
				<table class="mainHeading" width="100%" border="0">
					<tr>
						<td align="left"><span class="pix16brand">#heading01#<cfif Len(Trim(heading01)) GT 0 AND Len(Trim(heading02)) GT 0>&nbsp;:&nbsp;</cfif></span>
						
						
							<cfif StructKeyExists(request, "PrevMDateNo") >
							 	<cfif request.PrevMDateNo IS NOT 0 AND request.ThisMDateNo IS NOT 0>
									<cfif Heading01 IS "Match Day - Standard View" OR Heading01 IS "Match Day">
										<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.PrevMDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" >
									<cfelseif Heading01 IS "Match Day - Officials View">
										</a><a href="MtchDayOfficials.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.PrevMDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" >
									<cfelseif Heading01 IS "Match Day - Quick View">
										</a><a href="MtchDayQuick.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.PrevMDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" >
									<cfelse>
										ERROR 28849 
										<cfabort>
									</a></cfif>
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
									<cfif Heading01 IS "Match Day - Standard View" OR Heading01 IS "Match Day">
										<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.NextMDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" >
									<cfelseif Heading01 IS "Match Day - Officials View">
										</a><a href="MtchDayOfficials.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.NextMDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" >
									<cfelseif Heading01 IS "Match Day - Quick View">
										</a><a href="MtchDayQuick.cfm?TblName=Matches&MDate=#URLEncodedFormat(request.NextMDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" >
									<cfelse>
										ERROR 2349 
										<cfabort>
									</a></cfif>
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
