<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif NOT StructKeyExists(form, "Operation")>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
	<cfif NOT StructKeyExists(form, "TblName")>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
	<cfif form.Operation IS NOT "Update">
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
	<cfif form.TblName IS NOT "Referee">
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>

<!---  for yellow security level check that the url.ID (referee's id) parameter and leaguecode parametere have not been tampered with.  --->
	<cflock scope="session" timeout="10" type="readonly">
		<cfset request.YellowKey = session.YellowKey  >
	</cflock>
	<cfif form.ID IS "#Reverse(GetToken(Reverse(request.YellowKey),1,'|'))#" AND form.LeagueCode IS "#GetToken(request.YellowKey,1,'|')#">
		<!--- all OK --->
	<cfelse>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
</cfif>

<cfoutput>
<cfif NOT StructKeyExists(form, "Operation") AND (form.TblName IS "Newsitem"  OR form.TblName IS "Noticeboard"  OR form.TblName IS "MatchReport" ) >
	<cfset form.Operation = "Update">
</cfif>
<CFSWITCH expression="#FORM.Operation#">

	<CFCASE VALUE="Update">
	<!---
																			***********
																			*  UPDATE *
																			***********
	--->
	
	  <CFSWITCH expression="#TblName#">
		
		<CFCASE VALUE="Player">
		
			<cfif Form.FANGang IS "1">
				<cfset Form.FAN = Form.ShortCol>
			</cfif>
			
			<cfinclude template="InclCheckPlayerForm.cfm">
			<cfset ThisLeagueID = form.LeagueID >
			<cfinclude template="queries/upd_QUpdtPlayerRecord.cfm">
			<cfif StructKeyExists(form, "ws_insert")>
				<!--- do nothing --->
			<cfelse>
				<cflocation url="LUList.cfm?TblName=Player&LeagueCode=#Form.LeagueCode#&FirstNumber=#Form.ShortCol#&LastNumber=#Form.ShortCol#" ADDTOKEN="NO">
				<cfabort>
			</cfif>

		</CFCASE>
		
		<CFCASE VALUE="Referee">
		
			<cfinclude template="InclCheckRefereeForm.cfm">
			
			<!--- applies to season 2012 onwards only --->
			<cfif RIGHT(request.dsn,4) GE 2012 <!--- AND ListFind("Yellow",request.SecurityLevel)---> >
				<!--- snapshot before --->
				<cfinclude template="queries/qry_QRefereeBefore.cfm">
			</cfif>
				
			<cfinclude template="queries/upd_Referee.cfm">

			<!--- applies to season 2012 onwards only --->
			<cfif RIGHT(request.dsn,4) GE 2012 <!--- AND ListFind("Yellow",request.SecurityLevel)---> >
				<!--- snapshot after --->
				<cfinclude template="queries/qry_QRefereeAfter.cfm">
			</cfif>

			<!--- applies to season 2012 onwards only --->
			<cfif RIGHT(request.dsn,4) GE 2012 <!---AND ListFind("Yellow",request.SecurityLevel)---> >
				<!--- check for any changes --->
				<cfloop index = "ListElement" list = "longcol,mediumcol,shortcol,notes,EmailAddress1,EmailAddress2,Level,PromotionCandidate,Restrictions,Surname,Forename,DateOfBirth,FAN,ParentCounty,AddressLine1,AddressLine2,AddressLine3,PostCode,HomeTel,WorkTel,MobileTel"> 
					<cfscript>
						ThisRefereeID = #Form.ID#;
						ThisFieldName = "#ListElement#" ;
						BeforeValue = "QRefereeBefore.#ThisFieldName#" ;
						BeforeValue = Evaluate(BeforeValue);
						AfterValue = "QRefereeAfter.#ThisFieldName#" ;
						AfterValue = Evaluate(AfterValue);
						SecurityLevel = "#MID(request.SecurityLevel,4,1)#" ;
					</cfscript>
					<cfif Trim(BeforeValue) IS NOT Trim(AfterValue) >
						<cfinclude template="queries/ins_RefereeUpdateLog.cfm">
					</cfif>
				</cfloop>
			</cfif>
			<cfif ListFind("Yellow",request.SecurityLevel) >
				<CFLOCATION URL="UpdateForm.cfm?TblName=Referee&ID=#form.ID#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
			<cfelse>
				<CFLOCATION URL="LUList.cfm?TblName=Referee&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
			</cfif>
		</CFCASE>

		<CFCASE VALUE="Division">
			<cfinclude template="InclCheckDivisionForm.cfm">
			<cfinclude template="queries/qry_DuplicateDivisionFields.cfm">
			<cfif QDuplicateLongCol.RecordCount IS 0 >
			<cfelseif QDuplicateLongCol.RecordCount IS 1 AND QDuplicateLongCol.ID IS #Form.ID#>
			<cfelse>
				<cfinclude template="ErrorMessages/Action/Duplicate_Competition_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif QDuplicateMediumCol.RecordCount IS 0 >
			<cfelseif QDuplicateMediumCol.RecordCount IS 1 AND QDuplicateMediumCol.ID IS #Form.ID#>
			<cfelse>
				<cfinclude template="ErrorMessages/Action/Duplicate_Sort_Order_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif QDuplicateShortCol.RecordCount IS 0 >
			<cfelseif QDuplicateShortCol.RecordCount IS 1 AND QDuplicateShortCol.ID IS #Form.ID#>
			<cfelse>
				<cfinclude template="ErrorMessages/Action/Duplicate_Competition_Code_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfinclude template="queries/upd_Division.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Division&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>

		<CFCASE VALUE="Venue">
			<cfinclude template="InclCheckVenueForm.cfm">
			<cfinclude template="queries/upd_Venue.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Venue&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>

		<CFCASE VALUE="Team">
			<cfif Trim(UCase(Form.MediumCol)) IS "GUEST">
				<cfinclude template="ErrorMessages/Action/GUEST_not_allowed.htm">
				<CFABORT>
			</cfif>
			
			<cfif Form.ShortCol IS NOT "" AND UCase(Form.ShortCol) IS NOT "GUEST">
				<cfinclude template="ErrorMessages/Action/Only_GUEST_or_empty_allowed.htm">
				<CFABORT>
			</cfif>
			
			<cfinclude template="check_for_empty.cfm">
			<cfinclude template="check_for_commas_and_quotes.cfm">
			<cfinclude template="queries/upd_Team.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Team&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>
		
		<CFCASE VALUE="Constitution">
			<cfinclude template="InclUpdtConstit.cfm">
			<cfset ThisDivisionID = DivisionID >
			<cfinclude template="RefreshLeagueTable.cfm">
			<cfif StructKeyExists(form, "S")> <!--- S is the Sort Order, if the user clicks on one of the three Sort column headings --->
				<CFLOCATION URL=
				"ConstitList.cfm?S=#Form.S#&TblName=#Form.TblName#&DivisionID=#Form.DivisionID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&ThisMatchNoID=#Form.ThisMatchNoID#&NextMatchNoID=#Form.NextMatchNoID#&LeagueCode=#Form.LeagueCode#" 
				ADDTOKEN="NO">
			<cfelse>
				<CFLOCATION URL=
				"ConstitList.cfm?TblName=#Form.TblName#&DivisionID=#Form.DivisionID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&ThisMatchNoID=#Form.ThisMatchNoID#&NextMatchNoID=#Form.NextMatchNoID#&LeagueCode=#Form.LeagueCode#" 
				ADDTOKEN="NO">
			</cfif>
		</CFCASE>

		<CFCASE VALUE="PitchAvailable">
			<cfinclude template="InclUpdatePitchAvailable.cfm">
			<CFLOCATION URL="PitchAvailableList.cfm?TblName=#Form.TblName#&VenueID=#Form.VenueID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&PitchNoID=#Form.PitchNoID#&PitchStatusID=#Form.PitchStatusID#&LeagueCode=#Form.LeagueCode#&PA=#Form.ThisPA#&year_to_view=#Year(BookingDate)#&month_to_view=#Month(BookingDate)#" ADDTOKEN="NO">
		</CFCASE>
		
		<CFCASE VALUE="Matches">


			<!--- Check to see if they are still putting the match attendance figure in the Notes area , I don't allow this --->
			<cfif form.TextNotes IS "">
			<cfelseif Left(form.TextNotes,3) IS "att" >
				<cfinclude template="ErrorMessages/Action/Attendance.htm">
				<CFABORT>
			<cfelseif FindNoCase(" att", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/Attendance.htm">
				<CFABORT>
			<cfelse>
			</cfif>


			<!--- Check to see if they are still putting the kick off time in the Notes area , I don't allow this --->
			<cfif form.TextNotes IS "">
			<cfelseif form.KOTime IS NOT "">
			<cfelseif FindNoCase("ko", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif FindNoCase("k.o", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif FindNoCase("k o", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif FindNoCase("kick off", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif FindNoCase("kick-off", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif REFindNoCase("[0-9]am", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif REFindNoCase("[0-9]pm", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif REFindNoCase("[0-9]a.m", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif REFindNoCase("[0-9]p.m", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif REFindNoCase("[0-9] am", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif REFindNoCase("[0-9] pm", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif REFindNoCase("[0-9] a.m", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
			<cfelseif REFindNoCase("[0-9] p.m", form.TextNotes) GT 0>
				<cfinclude template="ErrorMessages/Action/KOTime.htm">
				<CFABORT>
				
			<cfelse>
			</cfif>



<!---
***********************************************
*  HOME WIN, AWAY WIN, DRAWN, penalty decider *
***********************************************
--->
			<CFSWITCH expression="#FORM.RadioButton#">

				<CFCASE VALUE="Result">
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">
						<CFABORT>
				</CFCASE>
					
				<CFCASE VALUE="Home Win">
						<cfif Form.HomeGoals IS NOT "" OR Form.AwayGoals IS NOT "">
							<cfinclude template="ErrorMessages/Action/An_awarded_Home_Win.htm">
							<CFABORT>
						</cfif>
						<cfset Form.HomeGoals = "" >
						<cfset Form.AwayGoals = "" >			
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">
						<CFABORT>
				</CFCASE>
				
				<CFCASE VALUE="Away Win">
						<cfif Form.HomeGoals IS NOT "" OR Form.AwayGoals IS NOT "">
							<cfinclude template="ErrorMessages/Action/An_awarded_Away_Win.htm">
							<CFABORT>
						</cfif>
						<cfset Form.HomeGoals = "" >
						<cfset Form.AwayGoals = "" >			
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">			
						<CFABORT>
				</CFCASE>
				
				<CFCASE VALUE="Drawn">
						<cfif Form.HomeGoals IS NOT "" OR Form.AwayGoals IS NOT "">
							<cfinclude template="ErrorMessages/Action/An_awarded_Draw.htm">
							<CFABORT>
						</cfif>
						<cfset Form.HomeGoals = "" >
						<cfset Form.AwayGoals = "" >			
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">
						<CFABORT>
				</CFCASE>
				
				<CFCASE VALUE="Home Win on penalties">
						<cfif Form.HomeGoals IS Form.AwayGoals AND IsNumeric(Form.HomeGoals) AND IsNumeric(Form.AwayGoals)>
						<cfelse>
							<cfinclude template="ErrorMessages/Action/Home_Win_on_penalties.htm">
							<CFABORT>
						</cfif>
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">			
						<CFABORT>
				</CFCASE>
				
				<CFCASE VALUE="Away Win on penalties">
						<cfif Form.HomeGoals IS Form.AwayGoals AND IsNumeric(Form.HomeGoals) AND IsNumeric(Form.AwayGoals)>
						<cfelse>
							<cfinclude template="ErrorMessages/Action/Away_Win_on_penalties.htm">
							<CFABORT>
						</cfif>
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">			
						<CFABORT>
				</CFCASE>
				
				<CFCASE VALUE="Postponed">
						<cfif Form.HomeGoals IS NOT "" OR Form.AwayGoals IS NOT "">
							<cfinclude template="ErrorMessages/Action/A_Postponed.htm">
							<CFABORT>
						</cfif>
						<cfset Form.HomeGoals = "" >
						<cfset Form.AwayGoals = "" >			
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">
						<CFABORT>
				</CFCASE>
				
				<CFCASE VALUE="Abandoned">
						<cfif Form.HomeGoals IS NOT "" OR Form.AwayGoals IS NOT "">
							<cfinclude template="ErrorMessages/Action/An_Abandoned.htm">
							<CFABORT>
						</cfif>
						<cfset Form.HomeGoals = "" >
						<cfset Form.AwayGoals = "" >			
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">
						<CFABORT>
				</CFCASE>

				<CFCASE VALUE="Void">
						<cfif Form.HomeGoals IS NOT "" OR Form.AwayGoals IS NOT "">
							<cfinclude template="ErrorMessages/Action/A_Void.htm">
							<CFABORT>
						</cfif>
						<cfset Form.HomeGoals = "" >
						<cfset Form.AwayGoals = "" >			
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">
						<CFABORT>
				</CFCASE>
				<CFCASE VALUE="TEMP">
						<cfif Form.HomeGoals IS NOT "" OR Form.AwayGoals IS NOT "">
							<cfinclude template="ErrorMessages/Action/A_TEMP.htm">
							<CFABORT>
						</cfif>
						<cfif Form.RefereeMarksH IS NOT "" OR Form.RefereeMarksA IS NOT "">
							<cfinclude template="ErrorMessages/Action/A_TEMP.htm">
							<CFABORT>
						</cfif>
						<cfif Form.AsstRef1Marks IS NOT "" OR Form.AsstRef2Marks IS NOT "">
							<cfinclude template="ErrorMessages/Action/A_TEMP.htm">
							<CFABORT>
						</cfif>
						<cfif Form.AsstRef1MarksH IS NOT "" OR Form.AsstRef1MarksA IS NOT "" OR Form.AsstRef2MarksH IS NOT "" OR Form.AsstRef2MarksA IS NOT "">
							<cfinclude template="ErrorMessages/Action/A_TEMP.htm">
							<CFABORT>
						</cfif>
						<cfif Form.Attendance IS NOT "" OR Form.HospitalityMarks IS NOT "" OR Form.HomeSportsmanshipMarks IS NOT "" OR Form.AwaySportsmanshipMarks IS NOT "">
							<cfinclude template="ErrorMessages/Action/A_TEMP.htm">
							<CFABORT>
						</cfif>
						<cfif Form.AssessmentMarks IS NOT "" 
						OR Form.MatchOfficialsExpenses IS NOT 0 
						OR Form.HomeClubOfficialsBenches IS NOT "" 
						OR Form.AwayClubOfficialsBenches IS NOT ""
						OR Form.StateOfPitch IS NOT ""
						OR Form.ClubFacilities IS NOT ""
						OR Form.Hospitality IS NOT "" >
							<cfinclude template="ErrorMessages/Action/A_TEMP.htm">
							<CFABORT>
						</cfif>
						<cfset Form.HomeGoals = "" >
						<cfset Form.AwayGoals = "" >			
						<cfinclude template="InclUpdtFixture.cfm">
						<cfset ThisDivisionID = DivisionID >
						<cfinclude template="RefreshLeagueTable.cfm">
						<cfinclude template="InclWhence.cfm">
						<CFABORT>
				</CFCASE>
				<CFDEFAULTCASE>
					<cfinclude template="ErrorMessages/Action/FORM_RadioButton_CFDEFAULTCASE.htm">
					<CFABORT>
				</CFDEFAULTCASE>
				
			</CFSWITCH>
			
			
		</CFCASE>
		

		<CFCASE VALUE="Noticeboard">
			<cfinclude template = "queries/upd_UpdtNoticeBoard.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Noticeboard&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>
		
		<CFCASE VALUE="Document">
			<cfinclude template = "queries/upd_UpdtDocument.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Document&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>
		
		<CFCASE VALUE="Committee">
			<cfinclude template="InclCheckCommitteeForm.cfm">
			<cfinclude template="queries/upd_Committee.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Committee&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>

		<CFCASE VALUE="Newsitem">
			<cfinclude template="InclCheckNewsitemForm.cfm">
			<cfinclude template="queries/upd_Newsitem.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Newsitem&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>


		<CFDEFAULTCASE>
			<cfinclude template="check_for_empty.cfm">
			<cfinclude template="check_for_commas_and_quotes.cfm">
			<cfinclude template="queries/upd_QUpdtTblNameRecord.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=#Form.TblName#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
		</CFDEFAULTCASE>
	  </CFSWITCH>
	</CFCASE>
	
	<CFCASE VALUE="Delete">
	
	<!---
																				***********
																				*  DELETE *
																				***********
	--->
		<cfif NOT StructKeyExists(form, "ID") >
			Error! No ID was specified!
			<CFABORT>
		</cfif>
	  <CFSWITCH expression="#TblName#">
	  
		<CFCASE VALUE="Constitution">
			<cfinclude template="queries/del_DelConstit.cfm">
			<cfset ThisDivisionID = DivisionID >
			<cfinclude template="RefreshLeagueTable.cfm">
			<CFLOCATION URL="ConstitList.cfm?TblName=#Form.TblName#&DivisionID=#Form.DivisionID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&ThisMatchNoID=#Form.ThisMatchNoID#&NextMatchNoID=#Form.NextMatchNoID#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>
		
		<CFCASE VALUE="PitchAvailable">
			<cfinclude template="InclDeletePitchAvailable.cfm">
			<CFLOCATION URL="PitchAvailableList.cfm?TblName=#Form.TblName#&VenueID=#Form.VenueID#&PitchNoID=#Form.PitchNoID#&PitchStatusID=#Form.PitchStatusID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&LeagueCode=#Form.LeagueCode#&PA=#Form.ThisPA#&year_to_view=#Year(BookingDate)#&month_to_view=#Month(BookingDate)#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>
		
		<CFCASE VALUE="Team">
				<cfif StructKeyExists(form, "Whence") IS "Yes">
					<cfinclude template="queries/del_DeleteTblName.cfm">
					<cfinclude template="InclWhence.cfm">
					<CFABORT>
				<cfelse>
					<cfinclude template="queries/del_DeleteTblName.cfm">
					<CFLOCATION URL="LUList.cfm?TblName=#Form.TblName#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
					<CFABORT>
				</cfif>
		</CFCASE>
		
		<CFCASE VALUE="Matches">
			<cfinclude template="queries/del_DelFixture.cfm">
			<cfset ThisDivisionID = DivisionID >
			<cfinclude template="RefreshLeagueTable.cfm">
			<cfinclude template="InclWhence.cfm">
			<CFABORT>
		</CFCASE>
		
		
		<CFDEFAULTCASE>
			<cfinclude template="queries/del_DeleteTblName.cfm">
			<cfif StructKeyExists(form, "ws_insert")>
				<!--- do nothing --->
			<cfelse>
				<cflocation url="LUList.cfm?TblName=#Form.TblName#&LeagueCode=#Form.LeagueCode#" addtoken="NO">
				<cfabort>
			</cfif>
		</CFDEFAULTCASE>
	  </CFSWITCH>
	</CFCASE>
	
	<CFCASE VALUE="Add">
	<!---
																			***********
																			*  ADD    *
																			***********
	--->
	
	  <CFSWITCH expression="#TblName#">
	  
		<CFCASE VALUE="Constitution">
			<cfinclude template="InclInsrtConstit.cfm">
			<cfset ThisDivisionID = DivisionID >
			<cfinclude template="RefreshLeagueTable.cfm">
			<CFLOCATION URL="ConstitList.cfm?TblName=#Form.TblName#&DivisionID=#Form.DivisionID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&ThisMatchNoID=#Form.ThisMatchNoID#&NextMatchNoID=#Form.NextMatchNoID#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>
	
		<CFCASE VALUE="Player">
		
			<cfif Form.FANGang IS "1">
				<cfset Form.FAN = Form.ShortCol>
			</cfif>
		
			<cfinclude template="InclCheckPlayerForm.cfm">
			<cfset ThisLeagueID = form.LeagueID >
			<cfinclude template="InclInsrtLookUp.cfm">
			<cfif StructKeyExists(form, "ws_insert")>
				<!--- do nothing --->
			<cfelse>
				<cflocation url="LUList.cfm?TblName=Player&LeagueCode=#Form.LeagueCode#&FirstNumber=#Form.ShortCol#&LastNumber=#Form.ShortCol#" ADDTOKEN="NO">
				<cfabort>
			</cfif>
		</CFCASE>
		
		<CFCASE VALUE="Referee">
			<cfinclude template="InclCheckRefereeForm.cfm">
			<cfinclude template="queries/ins_Referee.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Referee&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<cfabort>
		</CFCASE>
		
		<CFCASE VALUE="Division">
			<cfinclude template="InclCheckDivisionForm.cfm">
			<cfinclude template="queries/qry_DuplicateDivisionFields.cfm">
			<cfif QDuplicateLongCol.RecordCount GT 0>
				<cfinclude template="ErrorMessages/Action/Duplicate_Competition_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif QDuplicateMediumCol.RecordCount GT 0>
				<cfinclude template="ErrorMessages/Action/Duplicate_Sort_Order_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif QDuplicateShortCol.RecordCount GT 0>
				<cfinclude template="ErrorMessages/Action/Duplicate_Competition_Code_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfinclude template="queries/ins_Division.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Division&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>
		
		<CFCASE VALUE="Newsitem">
			<cfinclude template="InclCheckNewsitemForm.cfm">
			<cfinclude template="queries/ins_Newsitem.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Newsitem&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>
		<CFCASE VALUE="Venue">
			<cfinclude template="InclCheckVenueForm.cfm">
			<cfinclude template="queries/ins_Venue.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Venue&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<cfabort>
		</CFCASE>
		
		<CFCASE VALUE="PitchAvailable">
			<cfinclude template="InclInsertPitchAvailable.cfm">
			<CFLOCATION URL="PitchAvailableList.cfm?TblName=#Form.TblName#&VenueID=#Form.VenueID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&PitchNoID=#Form.PitchNoID#&PitchStatusID=#Form.PitchStatusID#&LeagueCode=#Form.LeagueCode#&PA=#Form.ThisPA#&year_to_view=#Year(ThisDate)#&month_to_view=#Month(ThisDate)#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>

		<CFCASE VALUE="Committee">
			<cfinclude template="InclCheckCommitteeForm.cfm">
			<cfinclude template="queries/ins_Committee.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=Committee&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<cfabort>
		</CFCASE>

		<CFCASE VALUE="Team">
			<cfif Trim(UCase(Form.MediumCol)) IS "GUEST">
				<cfinclude template="ErrorMessages/Action/GUEST_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif Form.ShortCol IS NOT "" AND UCase(Form.ShortCol) IS NOT "GUEST">
				<cfinclude template="ErrorMessages/Action/Only_GUEST_or_empty_allowed.htm">
				<CFABORT>
			</cfif>
			<cfinclude template = "check_for_empty.cfm">
			<cfinclude template="check_for_commas_and_quotes.cfm">
			<cfinclude template="InclInsrtLookUp.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=#Form.TblName#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>

		<CFDEFAULTCASE>
			<cfif TblName IS NOT "Noticeboard">
				<cfinclude template = "check_for_empty.cfm">
				<cfinclude template="check_for_commas_and_quotes.cfm">
			</cfif>
			<cfinclude template="InclInsrtLookUp.cfm">
			<CFLOCATION URL="LUList.cfm?TblName=#Form.TblName#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<CFABORT>
		</CFDEFAULTCASE>
	  </CFSWITCH>
	</CFCASE>
	<!---
																			*************
																			*  ADD MANY *
																			*************
	--->
	<CFCASE VALUE="Add many">
	  <CFSWITCH expression="#TblName#">
	  
		<CFCASE VALUE="Player">
		
			<cfif Form.FANGang IS "1">
				<cfset Form.FAN = Form.ShortCol>
			</cfif>
		
			<cfinclude template="InclCheckPlayerForm.cfm">
			<cfset ThisLeagueID = form.LeagueID >
			<cfinclude template="InclInsrtLookUp.cfm">
			<cflocation url="UpdateForm.cfm?TblName=Player&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<cfabort>
		</CFCASE>

		<CFCASE VALUE="Referee">
			<cfinclude template="InclCheckRefereeForm.cfm">
			<cfinclude template="queries/ins_Referee.cfm">
			<CFLOCATION URL="UpdateForm.cfm?TblName=Referee&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<cfabort>
		</CFCASE>
		
		<CFCASE VALUE="Division">
			<cfinclude template="InclCheckDivisionForm.cfm">
			<cfinclude template="queries/qry_DuplicateDivisionFields.cfm">
			<cfif QDuplicateLongCol.RecordCount GT 0>
				<cfinclude template="ErrorMessages/Action/Duplicate_Competition_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif QDuplicateMediumCol.RecordCount GT 0>
				<cfinclude template="ErrorMessages/Action/Duplicate_Sort_Order_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif QDuplicateShortCol.RecordCount GT 0>
				<cfinclude template="ErrorMessages/Action/Duplicate_Competition_Code_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfinclude template="queries/ins_Division.cfm">
			<CFLOCATION URL="UpdateForm.cfm?TblName=Division&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>

		<CFCASE VALUE="Newsitem">
			<cfinclude template="InclCheckNewsitemForm.cfm">
			<cfinclude template="queries/ins_Newsitem.cfm">
			<CFLOCATION URL="UpdateForm.cfm?TblName=Newsitem&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<cfabort>
		</CFCASE>
		
		<CFCASE VALUE="Venue">
			<cfinclude template="InclCheckVenueForm.cfm">
			<cfinclude template="queries/ins_Venue.cfm">
			<CFLOCATION URL="UpdateForm.cfm?TblName=Venue&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<cfabort>
		</CFCASE>
		
		<CFCASE VALUE="Constitution">
			<cfinclude template="InclInsrtConstit.cfm">
			<cfset ThisDivisionID = DivisionID >
			<cfinclude template="RefreshLeagueTable.cfm">
			<CFLOCATION URL="UpdateForm.cfm?TblName=#Form.TblName#&DivisionID=#Form.DivisionID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&ThisMatchNoID=#Form.ThisMatchNoID#&NextMatchNoID=#Form.NextMatchNoID#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>
						
		<CFCASE VALUE="Team">
			<cfif Trim(UCase(Form.MediumCol)) IS "GUEST">
				<cfinclude template="ErrorMessages/Action/GUEST_not_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif Form.ShortCol IS NOT "" AND UCase(Form.ShortCol) IS NOT "GUEST">
				<cfinclude template="ErrorMessages/Action/Only_GUEST_or_empty_allowed.htm">
				<CFABORT>
			</cfif>
			<cfif TblName IS NOT "Noticeboard">
				<cfinclude template = "check_for_empty.cfm">
				<cfinclude template="check_for_commas_and_quotes.cfm">
			</cfif>
			<cfinclude template="InclInsrtLookUp.cfm">
			<CFLOCATION URL="UpdateForm.cfm?TblName=#Form.TblName#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>
		
		<CFDEFAULTCASE>
			<cfinclude template = "check_for_empty.cfm">
			<cfinclude template="check_for_commas_and_quotes.cfm">
			<cfinclude template="InclInsrtLookUp.cfm">
				<CFLOCATION URL="UpdateForm.cfm?TblName=#Form.TblName#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
				<CFABORT>
		</CFDEFAULTCASE>
		
	  </CFSWITCH>
	</CFCASE>
	
	<!---
																			***********
																			*  -ADD-  *
																			***********
	--->
	<CFCASE VALUE="-Add-">
	  <CFSWITCH expression="#TblName#">
		<CFCASE VALUE="PitchAvailable">
			<cfinclude template="InclInsertPitchAvailableAll.cfm">
			<CFLOCATION URL="PitchAvailableList.cfm?TblName=#Form.TblName#&VenueID=#Form.VenueID#&TeamID=#Form.TeamID#&OrdinalID=#Form.OrdinalID#&PitchNoID=#Form.PitchNoID#&PitchStatusID=#Form.PitchStatusID#&LeagueCode=#Form.LeagueCode#&PA=#Form.ThisPA#" ADDTOKEN="NO">
			<CFABORT>
		</CFCASE>
	  </CFSWITCH>
	</CFCASE>

	<!---
																			**************************
																			*  Move to Miscellaneous *
																			**************************
	--->
	<CFCASE VALUE="Move to Miscellaneous">
			<CFLOCATION URL="MoveToMisc.cfm?LeagueCode=#LeagueCode#&FID=#ID#" ADDTOKEN="NO">
			<CFABORT>
	</CFCASE>




	<CFDEFAULTCASE>
		<cfinclude template="ErrorMessages/Action/Final_CFDEFAULTCASE.htm">
		<CFABORT>
	</CFDEFAULTCASE>

</CFSWITCH>
</cfoutput>
