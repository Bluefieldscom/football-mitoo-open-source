<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfinclude template="InclBegin.cfm">

<SCRIPT type="text/javascript" src="CalendarPopup.js"></SCRIPT>	
<cfset AtLeastOneMatchHasBeenTicked ="No">
<!--- <cfdump var="#form#"> --->

	<cfif StructKeyExists(form, "Button") >
		<cfinclude template="InclLeagueInfo.cfm">
		<cfif form.Button IS "Delete Ticked"><!--- Delete Ticked --->
			<cfinclude template="queries/qry_QFixtures_v2.cfm">
			<cfset TotalFixtCount = QFixtures.RecordCount >
			<cfset FIDList = ValueList(QFixtures.FID)>
			<cfset DIDList = ValueList(QFixtures.DID)>
			<cfoutput>
				<cfloop index="i" from="1" to="#TotalFixtCount#">
					<cfset ThisFID = ListGetAt(FIDList,i)>
					<cfif StructKeyExists(form, "Fxt#ThisFID#") >
						<cfset AtLeastOneMatchHasBeenTicked ="Yes">
						<cfset ThisFixtureID = "form.Fxt#ThisFID#">
						<cfset ThisFixtureID = Evaluate(ThisFixtureID) >
						<cfinclude template="queries/del_Fixture.cfm">
						<cfset ThisDivisionID = ListGetAt(DIDList,i)>
						<cfinclude template="RefreshLeagueTable.cfm">
					</cfif>
				</cfloop>
			</cfoutput>
		<cfelseif form.Button IS "Hide Ticked"><!--- Hide Ticked ---> 
			<cfinclude template="queries/qry_QFixtures_v2.cfm">
			<cfset TotalFixtCount = QFixtures.RecordCount >
			<cfset FIDList = ValueList(QFixtures.FID)>
			<cfset DIDList = ValueList(QFixtures.DID)>
			<cfoutput>
				<cfloop index="i" from="1" to="#TotalFixtCount#">
					<cfset ThisFID = ListGetAt(FIDList,i)>
					<cfif StructKeyExists(form, "Fxt#ThisFID#") >
						<cfset AtLeastOneMatchHasBeenTicked ="Yes">
						<cfset ThisFixtureID = "form.Fxt#ThisFID#">
						<cfset ThisFixtureID = Evaluate(ThisFixtureID) >
						<cfinclude template="queries/upd_HideFixture.cfm">
						<cfset ThisDivisionID = ListGetAt(DIDList,i)>
						<cfinclude template="RefreshLeagueTable.cfm">
					</cfif>
				</cfloop>
			</cfoutput>
		<cfelseif form.Button IS "Publish Ticked"><!--- Publish Ticked ---> 
			<cfinclude template="queries/qry_QFixtures_v2.cfm">
			<cfset TotalFixtCount = QFixtures.RecordCount >
			<cfset FIDList = ValueList(QFixtures.FID)>
			<cfset DIDList = ValueList(QFixtures.DID)>
			<cfoutput>
				<cfloop index="i" from="1" to="#TotalFixtCount#">
					<cfset ThisFID = ListGetAt(FIDList,i)>
					<cfif StructKeyExists(form, "Fxt#ThisFID#") >
						<cfset AtLeastOneMatchHasBeenTicked ="Yes">
						<cfset ThisFixtureID = "form.Fxt#ThisFID#">
						<cfset ThisFixtureID = Evaluate(ThisFixtureID) >
						<cfinclude template="queries/upd_ShowFixture.cfm">
						<cfset ThisDivisionID = ListGetAt(DIDList,i)>
						<cfinclude template="RefreshLeagueTable.cfm">
					</cfif>
				</cfloop>
			</cfoutput>
		<cfelseif form.Button IS "NV Ticked"><!--- Normal Venue Ticked ---> 
			<cfinclude template="queries/qry_QFixtures_v2.cfm">
			<cfset TotalFixtCount = QFixtures.RecordCount >
			<cfset FIDList = ValueList(QFixtures.FID)>
			<cfset DIDList = ValueList(QFixtures.DID)>
			<cfset PA_IDList = ValueList(QFixtures.PA_ID)>			
			<cfoutput>
				<cfloop index="i" from="1" to="#TotalFixtCount#">
					<cfset ThisFID = ListGetAt(FIDList,i)>
					<cfset ThisPA_ID = ListGetAt(PA_IDList,i)>
					<cfif StructKeyExists(form, "Fxt#ThisFID#") >
						<cfset AtLeastOneMatchHasBeenTicked ="Yes">
						<cfset ThisFixtureID = "form.Fxt#ThisFID#">
						<cfset ThisFixtureID = Evaluate(ThisFixtureID) >
						<cfif ThisPA_ID IS 0 ><!--- ignore ticked matches that have a venue specified --->
							<cfinclude template="queries/qry_DefaultVenue1.cfm"><!--- find the normal venue --->
								<cfif QDefaultVenue1.RecordCount IS 1>
									<cfinclude template="queries/ins_PitchAvailable3.cfm"><!---- insert a pitchavailable row for this fixture --->
								</cfif>
						</cfif>
						<cfset ThisDivisionID = ListGetAt(DIDList,i)>
						<cfinclude template="RefreshLeagueTable.cfm">
					</cfif>
				</cfloop>
			</cfoutput>
		<cfelseif form.Button IS "Reschedule Ticked"><!--- Reschedule Ticked --->
			<cfinclude template="queries/qry_QFixtures_v2.cfm">
			<cfset TotalFixtCount = QFixtures.RecordCount >
			<cfset FIDList = ValueList(QFixtures.FID)>
			<cfset DIDList = ValueList(QFixtures.DID)>
			<cfloop index="i" from="1" to="#TotalFixtCount#">
				<cfset ThisFID = ListGetAt(FIDList,i)>
				<cfif StructKeyExists(form, "Fxt#ThisFID#") >
					<cfset AtLeastOneMatchHasBeenTicked ="Yes">
				</cfif>
			</cfloop>
			<cfif AtLeastOneMatchHasBeenTicked IS "Yes">
				<cfoutput>
					<cfloop index="i" from="1" to="#TotalFixtCount#">
						<cfset ThisFID = ListGetAt(FIDList,i)>
						<cfif StructKeyExists(form, "Fxt#ThisFID#") >
							<cfset ThisFixtureID = "form.Fxt#ThisFID#">
							<cfset ThisFixtureID = Evaluate(ThisFixtureID) >
							<cfset MatchDate = #GetToken(form.datebox,2,",")# >
	
							<cfinclude template="queries/upd_RescheduleFixture.cfm">
							<cfset ThisDivisionID = ListGetAt(DIDList,i)>
							<cfinclude template="RefreshLeagueTable.cfm">
						</cfif>
					</cfloop>
				</cfoutput>
				<cfset MDate = DateFormat(MatchDate, 'DD-MMM-YY') >
				<cflocation url="MtchDayQuick.cfm?TblName=Matches&MDate=#MDate#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">				
			<cfelse>
			</cfif>
		</cfif>
		<cfif RIGHT(request.dsn,4) GE 2012>		
		<!--- applies to season 2012 onwards only 
		alter table `fm2012`.`fixture` add column `HideMatchOfficials` tinyint(1) UNSIGNED DEFAULT '0' NOT NULL after `RefereeReportReceived`;
		--->
			<cfif form.Button IS "Hide M.O. Ticked"><!--- Hide Match Officials for ticked ---> 
				<cfinclude template="queries/qry_QFixtures_v2.cfm">
				<cfset TotalFixtCount = QFixtures.RecordCount >
				<cfset FIDList = ValueList(QFixtures.FID)>
				<cfset DIDList = ValueList(QFixtures.DID)>
				<cfoutput>
					<cfloop index="i" from="1" to="#TotalFixtCount#">
						<cfset ThisFID = ListGetAt(FIDList,i)>
						<cfif StructKeyExists(form, "Fxt#ThisFID#") >
							<cfset AtLeastOneMatchHasBeenTicked ="Yes">
							<cfset ThisFixtureID = "form.Fxt#ThisFID#">
							<cfset ThisFixtureID = Evaluate(ThisFixtureID) >
							<cfinclude template="queries/upd_HideMatchOfficials.cfm">
							<cfset ThisDivisionID = ListGetAt(DIDList,i)>
						</cfif>
					</cfloop>
				</cfoutput>
			<cfelseif form.Button IS "Publish M.O. Ticked"><!--- Publish Match Officials for ticked ---> 
				<cfinclude template="queries/qry_QFixtures_v2.cfm">
				<cfset TotalFixtCount = QFixtures.RecordCount >
				<cfset FIDList = ValueList(QFixtures.FID)>
				<cfset DIDList = ValueList(QFixtures.DID)>
				<cfoutput>
					<cfloop index="i" from="1" to="#TotalFixtCount#">
						<cfset ThisFID = ListGetAt(FIDList,i)>
						<cfif StructKeyExists(form, "Fxt#ThisFID#") >
							<cfset AtLeastOneMatchHasBeenTicked ="Yes">
							<cfset ThisFixtureID = "form.Fxt#ThisFID#">
							<cfset ThisFixtureID = Evaluate(ThisFixtureID) >
							<cfinclude template="queries/upd_ShowMatchOfficials.cfm">
							<cfset ThisDivisionID = ListGetAt(DIDList,i)>
						</cfif>
					</cfloop>
				</cfoutput>
			</cfif>
		</cfif>
	</cfif>

<cfform ACTION="MtchDayQuick.cfm?TblName=Matches&MDate=#MDate#&LeagueCode=#LeagueCode#"  METHOD="post" NAME="MtchDayAction"  >

<cfset variables.robotindex="no">
<cfset finishPage = 1>
<cfif StructKeyExists(url, "fmTeamID")>
		<cfset request.fmTeamID = url.fmTeamID>
</cfif>
	<cfset ThisColSpan = 6 >
	<cfset ThisDate = DateFormat(MDate, 'YYYY-MM-DD')>
	<!--- check for double headers, create a list of fixture ids that are double headers --->
	<cfinclude template="queries/qry_DoubleHeader.cfm">
	<cfset DHList = ValueList(QDoubleHeader.ID)>
	<cfinclude template="queries/qry_QFixtures_v2.cfm">
	<cfset TotalFixtCount = QFixtures.RecordCount >
	<cfinclude template="queries/qry_QTempFixturesCount.cfm">
	<cfif QTempFixtures.Counter IS "">
		<cfset TempFixtCount = 0 >
	<cfelse>
		<cfset TempFixtCount = QTempFixtures.Counter >
	</cfif>
	<cfinclude template="queries/qry_QEventText.cfm">

<cfif QEventText.RecordCount GT 0 >
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" >
		<cfoutput query="QEventText">
			<tr><td class="mainMenu"><span class="pix13boldwhite">#EventText#</span></td></tr>
		</cfoutput>
	</table>
</cfif>

<cfif StructKeyExists(form, "Button") >
	<cfif form.Button IS "Delete Ticked" 
	OR form.Button IS "Hide Ticked"
	OR form.Button IS "Publish Ticked"
	OR form.Button IS "NV Ticked"
	OR form.Button IS "Reschedule Ticked" 
	OR form.Button IS "Hide M.O. Ticked"
	OR form.Button IS "Publish M.O. Ticked" >
		<cfif AtLeastOneMatchHasBeenTicked IS "No">
			<table>
				<tr>
					<td colspan="6"><table border="0" align="left" cellpadding="5" cellspacing="0"><td width="200" align="center" bgcolor="red"><span class="pix13boldwhite">no matches were ticked</span></td></table></td>
				</tr>
			</table>
		</cfif>
	</cfif>
</cfif>



<cfset DisplayRecCount = TotalFixtCount - TempFixtCount > <!--- subtract Temporary fixture count from Total fixture count --->
<cfif TotalFixtCount IS 0 >
	<cfoutput><span class="pix13bold">No matches today</span></cfoutput> 
<cfelse>
	<!---
	<cfset TIDList = "">
	<cfset OIDList = "">
	--->
	<!--- see if any team is playing more than one game today to provide a warning --->
	<cfinclude template="queries/qry_QPlayingMoreThanOnceToday.cfm">  
	<!---
	<cfset TIDList = ValueList(PlayingMoreThanOnceToday.TID)>
	<cfset OIDList = ValueList(PlayingMoreThanOnceToday.OID)>
	--->
	<cfset NoOfTimesList = ValueList(PlayingMoreThanOnceToday.NoOfTimes)>
	<cfset TeamNameList = ValueList(PlayingMoreThanOnceToday.TeamName)>
	<cfif PlayingMoreThanOnceToday.RecordCount GT 0>
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
			<span class="pix13boldred">WARNING: Teams highlighted in red are playing more than once today.</span>
		</cfif>
	</cfif>
	<cfif DefaultGoalScorers IS "Yes" >
		<cfinclude template="InclGoalscorerInfo.cfm">
		<cfinclude template="InclStarPlayerInfo.cfm">
 	</cfif>

		<cfoutput>
			<table width="25%" border="0" cellspacing="0" cellpadding="0" >
				<tr> 
					<td>
						<table class="buttonBrand">
							<tr>
								<td>
									<!--- display icon yellow/red card - Cautions & Sendings Off for today (only for administrators who are logged in)--->
									<cfset TooltipText="see cautions and sendings-off for<br>#DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#">
									<a href="javascript:void window.open('RefereeCardsToday.cfm?ThisDate=#ThisDate#&LeagueCode=#LeagueCode#','RefereeCardsToday','height=900,width=600,left=10,top=10,resizable=yes,scrollbars=yes').focus()" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Cards Issued</a>
								</td>
							</tr>
						</table>
					</td>
					<td>
						<!--- display button - suspended players for today --->
						<table class="buttonBrand">
								<tr>
									<td>
										<cfset TooltipText="see players suspended for<br>#DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#">
										<a href="javascript:void window.open('CurrentSuspensions.cfm?ThisDate=#ThisDate#&LeagueCode=#LeagueCode#','CurrentSuspensions','height=900,width=700,left=10,top=10,resizable=yes,scrollbars=yes').focus()" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Players Suspended</a>
									</td>
								</tr>
						</table>
					</td>
					<td>
						<!--- display button - referee availability --->
						<table class="buttonBrand">
								<tr>
									<td>
										<cfset TooltipText="Referee Availability for<br>#DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#">
										<a href="RefAvailabilityXLS.cfm?MDate=#MDate#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Referee Availability Microsoft Excel Report</a>
									</td>
								</tr>
						</table>
					</td>
				</tr>
					<tr>
						<cfinclude template="InclMtchDayView.cfm">
					</tr>
			</table>
		</cfoutput>
	<cfoutput>
		<table width="100%" border="0" cellspacing="2" cellpadding="0" bgcolor="white" >
			<tr> 
				<td colspan="#ThisColSpan-1#" align="left"> 
						<cfif TempFixtCount GT 0>
							<span class="pix13bold">#DisplayRecCount# published [#TempFixtCount# <img src="gif/TEMPflag.gif" width="41" height="13"  border="0" align="absmiddle"> hidden] = #TotalFixtCount# matches</span>
						<cfelse>
							<cfif DisplayRecCount IS 1>
								<span class="pix13bold">There is only one match</span>
							<cfelse>
								<span class="pix13bold">There are #QFixtures.RecordCount# matches<cfif KickOffTimeOrder> displayed in KO Time order within Division</cfif></span>
							</cfif>
						</cfif>
					<!--- Postponed Matches - link to delete them --->
							<cfinclude template="queries/qry_QPostponedFixtures.cfm">
							<span class="bg_yellow">
							<cfif QPostponedFixtures.RecordCount IS 1>
								<span class="pix13bold"> including one postponed match. Please click <a href="DeletePostponedFixtures.cfm?LeagueCode=#LeagueCode#&MDate=#DateFormat(MDate,'YYYY-MM-DD')#">here</a> to delete it.</span></td>
							<cfelseif QPostponedFixtures.RecordCount GT 1>
								<span class="pix13bold"> including #QPostponedFixtures.RecordCount# postponed matches. Please click <a href="DeletePostponedFixtures.cfm?LeagueCode=#LeagueCode#&MDate=#DateFormat(MDate,'YYYY-MM-DD')#">here</a> to delete them.</span></td>
							<cfelse>
							</cfif>
							</span>
					<br>
				</td>
			</tr>
	</cfoutput>
	
			<!--- Hide the fixtures from the public if the Event Text says so --->
			<cfinclude template="queries/qry_QEventText.cfm">
			<cfif QEventText.RecordCount IS 1>
				<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
					<cfoutput>
							<tr>
								<cfif DisplayRecCount IS 1>
									<td height="30" colspan="#ThisColSpan#" align="center" bgcolor="##6A7289"><span class="pix13boldwhite">Today's fixture has been hidden from the public</span></td>
								<cfelseif DisplayRecCount GT 1>
									<td height="30" colspan="#ThisColSpan#" align="center" bgcolor="##6A7289"> <span class="pix13boldwhite">Today's fixtures have been hidden from the public</span></td>
								</cfif>
							</tr>
					</cfoutput>
				</cfif>

				<cfif FindNoCase("Provisional_Fixtures",QEventText.EventText) AND NOT FindNoCase("Hide_Fixtures",QEventText.EventText)>
					<cfoutput>
						<tr>
							<cfif DisplayRecCount IS 1>
								<td height="30" colspan="#ThisColSpan#" align="center" bgcolor="##6A7289"><span class="pix13boldwhite">Today's fixture is provisional</span></td>
							<cfelseif DisplayRecCount GT 1>
								<td height="30" colspan="#ThisColSpan#" align="center" bgcolor="##6A7289"> <span class="pix13boldwhite">Today's fixtures are provisional</span></td>
							</cfif>
						</tr>
					</cfoutput>
				</cfif>
			</cfif>
	
	<cfif finishPage>
	
	<cfinclude template="queries/qry_QRefCount.cfm"> 
	<tr> 
		<td height="30" colspan="4" align="left">
			<cfif QRefCount1.RecordCount GT 0 >
				<span class="pix24boldred">WARNING:<br><cfoutput query="QRefCount1"></span><span class="pix13bold">#RefsName#</span><span class="pix13boldred"> has #refcount# appointments<br></cfoutput></span><span class="pix10"><br>Put <b>NoDuplicateWarning</b> in Referee Restrictions to suppress these warnings about more than one appointment on the day.</span>
			</cfif>
		</td>
	</tr>
	
	<cfset CheckboxCount = 0 >
	<cfset PitchNotAvailableCount = 0 >
    <cfoutput query="QFixtures" group="DivName1"> 

			

		<!---
		<input type="hidden" name="D#DID#" value="#DID#">
		
		
		<cfif StructKeyExists(form, "Button#DID#") >
			<tr>
				<td height="6" colspan="#ThisColSpan#" bgcolor="white"></td>
			</tr>
			<tr>
				<td height="4" colspan="#ThisColSpan#" bgcolor="black"></td>
			</tr>
			
		<cfelse>
		--->
			<tr>
				<td height="10" colspan="#ThisColSpan#" bgcolor="white"></td>
			</tr>
		<!---
		</cfif>
		--->
		<cfset SponsorTokenStart = FindNoCase( "Sponsor[", QFixtures.DivNotes)>
		<cfset SquareBracketEnd = FindNoCase( "]", QFixtures.DivNotes)>
		<cfif SponsorTokenStart GT 0 AND SquareBracketEnd GT SponsorTokenStart >
			<cfset SponsorTokenEnd = Find( "]", QFixtures.DivNotes, SponsorTokenStart )>
			<cfset SponsorTokenLength = SponsorTokenEnd - SponsorTokenStart - 8>
			<cfset SponsoredByText = " sponsored by #Trim(MID(QFixtures.DivNotes, SponsorTokenStart+8, SponsorTokenLength))#" >
		<cfelse>
			<cfset SponsoredByText = "">
		</cfif>
		<cfset ThisDivName = "#DivName1##SponsoredByText#">
		<tr> 
			<cfif ExternalComp IS 'Yes'>
				<td height="30" colspan="#ThisColSpan#" align="left" valign="middle" class="mainMenu"><span class="pix16boldwhite">#ThisDivName#</span></td>
			<cfelse>
				<td height="30" colspan="#ThisColSpan#" align="left" valign="middle" class="mainHeading"><span class="pix16brand">#ThisDivName#</span></td>
			</cfif>
		</tr>
      <cfoutput> 
        <cfset Highlight = "No">
        <cfif request.fmTeamID IS HomeTeamID>
          <cfset Highlight = "Yes">
        </cfif>
        <cfif request.fmTeamID IS AwayTeamID>
          <cfset Highlight = "Yes">
        </cfif>
        <cfset HighlightPlayingMoreThanOnceToday = "No">
		<cfset HomeTeamPlayingMoreThanOnceToday = "No">
		<cfset AwayTeamPlayingMoreThanOnceToday = "No">
		<cfif HomeOrdinal IS "">
			<cfset ThisTeamName = "#HomeTeam#" >
		<cfelse>
			<cfset ThisTeamName = "#HomeTeam# #HomeOrdinal#" >
		</cfif>
        <cfif ListFind(TeamNameList, ThisTeamName) >
          <cfset HighlightPlayingMoreThanOnceToday = "Yes">
		  <cfset HomeTeamPlayingMoreThanOnceToday = "Yes">
        </cfif>
		<cfif AwayOrdinal IS "">
			<cfset ThisTeamName = "#AwayTeam#" >
		<cfelse>
			<cfset ThisTeamName = "#AwayTeam# #AwayOrdinal#" >
		</cfif>
        <cfif ListFind(TeamNameList, ThisTeamName) >
          <cfset HighlightPlayingMoreThanOnceToday = "Yes">
		  <cfset AwayTeamPlayingMoreThanOnceToday = "Yes">
        </cfif>
        <tr align="left" class="bg_contrast" >	
		
			<cfif	(Result IS NOT "P" AND Result IS NOT "T" AND Result IS NOT "") OR
					HomeGoals  IS NOT "" OR
					AwayGoals  IS NOT "" OR
					RefereeMarksH IS NOT "" OR
					RefereeMarksA IS NOT "" OR
					AsstRef1Marks IS NOT "" OR
					AsstRef2Marks IS NOT "" OR
					AsstRef1MarksH IS NOT "" OR
					AsstRef1MarksA IS NOT "" OR
					AsstRef2MarksH IS NOT "" OR
					AsstRef2MarksA IS NOT "" OR
					HomeSportsmanshipMarks IS NOT "" OR
					AwaySportsmanshipMarks IS NOT "" OR
					AppearanceCount IS NOT 0>
			   <cfset DisplayCheckbox = "No">
			<cfelse>
			   <cfset DisplayCheckbox = "Yes">
			</cfif>
						<cfif DisplayCheckbox IS "Yes">
							<cfif StructKeyExists(form, "Button") >
								<cfif form.Button IS "Tick All"><!--- Tick All --->
									<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" checked></td>
								<cfelseif form.Button IS "Untick All"><!--- Untick All --->
									<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" ></td>
								<cfelseif form.Button IS "Delete Ticked"><!--- Delete Ticked --->
									<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" ></td>
								<cfelseif form.Button IS "Hide Ticked"><!--- Hide Ticked --->
									<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" ></td>
								<cfelseif form.Button IS "Publish Ticked"><!--- Publish Ticked --->
									<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" ></td>
								<cfelseif form.Button IS "NV Ticked"><!--- Normal Venue Ticked --->
									<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" ></td>
								<cfelseif form.Button IS "Reschedule Ticked"><!--- Reschedule Ticked --->
									<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" ></td>
								</cfif>
								<cfif RIGHT(request.dsn,4) GE 2012>		<!--- applies to season 2012 onwards only --->
									<cfif form.Button IS "Hide M.O. Ticked"><!--- Hide Match Officials for Ticked --->
										<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" ></td>
									<cfelseif form.Button IS "Publish M.O. Ticked"><!--- Publish Match Officials for Ticked --->
										<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#" ></td>
									</cfif>
								</cfif>
							<cfelse>
								<td width="5" align="center" <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="silver"</cfif> ><input name="Fxt#FID#" type="checkbox" value="#FID#"></td>
							</cfif>
							<cfset CheckboxCount = CheckboxCount + 1>
						<cfelse>
							<td <cfif HighlightPlayingMoreThanOnceToday IS "Yes">bgcolor="red"<cfelse>bgcolor="white"</cfif>>&nbsp;</td>
						</cfif>
			
			<!--- merge cells if Postponed, Abandoned, Void, Temp or HideDivision --->
			<cfif Result IS "P" >
				<td width="70" colspan="2" align="center"><span class="pix18boldgray">P</span></td>
			<cfelseif Result IS "Q" >
				<td width="70" colspan="2" align="center"><span class="pix18boldgray">A</span></td>
			<cfelseif Result IS "W" >
				<td width="70" colspan="2" align="center"><span class="pix18boldgray">V</span></td>
			<cfelseif Result IS "T" >
				<td width="70" colspan="2" align="center"  bgcolor="aqua"><span class="pix18boldgray">TEMP</span></td>
			<cfelse>
				<td width="35" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif>> 
				<span class="pix13bold"> 
				<cfif Result IS "H" >
				  H 
				  <cfelseif Result IS "A" >
				  - 
				  <cfelseif Result IS "D" >
				  D 
				  <cfelse>
				  #HomeGoals# 
				</cfif>
				</span> </td>
				<td width="35" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif>> 
				<span class="pix13bold"> 
				<cfif Result IS "H" >
				  - 
				  <cfelseif Result IS "A" >
				  A 
				  <cfelseif Result IS "D" >
				  D 
				  <cfelse>
				  #AwayGoals# 
				</cfif>
				</span> </td>
			</cfif>
          <td <cfif Highlight>class="bg_highlight"</cfif> > <cfset MatchReportHeading = "#ThisDivName#" > 
            <cfset MatchReportDate = "#DateFormat(MDate, 'DDDD, DD MMMM YYYY')#" > 
               <cfinclude template="InclMatchReportIcon.cfm">
			   <cfinclude template="InclEmailHomeTeamIcon.cfm">
			<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>
              <span class="pix10italic">#NumberFormat(MatchNumber, "000")#</span> 
            </cfif> 
		  	<cfset HTeamName = Trim("#HomeTeam# #HomeOrdinal#")>
		  	<cfset ATeamName = Trim("#AwayTeam# #AwayOrdinal#")>
              
			  
			  <cfif UCase(HomeGuest) IS "GUEST">
                <a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#FHomeID#&AwayID=#FAwayID#&LeagueCode=#LeagueCode#&Whence=MD"> 
                <cfif HomeTeamPlayingMoreThanOnceToday IS "Yes"><span class="pix13boldreditalic"><cfelse><span class="pix13bolditalic"></cfif><u>#HTeamName#</u></span></a> 
                <cfelse>
                <a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#FHomeID#&AwayID=#FAwayID#&LeagueCode=#LeagueCode#&Whence=MD"> 
                <cfif HomeTeamPlayingMoreThanOnceToday IS "Yes"><span class="pix13boldred"><cfelse><span class="pix13bold"></cfif><u>#HTeamName#</u></span></a> 
              </cfif>
 				  <cfinclude template="queries/qry_QAnyHomeAppearances.cfm">
				  <cfif QAnyHomeAppearances.HCount IS 0><cfset HomeTeamSheetEmpty = 1><cfelse><cfset HomeTeamSheetEmpty = 0></cfif>
				  <cfinclude template="queries/qry_QAnyAwayAppearances.cfm">
				  <cfif QAnyAwayAppearances.ACount IS 0><cfset AwayTeamSheetEmpty = 1><cfelse><cfset AwayTeamSheetEmpty = 0></cfif>
				<cfif HomeTeamSheetOK IS 0><cfset ToolTipText = "Click to see the Home Team Sheet. Future updates by the club secretary ALLOWED."><cfelse><cfset ToolTipText = "Click to see the Home Team Sheet. Future updates by the club secretary PREVENTED."></cfif>
				<cfif HomeTeamSheetOK IS 0><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><cfif HomeTeamSheetEmpty IS 1><img src="WhiteTS.gif" border="0"><cfelse><img src="lightgreen.jpg" border="0"></cfif></a><cfelse><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="pink.jpg" border="0"></a></cfif>
              <span class="pix13bold">v</span> 
				<cfif AwayTeamSheetOK IS 0><cfset ToolTipText = "Click to see the Away Team Sheet. Future updates by the club secretary ALLOWED."><cfelse><cfset ToolTipText = "Click to see the Away Team Sheet. Future updates by the club secretary PREVENTED."></cfif>
				<cfif AwayTeamSheetOK IS 0><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><cfif AwayTeamSheetEmpty IS 1><img src="WhiteTS.gif" border="0"><cfelse><img src="lightgreen.jpg" border="0"></cfif></a><cfelse><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="pink.jpg" border="0"></a></cfif>
 			  <cfif UCase(AwayGuest) IS "GUEST">
                <a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#FHomeID#&AwayID=#FAwayID#&LeagueCode=#LeagueCode#&Whence=MD"> 
                <cfif AwayTeamPlayingMoreThanOnceToday IS "Yes"><span class="pix13boldreditalic"><cfelse><span class="pix13bolditalic"></cfif><u>#ATeamName#</u></span></a> 
                <cfelse>
                <a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#FHomeID#&AwayID=#FAwayID#&LeagueCode=#LeagueCode#&Whence=MD"> 
                <cfif AwayTeamPlayingMoreThanOnceToday IS "Yes"><span class="pix13boldred"><cfelse><span class="pix13bold"></cfif><u>#ATeamName#</u></span></a> 
              </cfif>
 				<cfif Len(Trim(QFixtures.PrivateNotes)) GT 0 >
					<cfset ToolTipText = QFixtures.PrivateNotes >
					<cfset TooltipText = Replace(ToolTipText, "'", "\'", "ALL")>
					<cfset TooltipText = Replace(ToolTipText, CHR(34), "\'", "ALL")>
					<cfset TooltipText = Replace(TooltipText, "&", "& amp", "ALL")>
					<cfset TooltipText = Replace(TooltipText, CHR(13), " ", "ALL")>
					<cfset TooltipText = Replace(TooltipText, CHR(10), " ", "ALL")>
					<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#ToolTipText#')"><img src="gif/PrivateComments.gif" width="68" height="27" border="1" align="top"></a>
				</cfif>
			  
				<cfif Len(Trim(QFixtures.HomeTeamNotes)) GT 0 >
					<cfset ToolTipText = QFixtures.HomeTeamNotes >
					<cfset TooltipText = Replace(ToolTipText, "'", "\'", "ALL")>
					<cfset TooltipText = Replace(ToolTipText, CHR(34), "\'", "ALL")>
					<cfset TooltipText = Replace(TooltipText, "&", "& amp", "ALL")>
					<cfset TooltipText = Replace(TooltipText, CHR(13), " ", "ALL")>
					<cfset TooltipText = Replace(TooltipText, CHR(10), " ", "ALL")>
					<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#ToolTipText#')"><img src="gif/HomeComments.gif" width="68" height="27" border="1" align="top"></a>
				</cfif>
				<cfif Len(Trim(QFixtures.AwayTeamNotes)) GT 0 >
					<cfset ToolTipText = QFixtures.AwayTeamNotes >
					<cfset TooltipText = Replace(ToolTipText, "'", "\'", "ALL")>
					<cfset TooltipText = Replace(ToolTipText, CHR(34), "\'", "ALL")>
					<cfset TooltipText = Replace(TooltipText, "&", "& amp", "ALL")>
					<cfset TooltipText = Replace(TooltipText, CHR(13), " ", "ALL")>
					<cfset TooltipText = Replace(TooltipText, CHR(10), " ", "ALL")>
					<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#ToolTipText#')"><img src="gif/AwayComments.gif" width="68" height="27" border="1" align="top"></a>
				</cfif>

			<cfif TRIM(#RoundName#)IS NOT "" >
				<span class="pix13boldnavy">[ #RoundName# ]</span> </cfif> 
			<cfif Result IS "H" AND HideScore IS "No" >
				<span class="pix13boldnavy">[ Home Win was awarded ]</span> 
			<cfelseif Result IS "A" AND HideScore IS "No" >
				<span class="pix13boldnavy">[ Away Win was awarded ]</span> 
			<cfelseif Result IS "U" AND HideScore IS "No" >
				<span class="pix13boldnavy">[ Home Win on penalties ]</span> 
			<cfelseif Result IS "V" AND HideScore IS "No" >
				<span class="pix13boldnavy">[ Away Win on penalties ]</span> 
			<cfelseif Result IS "D" AND HideScore IS "No" >
				<span class="pix13boldnavy">[ Draw was awarded ]</span> 
			<cfelseif Result IS "P" >
              <span class="pix13boldnavy">[ Postponed ]</span> 
			<cfelseif Result IS "Q" >
              <span class="pix13boldnavy">[ Abandoned ]</span> 
			<cfelseif Result IS "W" >
              <span class="pix13boldnavy">[ Void ]</span> 
			<cfelseif Result IS "T" >
			  <span class="pix10italic"> fixture hidden from the public </span> 
			<cfelse>
            </cfif>
<!---
					********************
					* Starting Line-Up *
					********************
--->					
				
				<cfset TheHomeTeam = QFixtures.HomeTeam>
				<cfset TheHomeOrdinal = QFixtures.HomeOrdinal>
				<cfset TheAwayTeam = QFixtures.AwayTeam>
				<cfset TheAwayOrdinal = QFixtures.AwayOrdinal>
				
<!---
					********************
					* Starting Line-Up *
					********************
--->					
				<cfset tooltiptext = "">
				<cfinclude template="queries/qry_QTeamStartingLineUpHome.cfm">
				<cfinclude template="queries/qry_QTeamStartingLineUpAway.cfm">
				<cfif (QTeamStartingLineUpHome.RecordCount + QTeamStartingLineUpAway.RecordCount) GT 0>
						
					<!--- process the Home team --->
					<cfif QTeamStartingLineUpHome.RecordCount GT 0 >
						<cfset FirstActivity2 = "No">
						<cfset FirstActivity3 = "No">
						<cfset tooltiptext = "#tooltiptext#<div style='text-align:center;text-decoration:underline'>#TheHomeTeam# #TheHomeOrdinal#</div><br>">
						<cfloop query="QTeamStartingLineUpHome">
							<!--- query is sorted into Activity groups Activity=1 then Activity=2 then Activity=3 --->
							<cfif Activity IS 1>    <!--- Players who were in the starting eleven --->
								<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
							<cfelseif Activity IS 2> <!--- substitutes who played --->
								<cfif FirstActivity2 IS "No">
									<cfset FirstActivity2 = "Yes">
									<cfset tooltiptext = "#tooltiptext#<hr>">  <!--- draw a line under the starting eleven --->
								</cfif>
								<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;background-color:##F5F5DC;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
							<cfelseif Activity IS 3>   <!--- substitutes who did not play --->
								<cfif FirstActivity3 IS "No">
									<cfset FirstActivity3 = "Yes">
									<cfset tooltiptext = "#tooltiptext#<hr>" >  <!--- draw a line under the last substitute who played --->
								</cfif>
								<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;background-color:##F8F8FF;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
							<cfelse>
								ERROR 37 in MtchDayQuick.cfm
							</cfif>
						</cfloop>
						<cfset tooltiptext = "#tooltiptext#<br>">
					</cfif>
					<!--- process the Away team --->
					<cfif QTeamStartingLineUpAway.RecordCount GT 0 >
						<cfset FirstActivity2 = "No">
						<cfset FirstActivity3 = "No">
						<cfset tooltiptext = "#tooltiptext#<div style='text-align:center;text-decoration:underline'>#TheAwayTeam# #TheAwayOrdinal#</div><br>">
						<cfloop query="QTeamStartingLineUpAway">
							<!--- query is sorted into Activity groups Activity=1 then Activity=2 then Activity=3 --->
							<cfif Activity IS 1>    <!--- Players who were in the starting eleven --->
								<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
							<cfelseif Activity IS 2> <!--- substitutes who played --->
								<cfif FirstActivity2 IS "No">
									<cfset FirstActivity2 = "Yes">
									<cfset tooltiptext = "#tooltiptext#<hr>">  <!--- draw a line under the starting eleven --->
								</cfif>
								<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;background-color:##F5F5DC;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
							<cfelseif Activity IS 3>   <!--- substitutes who did not play --->
								<cfif FirstActivity3 IS "No">
									<cfset FirstActivity3 = "Yes">
									<cfset tooltiptext = "#tooltiptext#<hr>" >  <!--- draw a line under the last substitute who played --->
								</cfif>
								<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;background-color:##F8F8FF;'>#NumberFormat(ActualShirtNumber, '00')# #Left(Forename,1)#. #Surname#</div>">
							<cfelse>
								ERROR 38 in MtchDayQuick.cfm
							</cfif>
						</cfloop>
						<cfset tooltiptext = "#tooltiptext#<br>">
					</cfif>
					<cfset tooltiptext = Replace(tooltiptext, "'", "\'", "ALL")>
					<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='##FFFFF0';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')"><img src="images/icon_lineup.png" border="0" align="absmiddle"></a>
				</cfif>
			
			
			<cfif VenueAndPitchAvailable IS "Yes" <!--- AND UCase(HomeGuest) IS NOT "GUEST" ---> >
				<cfinclude template="InclFixturePitchAvailability.cfm">
					<cfif FixturePitchAvailability3.RecordCount IS 0>
						<cfset PitchNotAvailableCount = PitchNotAvailableCount + 1>
					</cfif>
			</cfif>

			<cfif ListFind(DHList,FID)  AND HideDoubleHdrMsg IS 0 >
				<span class="pix10boldnavy"><br>Double Header</span>
			</cfif>
			
			<cfif KOTime IS "" >
            <cfelse>
              <span class="pix10brand"><br><strong>#TimeFormat(KOTime, 'h:mm TT')#</strong></span>
			</cfif> 
			
			<cfif #Attendance# IS "" >
            <cfelse>
              <span class="pix10navy"><br>
              Attendance #NumberFormat(Attendance, '99,999')#</span> </cfif> <cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0>
              <span class="pix10"><br>
              #HomeTeam# #HomeOrdinal# #NumberFormat(HomePointsAdjust,"+9")# 
            	<cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>
                point
                <cfelse>
                points
				</cfif>
              </span>
			</cfif> 
			  <cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0>
              <span class="pix10"><br>
              #AwayTeam# #AwayOrdinal# #NumberFormat(AwayPointsAdjust,"+9")# 
              <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>
                point
                <cfelse>
                points
              </cfif>
              </span></cfif> <span class="pix10"> 
            <cfif #FixtureNotes# IS "" >
              <cfelse>
              <br>
              #FixtureNotes# 
            </cfif>
            </span> 
				<cfif #MatchReportID# IS NOT "" AND #MatchReportID# IS NOT 0>
					<br>
					<a href="SeeMatchReport.cfm?MatchReportID=#MatchReportID#&LeagueCode=#LeagueCode#&TblName=Matches&LeagueName=#URLEncodedFormat(LeagueName)#&SeasonName=#SeasonName#" target="#LeagueCode#MatchReport#MatchReportID#">
					<!--- <span class="pix10">see</span></a><span class="pix10boldred"> Match Report</span>--->
					<span class="pix10boldred">Match Report</span></a> 
				</cfif>
			</td>
			<cfif Len(Trim(RefsFullName)) GT 0>
		  		<cfset TooltipText = "Click to see when #RefsFullName# refereed games involving #HomeTeam# #HomeOrdinal# and #AwayTeam# #AwayOrdinal#">
		  		<cfset TooltipText = "Click to see when #RefsFullName# refereed games involving #HomeTeam# #HomeOrdinal# and #AwayTeam# #AwayOrdinal#">
				<cfset TooltipText = Replace(ToolTipText, "'", "\'", "ALL")>
				<cfset TooltipText = Replace(ToolTipText, CHR(34), "\'", "ALL")>
				<cfset TooltipText = Replace(TooltipText, "&", "& amp", "ALL")>
				<cfset TooltipText = Replace(TooltipText, CHR(13), " ", "ALL")>
				<cfset TooltipText = Replace(TooltipText, CHR(10), " ", "ALL")>
			<cfelse>
				<cfset TooltipText = "no referee">
		  	</cfif>
			
            <td valign="middle"><a href="javascript:void window.open('ThisRefsHistory.cfm?HID=#FHomeID#&AID=#FAwayID#&MD=#ThisDate#&RID=#RefsID#&LeagueCode=#LeagueCode#','ThisRefsHistory','height=900,width=600,left=10,top=10,resizable=yes,scrollbars=yes').focus()" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=400;return escape('#TooltipText#')"><IMG src="gif/RefsHistory.gif" alt="Referee History" width="42" height="14"  border="1" align="absmiddle"></a></td>
          <cfinclude template="InclOfficials.cfm">
          <!---  <td></td> Referee's History link, Referee and Assistants --->
        </tr>
		
        <cfif DefaultGoalScorers IS "Yes" >
          <cfinclude template="InclGoalscorers.cfm">
        </cfif>
		<cfinclude template="InclCheckFreeDay.cfm">
      </cfoutput> 
			<tr> 
				<td height="4" colspan="#ThisColSpan#" bgcolor="white"></td>
			</tr>
	  
	  
              <!------- <cfinclude template="InclMatchReportIcon.cfm"> ------>
    </cfoutput> 
	
		<cfif PitchNotAvailableCount GT 2>
			<cfoutput><span class="pix13bold">There are #PitchNotAvailableCount# fixtures with '<span class="pix10boldnavy">[venue not specified]</span>'. Please consider using the NV button below to fix these.</span></cfoutput>
		</cfif>			  
	
	<cfif CheckboxCount GT 0 >
		<cfoutput>
			<tr>
				<td colspan="6">
				<table border="0" align="left" cellpadding="0" cellspacing="2" bgcolor="silver">
				<tr>
						<!--- season dates - less one for start, plus one for end - this info used in calendar to block non-season dates! --->
						<cfset LOdate = DateAdd('D', -1, SeasonStartDate) >
						<cfset HIdate = DateAdd('D',  1, SeasonEndDate) >
						<SCRIPT type="text/javascript">
							// note date type on disable calls
							<cfoutput>
							var cal1 = new CalendarPopup(); 
							cal1.addDisabledDates(null, '#LSDateFormat(LOdate, "mmm dd, yyyy")#'); 
							cal1.addDisabledDates('#LSDateFormat(HIdate, "mmm dd, yyyy")#', null);
							cal1.offsetX = 75;
							cal1.offsetY = -150;
							</cfoutput>
						</SCRIPT>

					
					<!--- Tick All --->
					<cfset ToolTipText = "Tick all matches">
					<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=100;return escape('#ToolTipText#')" >
					<td align="center"><input name="Button" type="submit" onMouseOver="#onMouseOverText#" value="Tick All"></td>
					
					<!--- Untick All --->
					<cfset ToolTipText = "Untick all matches">
					<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=100;return escape('#ToolTipText#')" >
					<td align="center"><input name="Button" type="submit" onMouseOver="#onMouseOverText#" value="Untick All"></td>
					
					<td align="center" width="40"><span class="pix13bold">&nbsp;</span></td>
					
					<!--- Delete Ticked --->
					<cfset ToolTipText = "Delete ticked matches">
					<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=100;return escape('#ToolTipText#')" >
					<td align="center"><input name="Button" type="submit" onMouseOver="#onMouseOverText#" value="Delete Ticked"></td>
					
					<!--- Hide Ticked --->
					<cfset ToolTipText = "Hide ticked matches">
					<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=100;return escape('#ToolTipText#')" >
					<td align="center"><input name="Button" type="submit" onMouseOver="#onMouseOverText#" value="Hide Ticked"></td>
					
					<!--- Publish Ticked --->
					<cfset ToolTipText = "Publish ticked matches">
					<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=100;return escape('#ToolTipText#')" >
					<td align="center"><input name="Button" type="Submit" onMouseOver="#onMouseOverText#" value="Publish Ticked"></td>

					<!--- if venue not already specified then assume normal venue for Ticked --->
					<cfset ToolTipText = "If <em>[venue not specified]</em> then use the Normal Venue for ticked matches">
					<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=200;return escape('#ToolTipText#')" >
					<td align="center"><input name="Button" type="Submit" onMouseOver="#onMouseOverText#" value="NV Ticked"></td>
					
					<td align="center" width="60"><span class="pix13bold">&nbsp;or&nbsp;</span></td>
					
					<cfset ToolTipText = "Reschedule ticked matches">
					<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=100;return escape('#ToolTipText#')" >
					<td align="center"><a href="javascript:void(0);" onClick="cal1.select(MtchDayAction.datebox,'anchor1','EE, dd MMM yyyy'); return true;" NAME="anchor1" ID="anchor1"><span class="pix13bold"><u>choose</u></span></a><span class="pix13bold"> new date </span><input name="datebox" type="text" size="30" readonly="true" value="#DateFormat(MDate, 'DDDD, DD MMMM YYYY')#" ><span class="pix13bold"> then </span>
						<input name="Button" type="Submit" onMouseOver="#onMouseOverText#" value="Reschedule Ticked"> 
					</td>
				</tr>
					<cfif RIGHT(request.dsn,4) GE 2012>		<!--- applies to season 2012 onwards only --->
						<tr><td align="center" colspan="9"><hr></td></tr>
						<tr>
							<td align="center" colspan="8"><span class="pix13bold">&nbsp;</span></td>
							<td>
								<table border="0" align="right" cellpadding="0" cellspacing="2" class="bg_contrast">
									<tr>
										<td align="center" colspan="8"><span class="pix13bold">Match Officials</span></td>
										<!--- Hide Match Officials for ticked matches --->
										<cfset ToolTipText = "Hide Match Officials for ticked matches">
										<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=100;return escape('#ToolTipText#')" >
										<td align="center"><input name="Button" type="submit" onMouseOver="#onMouseOverText#" value="Hide M.O. Ticked"></td>
										<td align="center"><!--- Match Officials icons --->
											<img src="images/icon_referee.png" border="0">
											<img src="images/icon_line1.png" border="0">
											<img src="images/icon_line2.png" border="0">
											<img src="images/icon_4th.png" border="0">
										</td>
										<!--- Publish Match Officials for ticked matches --->
										<cfset ToolTipText = "Publish Match Officials for ticked matches">
										<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=100;return escape('#ToolTipText#')" >
										<td align="center"><input name="Button" type="Submit" onMouseOver="#onMouseOverText#" value="Publish M.O. Ticked"></td>
									</tr>
								</table>
							</td>
						</tr>
					</cfif>
				</table>
				</td>
			</tr>
		</cfoutput>
	</cfif>
	</table>
  
	
</cfif>


</cfif> <!--- finishPage --->


<cflock scope="session" timeout="10" type="exclusive">
	<cfif NOT IsDate(MDate) >
		<cfset session.CurrentDate = Now() >
	<cfelse>
		<cfset session.CurrentDate = DateFormat(MDate, 'YYYY-MM-DD') >
	</cfif>
</cflock>

</cfform>

<hr>

<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
