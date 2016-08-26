<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfsilent>
<CFPARAM NAME="TblName">
<cfparam name="Start" default=1>				<!--- Introduce paging Jan. 2001 --->
<cfparam name="FirstNumber" default="">
<cfparam name="LastNumber" default="">
<cfparam name="FirstLetter" default="">	
<cfparam name="Transfer" default="N">	
<cfparam name="Suspended" default="N">
<cfparam name="Unregistered" default="N">
<cfset STRING1=#TblName#>						<!--- e.g. Referee --->
<cfset STRING2=STRING1 & "List">				<!--- e.g. RefereeList --->
<cfset STRING3=STRING2 & ".RecordCount">		<!--- e.g. RefereeList.RecordCount --->
<cfset STRING4=STRING2 & ".ID">					<!--- e.g. RefereeList.ID --->
</cfsilent>
<cfinclude template="InclBegin.cfm">
<cfset CurrRow = 0 >
<CFSWITCH expression="#STRING1#">

	<CFCASE VALUE="Player">

		<!---
													**********
													* Player *
													**********
		--->
			<cfset IgnorePIDList = 0 >
			
			<!--- playerduplicatepairings table - delete all rows for this leaguecode --->
			<cfinclude template="queries/del_Pairings.cfm">
			<!--- Get rid of any suppressed warnings if the player registration numbers are not to be found in the player table --->
			<cfinclude template="queries/del_PlayerDuplicateNoWarnings.cfm">
			<!--- Get rid of all warnings because we are going to look for them each time  --->
			<cfinclude template="queries/del_PlayerDuplicateWarnings.cfm">
			<!---  
			                                  ***************************************************************************** 
				                              * RED WARNING: duplicates of player forename(s), surname and date of birth  *
			                                  ***************************************************************************** 
			--->
			
			<!--- check for duplicate combinations of player surname, forename and date of birth --->
			<cfinclude template="queries/qry_QSamePlayer3.cfm">
			<cfif QSamePlayer3.RecordCount GT 0>
				<cfoutput query="QSamePlayer3">
				<!--- 
				for each instance of duplicates, create a temporary table of player IDs
				We need this to do a Cartesian join to get all the combinations of PIDs
				--->
					<cfif mediumcol IS ''>
						<cfinclude template="queries/ins_PlayerDuplicatePairingsID3A.cfm">
					<cfelse>
						<cfinclude template="queries/ins_PlayerDuplicatePairingsID3B.cfm">
					</cfif>
					<!---
					Cartesian join to get all combinations
					Note that the lower PID is always first in each pairing
					--->
					<cfinclude template="queries/qry_QPairings.cfm">		
					<cfloop query="QPairings">
						<cfinclude template="queries/qry_QDuplicatePlayer.cfm">
						<!--- Remember these players who are in the RED section because we don't want check them again in ORANGE or YELLOW sections --->
						<cfset IgnorePIDList = ListAppend(IgnorePIDList, #QDuplicatePlayer.PID1#)>
						<cfset IgnorePIDList = ListAppend(IgnorePIDList, #QDuplicatePlayer.PID2#)>
						<cfset ThisRegNo1 = #QDuplicatePlayer.RegNo1#>								
						<cfset ThisRegNo2 = #QDuplicatePlayer.RegNo2#>								
						<!--- insert details of the warning into playerduplicatewarnings table --->
						<cfinclude template="queries/ins_PlayerDuplicateWarning1.cfm">
					</cfloop>
					<cfinclude template="queries/del_Pairings.cfm">
				</cfoutput>
				<!--- check to see if there are any RED warnings and report them on screen --->
				<cfinclude template="queries/qry_QPlayerDuplicateWarning1.cfm">
				<cfif QPlayerDuplicateWarning1.RecordCount GT 0>
					<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" >
						<tr bgcolor="red">
							<td height="20" <cfif ListFind("Silver",request.SecurityLevel) >colspan="9"<cfelse>colspan="8"</cfif> align="center">
								<span class="pix24boldwhite">SERIOUS ERROR: Duplicate Forename(s), Surname and Date of Birth</span>
							</td>
						</tr>
						<tr bgcolor="ivory">
						
							<cfif ListFind("Silver",request.SecurityLevel) >
								<td align="center"><span class="pix10bold">JAB Only</span></td>
							</cfif>								


							<td align="center"><span class="pix10bold">Forename(s)</span></td>
							<td align="center"><span class="pix10bold">Surname</span></td>
							<td align="center"><span class="pix10">Player</span></td>
							<td align="center"><span class="pix10">Appearances</span></td>
							<td align="center"><span class="pix10">Date of Birth [Age]</span></td>
							<td align="center"><span class="pix10">Reg. No.</span></td>
							<td align="center"><span class="pix10">Registration</span></td>
							<td align="center"><span class="pix10">Address and <em>Notes</em></span></td>
						</tr>
						<cfoutput query="QPlayerDuplicateWarning1">
							<cfset ThisRegNo1 = RegNo1 >
							<cfset ThisRegNo2 = RegNo2 >
							<!--- using both registration numbers get both player rows that correspond --->
							<cfinclude template="queries/qry_QDuplicatePlayer1.cfm">
							<tr bgcolor="white">
								<cfif ListFind("Silver",request.SecurityLevel) >
									<td height="60" rowspan="2" align="center" >
										<a href="MergeDuplicatePlayers.cfm?LeagueCode=#LeagueCode#&PlayerID1=#QDuplicatePlayer1.PID1#&PlayerID2=#QDuplicatePlayer1.PID2#"><span class="pix10boldred">MERGE(1,2)</span></a>
										<a href="MergeDuplicatePlayers.cfm?LeagueCode=#LeagueCode#&PlayerID1=#QDuplicatePlayer1.PID2#&PlayerID2=#QDuplicatePlayer1.PID1#"><span class="pix10boldred">MERGE(2,1)</span></a>
									</td>							
								</cfif>								
							<!--- Forename(s) same for both --->
								<td align="center" height="60" rowspan="2"><span class="pix10bold">#QDuplicatePlayer1.Forename1#</span></td>
							<!--- Surname same for both --->
								<td align="center" height="60" rowspan="2"><span class="pix10bold">#QDuplicatePlayer1.Surname1#</span></td>
							<!--- get the row from the register table for the first player of the pair  --->
								<cfset ThisPID = #QDuplicatePlayer1.PID1# >
								<cfinclude template="queries/qry_GetRegistrationInfo.cfm">
								
								<td align="center"><span class="pix10"><a href="UpdateForm.cfm?TblName=Player&ID=#ThisPID#&LeagueCode=#LeagueCode#"><u>Upd/Del</u></a></span></td>
								<td align="center"><cfif GetAppearanceInfo.NumberOfAppearances GT 0><span class="pix18boldblack">#GetAppearanceInfo.NumberOfAppearances# </span><a href="PlayersHist.cfm?PI=#ThisPID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>see</u></span></a><cfelse><span class="pix10">-</span></cfif></td>
								<td align="center" height="60" rowspan="2"><span class="pix10bold">&nbsp;#Dateformat(QDuplicatePlayer1.DOB1, 'DD MMM YYYY')#&nbsp;<cfif IsDate(QDuplicatePlayer1.DOB1)> [#DateDiff("YYYY",QDuplicatePlayer1.DOB1, Now())#]</cfif></span>
								<td align="center"><span class="pix10">#ThisRegNo1#</span></td>
								<cfif GetRegistrationInfo.RecordCount GT 1>
									<td align="left">
										<cfset Countr = 0>
										<cfloop query="GetRegistrationInfo">
											<cfif Countr GT 0><br></cfif>
											<cfset Countr = Countr + 1 >
											<cfif GetRegistrationInfo.ClubName IS ''>
												 <span class="pix10">unregistered</span> 
											<cfelse>
												 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
											</cfif>
										</cfloop>
									</td>
								<cfelse>
									<td align="left">
										<cfif GetRegistrationInfo.ClubName IS ''>
											 <span class="pix10">unregistered</span> 
										<cfelse>
											 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
										</cfif>
									</td>
								</cfif>
								<td>
									<span class="pix10">
										<!--- applies to season 2012 onwards only --->
										<cfif RIGHT(request.dsn,4) GE 2012>
											#QDuplicatePlayer1.AddressLine11#&nbsp;&##8226;&nbsp;#QDuplicatePlayer1.AddressLine12#&nbsp;&##8226;&nbsp;#QDuplicatePlayer1.AddressLine13#&nbsp;&##8226;&nbsp;#QDuplicatePlayer1.Postcode1#<br>
										</cfif>
										
										<cfif QDuplicatePlayer1.Notes1 IS ''>&nbsp;<cfelse><em>#QDuplicatePlayer1.Notes1#</em></cfif>
									</span>
								</td>
							</tr>
								
							<tr bgcolor="white">
							<!--- get the row from the register table for the second  player of the pair  --->
								<cfset ThisPID = #QDuplicatePlayer1.PID2# >
								<cfinclude template="queries/qry_GetRegistrationInfo.cfm">
								<td align="center"><span class="pix10"><a href="UpdateForm.cfm?TblName=Player&ID=#ThisPID#&LeagueCode=#LeagueCode#"><u>Upd/Del</u></a></span></td>
								<td align="center"><cfif GetAppearanceInfo.NumberOfAppearances GT 0><span class="pix18boldblack">#GetAppearanceInfo.NumberOfAppearances# </span><a href="PlayersHist.cfm?PI=#ThisPID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>see</u></span></a><cfelse><span class="pix10">-</span></cfif></td>
								<td align="center"><span class="pix10">#ThisRegNo2#</span></td>
								
								<cfif GetRegistrationInfo.RecordCount GT 1>
									<td align="left">
										<cfset Countr = 0>
										<cfloop query="GetRegistrationInfo">
											<cfif Countr GT 0><br></cfif>
											<cfset Countr = Countr + 1 >
											<cfif GetRegistrationInfo.ClubName IS ''>
												 <span class="pix10">unregistered</span> 
											<cfelse>
												 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
											</cfif>
										</cfloop>
									</td>
								<cfelse>
									<td align="left">
										<cfif GetRegistrationInfo.ClubName IS ''>
											 <span class="pix10">unregistered</span> 
										<cfelse>
											 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
										</cfif>
									</td>
								</cfif>
								
								
								<td>
									<span class="pix10">
										<!--- applies to season 2012 onwards only --->
										<cfif RIGHT(request.dsn,4) GE 2012>
											#QDuplicatePlayer1.AddressLine21#&nbsp;&##8226;&nbsp;#QDuplicatePlayer1.AddressLine22#&nbsp;&##8226;&nbsp;#QDuplicatePlayer1.AddressLine23#&nbsp;&##8226;&nbsp;#QDuplicatePlayer1.Postcode2#<br>
										</cfif>
										
										<cfif QDuplicatePlayer1.Notes2 IS ''>&nbsp;<cfelse><em>#QDuplicatePlayer1.Notes2#</em></cfif>
									</span>
								</td>
							</tr>
							
							<tr bgcolor="ivory">
								<td height="3" colspan="9"></td>
							</tr>
								
						</cfoutput>
						<tr bgcolor="red">
							<td colspan="9" align="left"><span class="pix18boldwhite">STOP! This is serious.
							It is most likely that the players are the same person. <br>
							Please delete one of them in each pair. 
							Please contact INSERT_EMAIL_HERE if you have problems.<br></span>
							</td>
						</tr>
					</table>
				</cfif>
			</cfif>


			<!---  
			                                  *********************************************************************** 
				                              * ORANGE  WARNING: duplicates of player forename(s) and date of birth *
			                                  *********************************************************************** 
			--->
			<cfinclude template="queries/del_Pairings.cfm">
			<!--- check for duplicate combinations of player forename and date of birth --->
			<cfinclude template="queries/qry_QSamePlayer2A.cfm">
			<cfif QSamePlayer2A.RecordCount GT 0>
				<cfoutput query="QSamePlayer2A">
				<!--- 
				for each instance of duplicates, create a temporary table of player IDs
				We need this to do a Cartesian join to get all the combinations of PIDs
				--->
					<cfinclude template="queries/ins_PlayerDuplicatePairingsID2A.cfm">
					<!---
					Cartesian join to get all combinations.	Note that the lower PID is always first in each pairing
					--->
					<cfinclude template="queries/qry_QPairings.cfm">
					<cfloop query="QPairings">
						<cfinclude template="queries/qry_QDuplicatePlayer.cfm">
						<cfset ThisRegNo1 = #QDuplicatePlayer.RegNo1#>								
						<cfset ThisRegNo2 = #QDuplicatePlayer.RegNo2#>								
						<!--- insert details of the warning into playerduplicatewarnings table --->
						<cfinclude template="queries/ins_PlayerDuplicateWarning2.cfm">
					</cfloop>
					<cfinclude template="queries/del_Pairings.cfm">
				</cfoutput>
				<!--- check to see if there are any ORANGE warnings and report them on screen --->
				<cfinclude template="queries/qry_QPlayerDuplicateWarning2.cfm">
				<cfif QPlayerDuplicateWarning2.RecordCount GT 0>
					<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" >
						<tr bgcolor="orange">
							<td height="20" colspan="9" align="center">
								<span class="pix18bold">WARNING: Duplicate Forename(s) and Date of Birth</span>
							</td>
						</tr>
						<tr bgcolor="ivory">
							<td align="center" bgcolor="orange"><span class="pix10bold">Ignore<br>Warning?</span></td>
							<td align="center"><span class="pix10bold">Forename(s)</span></td>
							<td align="center"><span class="pix10bold">Surname</span></td>
							<td align="center"><span class="pix10">Player</span></td>
							<td align="center"><span class="pix10">Appearances</span></td>
							<td align="center"><span class="pix10">Date of Birth [Age]</span></td>
							<td align="center"><span class="pix10">Reg. No.</span></td>
							<td align="center"><span class="pix10">Registration</span></td>
							<td align="center"><span class="pix10">Address and <em>Notes</em></span></td>
						</tr>
						<cfoutput query="QPlayerDuplicateWarning2">
							<cfset ThisRegNo1 = RegNo1 >
							<cfset ThisRegNo2 = RegNo2 >
							<!--- using both registration numbers get both player rows that correspond --->
							<cfinclude template="queries/qry_QDuplicatePlayer2.cfm">
							<tr bgcolor="white">
							<!--- OK --->
								<td height="60" rowspan="2" align="center" bgcolor="orange"><a href="PlayerDuplicateNoWarning2.cfm?LeagueCode=#LeagueCode#&RegNo1=#ThisRegNo1#&RegNo2=#ThisRegNo2#"><span class="pix10bold">OK</span></a></td>
							<!--- Forename(s) same for both --->
								<td align="center" height="60" rowspan="2"><span class="pix10bold">#QDuplicatePlayer2.Forename1#</span></td>
							<!--- Surname 1 --->
								<td align="center"><span class="pix10bold">#QDuplicatePlayer2.Surname1#</span></td>
							<!--- get the row from the register table for the first player of the pair  --->
								<cfset ThisPID = #QDuplicatePlayer2.PID1# >
								<cfinclude template="queries/qry_GetRegistrationInfo.cfm">
								<td align="center"><span class="pix10"><a href="UpdateForm.cfm?TblName=Player&ID=#ThisPID#&LeagueCode=#LeagueCode#"><u>Upd/Del</u></a></span></td>
								<td align="center"><cfif GetAppearanceInfo.NumberOfAppearances GT 0><span class="pix18boldblack">#GetAppearanceInfo.NumberOfAppearances# </span><a href="PlayersHist.cfm?PI=#ThisPID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>see</u></span></a><cfelse><span class="pix10">-</span></cfif></td>
								<td align="center" height="60" rowspan="2"><span class="pix10bold">&nbsp;#Dateformat(QDuplicatePlayer2.DOB1, 'DD MMM YYYY')#&nbsp;<cfif IsDate(QDuplicatePlayer2.DOB1)> [#DateDiff("YYYY",QDuplicatePlayer2.DOB1, Now())#]</cfif></span>
								<td align="center"><span class="pix10">#ThisRegNo1#</span></td>
								<cfif GetRegistrationInfo.RecordCount GT 1>
									<td align="left">
										<cfset Countr = 0>
										<cfloop query="GetRegistrationInfo">
											<cfif Countr GT 0><br></cfif>
											<cfset Countr = Countr + 1 >
											<cfif GetRegistrationInfo.ClubName IS ''>
												 <span class="pix10">unregistered</span> 
											<cfelse>
												 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
											</cfif>
										</cfloop>
									</td>
								<cfelse>
									<td align="left">
										<cfif GetRegistrationInfo.ClubName IS ''>
											 <span class="pix10">unregistered</span> 
										<cfelse>
											 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
										</cfif>
									</td>
								</cfif>
								<td>
									<span class="pix10">
										<!--- applies to season 2012 onwards only --->
										<cfif RIGHT(request.dsn,4) GE 2012>
											#QDuplicatePlayer2.AddressLine11#&nbsp;&##8226;&nbsp;#QDuplicatePlayer2.AddressLine12#&nbsp;&##8226;&nbsp;#QDuplicatePlayer2.AddressLine13#&nbsp;&##8226;&nbsp;#QDuplicatePlayer2.Postcode1#<br>
										</cfif>
										
										<cfif QDuplicatePlayer2.Notes1 IS ''>&nbsp;<cfelse><em>#QDuplicatePlayer2.Notes1#</em></cfif>
									</span>
								</td>
							</tr>
								
							<tr bgcolor="white">
							<!--- Surname 2 --->
								<td align="center"><span class="pix10bold">#QDuplicatePlayer2.Surname2#</span></td>
							<!--- get the row from the register table for the second  player of the pair  --->
								<cfset ThisPID = #QDuplicatePlayer2.PID2# >
								<cfinclude template="queries/qry_GetRegistrationInfo.cfm">
								<td align="center"><span class="pix10"><a href="UpdateForm.cfm?TblName=Player&ID=#ThisPID#&LeagueCode=#LeagueCode#"><u>Upd/Del</u></a></span></td>
								<td align="center"><cfif GetAppearanceInfo.NumberOfAppearances GT 0><span class="pix18boldblack">#GetAppearanceInfo.NumberOfAppearances# </span><a href="PlayersHist.cfm?PI=#ThisPID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>see</u></span></a><cfelse><span class="pix10">-</span></cfif></td>
								<td align="center"><span class="pix10">#ThisRegNo2#</span></td>
								<cfif GetRegistrationInfo.RecordCount GT 1>
									<td align="left">
										<cfset Countr = 0>
										<cfloop query="GetRegistrationInfo">
											<cfif Countr GT 0><br></cfif>
											<cfset Countr = Countr + 1 >
											<cfif GetRegistrationInfo.ClubName IS ''>
												 <span class="pix10">unregistered</span> 
											<cfelse>
												 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
											</cfif>
										</cfloop>
									</td>
								<cfelse>
									<td align="left">
										<cfif GetRegistrationInfo.ClubName IS ''>
											 <span class="pix10">unregistered</span> 
										<cfelse>
											 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
										</cfif>
									</td>
								</cfif>
								<td>
									<span class="pix10">
										<!--- applies to season 2012 onwards only --->
										<cfif RIGHT(request.dsn,4) GE 2012>
											#QDuplicatePlayer2.AddressLine21#&nbsp;&##8226;&nbsp;#QDuplicatePlayer2.AddressLine22#&nbsp;&##8226;&nbsp;#QDuplicatePlayer2.AddressLine23#&nbsp;&##8226;&nbsp;#QDuplicatePlayer2.Postcode2#<br>
										</cfif>
										
										<cfif QDuplicatePlayer2.Notes2 IS ''>&nbsp;<cfelse><em>#QDuplicatePlayer2.Notes2#</em></cfif>
									</span>
								</td>
							</tr>
							
							<tr bgcolor="ivory">
								<td height="3" colspan="9"></td>
							</tr>
								
						</cfoutput>
						<tr bgcolor="orange">
							<td colspan="9" align="left"><span class="pix13bold">If the surnames are similar this may be a duplication otherwise if the surnames are different the players are probably different people.</span></td>
						</tr>
					</table>
				</cfif>
			</cfif>


			<!---  
			                                  ******************************************************************* 
				                              * YELLOW WARNING: duplicates of player surname and date of birth  *
			                                  ******************************************************************* 
			--->
			<cfinclude template="queries/del_Pairings.cfm">
			<!--- check for duplicate combinations of player surname and date of birth --->
			<cfinclude template="queries/qry_QSamePlayer2B.cfm">
			<cfif QSamePlayer2B.RecordCount GT 0>
				<cfoutput query="QSamePlayer2B">
				<!--- 
				for each instance of duplicates, create a temporary table of player IDs
				We need this to do a Cartesian join to get all the combinations of PIDs
				--->
					<cfinclude template="queries/ins_PlayerDuplicatePairingsID2B.cfm">
					<!---
					Cartesian join to get all combinations.	Note that the lower PID is always first in each pairing
					--->
					<cfinclude template="queries/qry_QPairings.cfm">
					<cfloop query="QPairings">
						<cfinclude template="queries/qry_QDuplicatePlayer.cfm">
						<cfset ThisRegNo1 = #QDuplicatePlayer.RegNo1#>								
						<cfset ThisRegNo2 = #QDuplicatePlayer.RegNo2#>
						<!--- insert details of the warning into playerduplicatewarnings table --->
						<cfinclude template="queries/ins_PlayerDuplicateWarning3.cfm">
					</cfloop>
					<cfinclude template="queries/del_Pairings.cfm">
				</cfoutput>
				<!--- check to see if there are any YELLOW warnings and report them on screen --->
				<cfinclude template="queries/qry_QPlayerDuplicateWarning3.cfm">
				
				<cfif QPlayerDuplicateWarning3.RecordCount GT 0>
					<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" >
						<tr bgcolor="yellow">
							<td height="20" colspan="9" align="center">
								<span class="pix18bold">WARNING: Duplicate Surname and Date of Birth</span>
							</td>
						</tr>
						<tr bgcolor="ivory">
							<td align="center" bgcolor="yellow"><span class="pix10bold">Ignore<br>Warning?</span></td>
							<td align="center"><span class="pix10bold">Forename(s)</span></td>
							<td align="center"><span class="pix10bold">Surname</span></td>
							<td align="center"><span class="pix10">Player</span></td>
							<td align="center"><span class="pix10">Appearances</span></td>
							<td align="center"><span class="pix10">Date of Birth [Age]</span></td>
							<td align="center"><span class="pix10">Reg. No.</span></td>
							<td align="center"><span class="pix10">Registration</span></td>
							<td align="center"><span class="pix10">Address and <em>Notes</em></span></td>
						</tr>
						<cfoutput query="QPlayerDuplicateWarning3">
							<cfset ThisRegNo1 = RegNo1 >
							<cfset ThisRegNo2 = RegNo2 >
							<!--- using both registration numbers get both player rows that correspond --->
							<cfinclude template="queries/qry_QDuplicatePlayer3.cfm">
							<tr bgcolor="white">
							<!--- OK --->
								<td height="60" rowspan="2" align="center" bgcolor="yellow"><a href="PlayerDuplicateNoWarning3.cfm?LeagueCode=#LeagueCode#&RegNo1=#ThisRegNo1#&RegNo2=#ThisRegNo2#"><span class="pix10bold">OK</span></a></td>
							<!--- Forename(s) 1 --->
								<td align="center"><span class="pix10bold">#QDuplicatePlayer3.Forename1#</span></td>
							<!--- Surname same for both --->
								<td align="center" height="60" rowspan="2"><span class="pix10bold">#QDuplicatePlayer3.Surname1#</span></td>
							<!--- get the row from the register table for the first player of the pair  --->
								<cfset ThisPID = #QDuplicatePlayer3.PID1# >
								<cfinclude template="queries/qry_GetRegistrationInfo.cfm">
								<td align="center"><span class="pix10"><a href="UpdateForm.cfm?TblName=Player&ID=#ThisPID#&LeagueCode=#LeagueCode#"><u>Upd/Del</u></a></span></td>
								<td align="center"><cfif GetAppearanceInfo.NumberOfAppearances GT 0><span class="pix18boldblack">#GetAppearanceInfo.NumberOfAppearances# </span><a href="PlayersHist.cfm?PI=#ThisPID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>see</u></span></a><cfelse><span class="pix10">-</span></cfif></td>
								<td align="center" height="60" rowspan="2"><span class="pix10bold">&nbsp;#Dateformat(QDuplicatePlayer3.DOB1, 'DD MMM YYYY')#&nbsp;<cfif IsDate(QDuplicatePlayer3.DOB1)> [#DateDiff("YYYY",QDuplicatePlayer3.DOB1, Now())#]</cfif></span>
								<td align="center"><span class="pix10">#ThisRegNo1#</span></td>
								<cfif GetRegistrationInfo.RecordCount GT 1>
									<td align="left">
										<cfset Countr = 0>
										<cfloop query="GetRegistrationInfo">
											<cfif Countr GT 0><br></cfif>
											<cfset Countr = Countr + 1 >
											<cfif GetRegistrationInfo.ClubName IS ''>
												 <span class="pix10">unregistered</span> 
											<cfelse>
												 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
											</cfif>
										</cfloop>
									</td>
								<cfelse>
									<td align="left">
										<cfif GetRegistrationInfo.ClubName IS ''>
											 <span class="pix10">unregistered</span> 
										<cfelse>
											 <a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span>
										</cfif>
									</td>
								</cfif>
								<td>
									<span class="pix10">
										<!--- applies to season 2012 onwards only --->
										<cfif RIGHT(request.dsn,4) GE 2012>
											#QDuplicatePlayer3.AddressLine11#&nbsp;&##8226;&nbsp;#QDuplicatePlayer3.AddressLine12#&nbsp;&##8226;&nbsp;#QDuplicatePlayer3.AddressLine13#&nbsp;&##8226;&nbsp;#QDuplicatePlayer3.Postcode1#<br>
										</cfif>
										
										<cfif QDuplicatePlayer3.Notes1 IS ''>&nbsp;<cfelse><em>#QDuplicatePlayer3.Notes1#</em></cfif>
									</span>
								</td>
							</tr>
								
							<tr bgcolor="white">
							<!--- Forename(s) 2 --->
								<td align="center"><span class="pix10bold">#QDuplicatePlayer3.Forename2#</span></td>
							<!--- get the row from the register table for the second  player of the pair  --->
								<cfset ThisPID = #QDuplicatePlayer3.PID2# >
								<cfinclude template="queries/qry_GetRegistrationInfo.cfm">
								<td align="center"><span class="pix10"><a href="UpdateForm.cfm?TblName=Player&ID=#ThisPID#&LeagueCode=#LeagueCode#"><u>Upd/Del</u></a></span></td>
								<td align="center"><cfif GetAppearanceInfo.NumberOfAppearances GT 0><span class="pix18boldblack">#GetAppearanceInfo.NumberOfAppearances# </span><a href="PlayersHist.cfm?PI=#ThisPID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>see</u></span></a><cfelse><span class="pix10">-</span></cfif></td>
								<td align="center"><span class="pix10">#ThisRegNo2#</span></td>
								<cfif GetRegistrationInfo.ClubName IS ''>
									<td><span class="pix10">unregistered</span></td>
								<cfelse>
									<td align="left"><a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> from #DateFormat(GetRegistrationInfo.FirstDay,'DD MMMM YYYY')# <cfif GetRegistrationInfo.LastDay IS '2999-12-31'><cfelse>to #DateFormat(GetRegistrationInfo.LastDay,'DD MMMM YYYY')#</cfif> <cfif GetRegistrationInfo.RecordCount GT 0><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#GetRegistrationInfo.RID#"><u>Upd/Del</u></a></cfif></span></td>
								</cfif>
								<td>
									<span class="pix10">
										<!--- applies to season 2012 onwards only --->
										<cfif RIGHT(request.dsn,4) GE 2012>
											#QDuplicatePlayer3.AddressLine21#&nbsp;&##8226;&nbsp;#QDuplicatePlayer3.AddressLine22#&nbsp;&##8226;&nbsp;#QDuplicatePlayer3.AddressLine23#&nbsp;&##8226;&nbsp;#QDuplicatePlayer3.Postcode2#<br>
										</cfif>
										
										<cfif QDuplicatePlayer3.Notes2 IS ''>&nbsp;<cfelse><em>#QDuplicatePlayer3.Notes2#</em></cfif>
									</span>
								</td>
							</tr>
							
							<tr bgcolor="ivory">
								<td height="3" colspan="9"></td>
							</tr>
						</cfoutput>
						<tr bgcolor="yellow">
							<td colspan="9" align="left"><span class="pix13bold">If the forenames are similar this may be a duplication otherwise if the forenames are different the players are probably twins.</span></td>
						</tr>
					</table>
				</cfif>
			</cfif>

		<!--- get rid of any unused registrations --->
		<cfinclude template = "queries/del_QDeleteAllEmptyRegistration.cfm">
		<cfinclude template="queries/qry_QRegNos0.cfm">
		<cfif QRegNos0.RecordCount IS 1>
		<cfelse>
			<!--- if the Own Goal record is missing then insert it --->
			<cfinclude template="queries/ins_OwnGoal.cfm">
			<cfmail to="INSERT_EMAIL_HERE" from="INSERT_EMAIL_HERE" subject="Own Goal - Player record missing, now inserted" type="text">#LeagueCode#</cfmail>
		</cfif>
		<cfinclude template="queries/qry_QRegNos.cfm">
		<cfset RegNoList=ValueList(QRegNos.RegNo)>
		<cfinclude template="queries/qry_QPlayersCount.cfm">
		<cfinclude template="queries/qry_QRegPlayersCount.cfm">
		<cfinclude template="queries/qry_QUnregisteredPlayersCount.cfm">
		<cfinclude template="queries/qry_QSuspendedPlayersCount.cfm">
		<cfinclude template="queries/qry_QFirstLetterPlayersCount.cfm">
		<cfif IsNumeric(FirstNumber)>
			<cfinclude template="queries/qry_QFirstNumberPlayersCount.cfm">
		</cfif>
		<cfinclude template="queries/qry_PlayerList_v1.cfm"> 
	</CFCASE>

	<CFCASE VALUE="Committee">
		<cfinclude template="queries/qry_CommitteeList.cfm">
	</CFCASE>

	<CFCASE VALUE="Division">
		<cfinclude template="queries/qry_DivisionList.cfm">
	</CFCASE>

	<CFCASE VALUE="KORound">
		<cfinclude template="queries/qry_KORoundList.cfm">
	</CFCASE>

	<CFCASE VALUE="MatchReport">
		<cfinclude template="queries/qry_MatchReportList.cfm">
	</CFCASE>

	<CFCASE VALUE="NewsItem">
		<cfinclude template="queries/qry_NewsItemList.cfm">
	</CFCASE>

	<CFCASE VALUE="Ordinal">
		<cfinclude template="queries/qry_OrdinalList.cfm">
	</CFCASE>
	
 	<CFCASE VALUE="Referee" >
			<cfinclude template="queries/qry_RefereeList.cfm">
			<cfinclude template="queries/qry_DuplicateReferees.cfm">
	</CFCASE>

	<CFCASE VALUE="Team">
		<cfif VenueAndPitchAvailable IS "Yes" >
			<cfinclude template="queries/qry_QTeamNormalVenue.cfm">
			<cfif QTeamNormalVenue.RecordCount GT 0 >
			<hr>
			<table width="40%" border="0" align="center" cellpadding="0" cellspacing="2" class="loggedinScreen">
				<tr>
					<td colspan="2"><span class="pix24boldred">WARNING:</span><br>
					<span class="pix18boldred">These teams need to have their Normal Venue specified:<br>&nbsp;</span></td>
				</tr>	
				<cfoutput query="QTeamNormalVenue">
					<tr>
						<td height="24"><span class="pix13boldred">#teamname#</span></td>
						<td><a href="TeamDetailsUpdate.cfm?LeagueCode=#LeagueCode#&TID=#ThisTeamID#&OID=#ThisOrdinalID#"><span class="pix13">Specify Normal Venue</span></a></td>
					</tr>	
				</cfoutput>
			</table>
			</cfif>
		</cfif>
	
		<cfinclude template="queries/qry_TeamList.cfm">
	</CFCASE>

	<CFCASE VALUE="Noticeboard">
	<!---
												*************************************************
												* Noticeboard - only 
												 has access to this  *
												*************************************************
	--->											
		<cfinclude template="queries/qry_NoticeboardList.cfm">
		<cfset STRING3="NoticeboardList.RecordCount">
	</CFCASE>
	
	<CFCASE VALUE="Document">
	<!---
												**********************************************
												* Document - only 
												 has access to this  *
												**********************************************
	--->											
		<cfinclude template="queries/qry_DocumentList.cfm">
		<cfset STRING3="DocumentList.RecordCount">
		<cfset FileNameList = ValueList(DocumentList.FileName,"|")>
	</CFCASE>
	
	<CFCASE VALUE="Venue">
	<!---
												**********
												* Venue  *
												**********
	--->	
		<cfif VenueAndPitchAvailable IS "Yes" >
			<cfinclude template="queries/qry_QTeamNormalVenue.cfm">
			<cfif QTeamNormalVenue.RecordCount GT 0 >
			<hr>
			<table width="40%" border="0" align="center" cellpadding="0" cellspacing="2" class="loggedinScreen">
				<tr>
					<td colspan="2"><span class="pix24boldred">WARNING:</span><br>
					<span class="pix18boldred">These teams need to have their Normal Venue specified:<br>&nbsp;</span></td>
				</tr>	
				<cfoutput query="QTeamNormalVenue">
					<tr>
						<td height="24"><span class="pix13boldred">#teamname#</span></td>
						<td><a href="TeamDetailsUpdate.cfm?LeagueCode=#LeagueCode#&TID=#ThisTeamID#&OID=#ThisOrdinalID#"><span class="pix13">Specify Normal Venue</span></a></td>
					</tr>	
				</cfoutput>
			</table>
			</cfif>
		</cfif>
											
		<cfinclude template="queries/qry_VenueList.cfm">
	</CFCASE>
	
	<CFCASE VALUE="Rule">
	<!---
												**********
												* Rule   *
												**********
	--->											
		<cfinclude template="queries/qry_RuleList.cfm">
	</CFCASE>
	
	<CFDEFAULTCASE>
		DefaultCase reached in LUList.cfm
		<CFABORT>
	</CFDEFAULTCASE>
</CFSWITCH>

	

<cfset STRING5=#Evaluate(STRING3)#>

<cfif STRING5 IS 0 AND String1 IS NOT "Player">      <!--- e.g. IF DivisionList.RecordCount is 0 --->
	<cfoutput>
	<span class="pix13">
	<!---
	<cfif FirstNumber IS NOT "">
		No #STRING1#s with Reg. Nos. between #FirstNumber# and #LastNumber#	
	<cfelseif FirstLetter IS NOT "">
		No #STRING1#s found with surname beginning with #FirstLetter#
	<cfelseif Transfer IS "Y">
		No lapsed or pending registrations
	<cfelseif Suspended IS "Y">
		No suspensions
	<cfelseif Unregistered IS "Y">
		No unregistered players
	--->
	<cfif String1 IS "Committee">
		No Contacts found - try adding some first!
	<cfelse>
		 No #STRING1#s found - try adding some first!
	</cfif>
	<BR>
	</span>
	</cfoutput>
<cfelse>
	<!--- Warn if there are any duplicate referees --->
	<cfif STRING1 IS "Referee" AND QDuplicateReferees.RecordCount GT 0>
		<cfoutput query="QDuplicateReferees">
			<span class="pix24boldred">ERROR: #forename# #surname# appears #counter# times<br></span>
		</cfoutput>
		<span class="pix18boldred"><br>DELETE the duplicate which has no history, otherwise contact 
		 to merge them<br></span>
	</cfif>
	<!--- Warn if there are any duplicate surname & initial --->
	<cfif STRING1 IS "Referee" AND QDuplicateSurnameInitial.RecordCount GT 0>
		<cfoutput query="QDuplicateSurnameInitial">
			<span class="pix24boldred">WARNING: #Left(forename,1)#. #surname# appears #counter# times<br></span>
		</cfoutput>
		<span class="pix18boldred"><br>Enter what you want the public to see in the 4th box to solve this problem.<br></span>
	</cfif>
	<cfoutput>
	<span class="pix13bold">
	<cfif STRING1 IS "Player" AND FirstNumber IS NOT "">
		#QFirstNumberPlayersCount.cnt# players with Reg. Nos. between #FirstNumber# and #LastNumber#
	<cfelseif STRING1 IS "Player" AND FirstLetter IS "O"> <!--- ignore OwnGoal in the count --->
		#QFirstLetterPlayersCount.cnt-1# players with surname beginning with O
	<cfelseif STRING1 IS "Player" AND FirstLetter IS NOT "">
		#QFirstLetterPlayersCount.cnt# players with surname beginning with #FirstLetter#
	<cfelseif STRING1 IS "Player" AND Transfer IS "Y">
		#PlayerList.RecordCount# registrations relating to #MultipleRegistrations.RecordCount# players.
	<cfelseif STRING1 IS "Player" AND Unregistered IS "Y">
		#QUnregisteredPlayersCount.cnt# unregistered players
	<cfelseif STRING1 IS "Player" AND Suspended IS "Y">
	    #QSuspendedPlayersCount.cnt1# suspensions relating to #QSuspendedPlayersCount.cnt2# players.
	<cfelseif STRING1 IS "Player" AND Suspended IS "MB">
	<cfelseif STRING1 IS "Player">
		#QPlayersCount.cnt# players
	<cfelse>
		#STRING5# #STRING1#s <!--- e.g. will display "3 divisions" --->
	</cfif>
	</span>
	</cfoutput>
</cfif>

<cfif STRING1 IS "Player" AND Suspended IS "Y">
	<cfset MaxRows = 50 >
<cfelseif STRING1 IS "Player" AND Suspended IS "MB">
	<cfset MaxRows = 5000 >
<cfelseif STRING1 IS "Player" AND Transfer IS "Y">
	<cfset MaxRows = 3000 >	
<cfelseif STRING1 IS "Player" AND Unregistered IS "Y">
	<cfset MaxRows = 50 >
<cfelseif STRING1 IS "Player" AND FirstLetter IS "" AND FirstNumber IS "">
	<cfset MaxRows = 50 >
<cfelseif STRING1 IS "Player" AND FirstLetter IS NOT "">
	<cfset MaxRows = 50 >
<cfelseif STRING1 IS "Player" AND FirstNumber IS NOT "">
	<cfset MaxRows = 50 >
<cfelse>
	<cfset MaxRows = 3000 >
</cfif>


<table width="100%" border="0" cellspacing="2" cellpadding="0" class="loggedinScreen">
	<cfoutput>
		<cfif STRING1 IS "Player" >
		
			<cfset lastN = ListLen(RegNoList)>
			<cfset stepsize = Ceiling(lastN/10)>
			<cfif stepsize GT 2>
			<tr>	
				<td>
					<table width="100%" border="1" cellpadding="1" cellspacing="1"  >
						<tr align="CENTER">
							<cfloop index="N" from="#stepsize#" to="#LastN#" step="#stepsize#" >
								<td height="35" align="CENTER" <cfif FirstNumber IS ListGetAt(RegNoList, N-stepsize+1)>bgcolor="Aqua"</cfif>>
									<span class="pix10">
															
									<a href="LUList.cfm?FirstNumber=#ListGetAt(RegNoList, N-stepsize+1)#&LastNumber=#ListGetAt(RegNoList, N)#&TblName=#TblName#&LeagueCode=#LeagueCode#">
									<b>#ListGetAt(RegNoList, N-stepsize+1)# to #ListGetAt(RegNoList, N)#</b></a>
									</span>
								</td>
							</cfloop>
							
							<cfif lastN GE (N-stepsize+1)>
								<td height="35" align="CENTER" <cfif FirstNumber IS ListGetAt(RegNoList, N-stepsize+1)>bgcolor="Aqua"</cfif>>
									<span class="pix10">
									<a href="LUList.cfm?FirstNumber=#ListGetAt(RegNoList, N-stepsize+1)#&LastNumber=#ListGetAt(RegNoList, lastN)#&TblName=#TblName#&LeagueCode=#LeagueCode#">									
									<b>#ListGetAt(RegNoList, N-stepsize+1)# to #ListGetAt(RegNoList, lastN)#</b></a>
									</span>
								</td>
							</cfif>
							
						</tr>
					</table>
				</td>
			</tr>
			</cfif>
		
			<tr>	
				<td>
				<table width="100%" border="1" cellspacing="1" cellpadding="1" class="loggedinScreen">
					<tr align="CENTER">
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "A">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=A&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">A</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "B">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=B&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">B</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "C">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=C&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">C</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "D">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=D&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">D</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "E">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=E&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">E</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "F">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=F&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">F</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "G">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=G&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">G</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "H">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=H&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">H</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "I">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=I&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">I</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "J">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=J&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">J</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "K">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=K&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">K</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "L">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=L&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">L</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "M">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=M&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">M</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "N">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=N&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">N</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "O">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=O&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">O</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "P">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=P&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">P</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "Q">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=Q&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">Q</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "R">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=R&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">R</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "S">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=S&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">S</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "T">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=T&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">T</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "U">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=U&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">U</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "V">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=V&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">V</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "W">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=W&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">W</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "X">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=X&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">X</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "Y">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=Y&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">Y</span></a></td>
					<td width="20" height="35"  align="CENTER" <cfif FirstLetter IS "Z">bgcolor="Aqua"</cfif>><a href="LUList.cfm?FirstLetter=Z&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix13bold">Z</span></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</cfif>

	</cfoutput>	
	
	<cfif STRING1 IS "Player" >
		<!--- reset the MatchBanReminder flag in zmast.LeagueInfo --->
		<cfif Suspended IS "MB">
			<cfset MBRValue = 0 >
			<cfinclude template="queries/upd_LeagueInfo3.cfm">
		</cfif>
	
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="2">
					<tr>
						<cfoutput>
							<td align="CENTER"><span class="pix10">Reg<BR>No</span></td>
							<td align="LEFT"><span class="pix10">Player Name</span></td>
							<td align="CENTER"><span class="pix10">Date of Birth</span></td>
							<td align="CENTER"><span class="pix10">Age</span></td>
							<td align="CENTER"><span class="pix10">Appearances</span></td>
							<td align="CENTER"><span class="pix10">Suspensions</span></td>
							<td align="Center"><span class="pix10">Registrations</span></td>
							<td align="Center"><span class="pix10">Notes</span></td>
						</cfoutput>
					</tr>

					<cfoutput query="PlayerList" group="Surname" startrow="#Start#" maxrows="#MaxRows#" >
						<!--- this is the thin line that separates groups of players with the same Surname --->
						<tr>
							<td height="1" colspan="8" class="bg_white"></td>
						</tr>
						
						<cfoutput group="RegNo">
							<cfset UsedFixtureIDList = "" >
							<cfset OldestFixtureDate = '1900-01-01'>
							<cfset ShowSuspensions = "Yes" >
							<tr>
					
								<!---
								**********
								* Reg No *
								**********
								--->
								
								<td align="RIGHT" class="bg_originalcolor">
									<span class="pix13">#RegNo#</span>
								</td>
						
								<!---
								***************
								* Player Name *
								***************
								--->
								<!--- applies to season 2012 onwards only --->
								<cfif RIGHT(request.dsn,4) GE 2012>
									<cfif Trim("#AddressLine1##AddressLine2##AddressLine3##Postcode#") IS "">
										<cfset ToolTipText="address lines are missing">
									<cfelse>
										<cfset ToolTipText="<div style='text-align:left;'>#AddressLine1#<br>#AddressLine2#<br>#AddressLine3#<br>#Postcode#</div>">
									</cfif>
								<cfelse>
									<cfset ToolTipText="<div style='text-align:left;'>Address lines show here from season 2012 onwards only....</div>">
								</cfif>
								<cfset tooltiptext = Replace(tooltiptext, "'", "\'", "ALL")>
								<td align="left" class="bg_originalcolor">
									<a href="UpdateForm.cfm?TblName=Player&ID=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='##FFFFF0';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#TooltipText#');" ><span class="pix13"><b>#Surname#</b> #Forename#</span></a>
								</td>
						
								<!---
								***********************
								* Date of Birth & Age *
								***********************
								--->
						
								<cfif DOB IS "">
									<td align="CENTER" class="bg_originalcolor"><span class="pix13">-</span></td>
									<td align="CENTER" class="bg_originalcolor"><span class="pix10">-</span></td>
								<cfelse>
									<td align="CENTER" class="bg_originalcolor"><span class="pix13">#DateFormat(DOB, 'DD/MM/YYYY')#</span></td>
									<cfset ThisAge = DateDiff( "YYYY",  DOB, Now() ) >
									<cfif ThisAge LT 16 AND DefaultYouthLeague IS "No" >
										<td height="30" align="center" bgcolor="red"><span class="pix10boldwhite">WARNING: Age #ThisAge#</span></td>
									<cfelse>
										<td align="CENTER" class="bg_originalcolor"><span class="pix10">#ThisAge#</span></td>
									</cfif>		
									
								</cfif>
						
								<!---
								***************
								* appearances *
								***************
								--->
						
								<td align="CENTER" class="bg_originalcolor">  
									<span class="pix10">
										<a href="PlayersHist.cfm?PI=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#">see</a>
									</span>
								</td>
						
								<!---
								***************
								* suspensions *
								***************
								--->
						
								<td align="CENTER" class="bg_suspend">  
									<span class="pix10">
										<a href="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&PI=#EVALUATE(STRING4)#">add</a>
									</span>
								</td>
						
								<!---
								*****************
								* Registrations *
								*****************
								--->
								
								<td align="CENTER" class="bg_registr">  
									<span class="pix10">
										<a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&PI=#EVALUATE(STRING4)#">add</a>
									</span>
								</td>
						
								<!---
								*********
								* Notes *
								*********
								--->
									
								<td align="left" class="bg_originalcolor"><span class="pix10">#PlayerNotes#</span></td>
							</tr>
							
							
							<cfoutput group="FirstDayOfRegistration">
								<cfif ShowSuspensions and FirstDayOfSuspension IS NOT "">
								
								
									<cfoutput>
									
									
										<tr>
											<cfset ThisSuspensionID = Playerlist.SI >
											<cfinclude template = "queries/qry_QMatchbanHeader.cfm">
											<cfif QMatchbanHeader.RecordCount GT 0  AND QMatchbanHeader.NumberOfMatches GT 0 >
													<td colspan="1" class="bg_originalcolor">&nbsp;</td>												
													<td colspan="4" class="bg_suspend" >
													<span class="pix10boldred">#NumberOfMatches# match ban</span><span class="pix10"> <cfif Len(Trim(QMatchbanHeader.TeamOrdinalDescription)) IS 0><cfelse> involving #QMatchbanHeader.TeamOrdinalDescription# </cfif> starting <b>#DateFormat( FirstDayOfSuspension , 'DD MMMM YYYY')#</b></span>
													<cfif Len(Trim(QMatchbanHeader.SuspensionNotes)) IS 0>
													<cfelse>
														<br>
														<table width="100%" border="0" cellpadding="2" cellspacing="0">
															<tr>
																<td align="left"><span class="pix10">#QMatchbanHeader.SuspensionNotes#</span></td>
															</tr>
														</table>
													</cfif>
													<table width="100%" border="1" cellpadding="2" cellspacing="0">
														<!--- get all the potential fixtures that might satisfy the match bans --->
														<cfinclude template="queries/qry_SatisfyFixtures.cfm">
														<cfset NCount = 0>
														<cfset YCount = 0>
														<cfset XCount = 0>
														<cfset MatchCount=1>
														<cfloop condition = "(MatchCount LE (NumberOfMatches+NCount)) AND ((NCount+YCount) LT NumberOfMatches+XCount)">
															<!--- get a fixture to satisfy this item --->
															<cfloop query="QSatisfyFixtures" startrow="#MatchCount#" endrow="#MatchCount#">
																<cfinclude template = "queries/qry_QAnyApps.cfm">
																<cfinclude template = "queries/qry_QAppID.cfm">
																<tr class="bg_suspend">
																
																
									<!--- 
									**********************************************************************************************
									**********************************************************************************************  
									**********************************************************************************************
									**********************************************************************************************
									1 
									a. Game must have been played to a conclusion with a proper scoreline (not Postponed or Void or Abandoned etc)
									b. Player must not already be suspended for this game
									c. games must count towards match based suspensions for their team - see constitution MatchBanFlag
									d. If a game was played to a conclusion with a proper scoreline but then later AWARDED because of, say, an ineligible player
									then the game WILL count. Such a game will have player appearances. An AWARDED game that was not played will not have player appearances.
									**********************************************************************************************
									**********************************************************************************************  
									 Result IS "H"=awarded Home Win, "A"=awarded Away Win, "D"=Draw awarded
									 Result IS "P"=Postponed, "Q"=Abandoned, "W"=Void
									 Result IS "T"=TEMP hidden from public
									**********************************************************************************************  
									**********************************************************************************************  
									--->
																	
																	<cfif DoesNotCountTowardsMatchBasedSuspensions 
																		OR (Result IS "H" AND QAnyApps.AppearanceCount IS 0)
																		OR (Result IS "A" AND QAnyApps.AppearanceCount IS 0)
																		OR (Result IS "D" AND QAnyApps.AppearanceCount IS 0)
																		OR Result IS "P" 
																		OR Result IS "Q" 
																		OR Result IS "W" 
																		OR Result IS "T">
																		<cfset ThisClass = "pix10silver">
																	<cfelse>
																		<cfset ThisClass = "pix10">
																	</cfif>
																	
																	<!--- check for exceptional awarded result where game was played and awarded later --->
																	<cfset AwardedGameWasPlayed = "No">	
																	<cfif Result IS "A" OR Result IS "H" OR Result IS "D">
																		<cfif QAnyApps.AppearanceCount GT 0 >
																			<cfset AwardedGameWasPlayed = "Yes">
																		</cfif>
																	</cfif>
																	<cfif 
																		((IsNumeric(HomeGoals) AND IsNumeric(AwayGoals)) OR AwardedGameWasPlayed IS "Yes" )
																			AND NOT ListFind(UsedFixtureIDList,QSatisfyFixtures.FixtureID)
																			<!--- changed from GT to GE in 30 April 2012 to allow double headers to count as 2 games --->
																			AND (fixturedate GE #OldestFixtureDate#)
																			AND (NOT DoesNotCountTowardsMatchBasedSuspensions) >
																		<cfset UsedFixtureIDList = ListAppend(UsedFixtureIDList, QSatisfyFixtures.FixtureID)>
																		<cfset YCount = YCount + 1 >
																		<td width="5%" align="center"><span class="pix10boldred">#YCount#</span>
																		<cfset OldestFixtureDate = #QSatisfyFixtures.fixturedate# >
																	<cfelse>
																		<cfset OldestFixtureDate = #QSatisfyFixtures.fixturedate# >
																		<cfif ThisClass IS "pix10silver">
																			<td width="5%" align="center"><span class="#ThisClass#"> - </span>
																			<cfset NCount = NCount + 1 >
																			<cfset XCount = XCount + 1 >
																		<cfelse>
																			<td width="5%" align="center"><span class="#ThisClass#"> - </span>
																			<cfset NCount = NCount + 1 >
																		</cfif>
																	</cfif>
																	<!--- 2 Match Date --->
																	<td align="left" width="10%"><span class="#ThisClass#">#DateFormat(fixturedate,'DD/MM/YY')#</span></td>
																	<!--- 3 KO Round name --->
																	<td align="left" width="20%"><span class="#ThisClass#">#CompetitionName# #KORoundDescription#</span></td>
																	<!--- 4 Home & Away & score details --->
																	<td align="left" width="65%"><span class="#ThisClass#">#HomeTeamName# #HomeGoals# v #AwayGoals# #AwayTeamName# </span>
																		<!---  Awarded/Postponed/Void etc  --->
																		<cfif Result IS "H" AND AwardedGameWasPlayed IS "No">
																			<span class="pix10"><strong> Home Win</strong></span></td>
																		<cfelseif Result IS "H" AND AwardedGameWasPlayed IS "Yes">
																			<span class="pix10"><strong> Home Win awarded after game was played</strong></span></td>
																		<cfelseif Result IS "A" AND AwardedGameWasPlayed IS "No">
																			<span class="pix10"><strong> Away Win</strong></span></td>
																		<cfelseif Result IS "A" AND AwardedGameWasPlayed IS "Yes">
																			<span class="pix10"><strong> Away Win awarded after game was played</strong></span></td>
																		<cfelseif Result IS "D" AND AwardedGameWasPlayed IS "No">
																			<span class="pix10"><strong> Drawn</strong></span></td>
																		<cfelseif Result IS "D" AND AwardedGameWasPlayed IS "Yes">
																			<span class="pix10"><strong> Draw awarded after game was played</strong></span></td>
																		<cfelseif Result IS "P" >
																			<span class="pix10"><strong> Postponed</strong></span></td>
																		<cfelseif Result IS "Q" >
																			<span class="pix10"><strong> Abandoned</strong></span></td>
																		<cfelseif Result IS "W" >
																			<span class="pix10"><strong> Void</strong></span></td>
																		<cfelseif Result IS "T" >
																			<span class="pix10"><strong> TEMP</strong></span></td>
																		<cfelseif Result IS "U" >
																			<span class="pix10"><strong> H Win on Pens</strong></span></td>
																		<cfelseif Result IS "V" >
																			<span class="pix10"><strong> A Win on Pens</strong></span></td>
																		<cfelse>
																			<span class="pix10">&nbsp;</span>
																			<cfif QAppID.RecordCount GT 0><span class="pix13boldred"><br>PLAYED WHILE SUSPENDED</span></cfif>
																		
																		<!---
																		<cfif ListFind("Silver",request.SecurityLevel)><span class="pix10"><br>#QSatisfyFixtures.FixtureID# #DateFormat(OldestFixtureDate,'DD/MM/YYYY')#</span></cfif>
																		
																		<cfif ListFind("Silver",request.SecurityLevel)>
																		<span class="pix9"><br>
																		Y#YCount# N#NCount# MC#MatchCount# X#XCount#
																		</span>
																		</cfif>
																		
																		<cfif ListFind("Silver",request.SecurityLevel)>
																		<span class="pix9">
																		#ListFind(UsedFixtureIDList,QSatisfyFixtures.FixtureID)# 
																		#QSatisfyFixtures.FixtureID# #UsedFixtureIDList# 
																		#DateFormat(OldestFixtureDate,'DD/MM/YY')# 
																		#DateFormat(QSatisfyFixtures.fixturedate,'DD/MM/YY')#
																		</span>
																		</cfif>
																		
																		--->
																		
																		
																		
																		
																		
																		</cfif>
																	</td>
																
															</cfloop>
															<cfset MatchCount=MatchCount+1>
															</tr>
														</cfloop>
														<!--- check to see if the number of matches for which banned has been satisfied --->
														<!---  <cfif MatchCount GT (NumberOfMatches+NCount) > --->
														 <cfif YCount IS NumberOfMatches > 
															<cfset ThisLastDay = #DateFormat(OldestFixtureDate, 'YYYY-MM-DD')# >
															<cfinclude template="queries/upd_Suspension.cfm">
															<tr class="bg_suspend">
																<td colspan="4" align="right"><span class="pix10"><strong>ended #DateFormat(OldestFixtureDate, 'DD MMMM YYYY')#</strong></span></td>
															</tr>
														<cfelse>
															<cfset ThisLastDay = '2999-12-31' >
															<cfinclude template="queries/upd_Suspension.cfm">
															<tr class="bg_suspend">
																<td colspan="4" align="right"><span class="pix10boldred">suspension ongoing</span></td>
															</tr>
														</cfif>
													</table>
												</td>
												<td align="center" class="bg_suspend"><a href="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&SI=#ThisSuspensionID#"><span class="pix10">upd/del</span></a></td>
												
											<cfelse> <!--- NumberOfMatches is 0 --->
												<cfset OldestFixtureDate = LastDayOfSuspension >
												<td colspan="1" class="bg_originalcolor">&nbsp;</td>
												<td  align="left" colspan="4" class="bg_suspend">
													<span class="pix10"><b>#ROUND(Evaluate((DateDiff("h", FirstDayOfSuspension, LastDayOfSuspension) +25)/ 24))# days</b> suspension from <b>#DateFormat( FirstDayOfSuspension , 'DD MMM YY')#</b> to <b>#DateFormat( LastDayOfSuspension , 'DD MMM YY')#</b></span>
													<cfif Len(Trim(SuspensionNotes)) IS 0 >
													<cfelse>
														<br>
														<table width="100%" border="0" cellpadding="2" cellspacing="0">
															<tr>
																<td align="left"><span class="pix10">#SuspensionNotes#</span></td>
															</tr>
														</table>
													</cfif>
											 	</td>
												<td colspan="1" align="CENTER" class="bg_suspend"><span class="pix10">
												<a href="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&SI=#ThisSuspensionID#">upd/del</a></span></td>
												<td colspan="1" class="bg_registr">&nbsp;</td>
												<td colspan="1" class="bg_originalcolor">&nbsp;</td>
											</cfif>
										</tr>
									</cfoutput>	 
									
								</cfif>
								<cfset ShowSuspensions = "No" >
								<cfif TeamName IS "">
									<tr>
										<td class="bg_originalcolor">&nbsp;</td>
										<td  align="left" colspan="6" class="bg_registr" ><span class="pix13"><strong>Not Registered</strong></span></td>
										<td colspan="1" class="bg_originalcolor">&nbsp;</td>
									</tr>
								<cfelse>
									<tr>
										<td class="bg_originalcolor">&nbsp;</td>
										<td  align="left" class="bg_registr"><a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TeamID#&SortSeq=Name&PID=#PlayerList.ID#"><span class="pix13">#TeamName#</span></a></td>
										<td  align="left" colspan="4" class="bg_registr">
										<CFSWITCH expression="#RegType#">
											<CFCASE VALUE="A">
												<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Non-Contract ]</span>
												<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Non-Contract from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
													<span class="pix10">[ Non-Contract to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelse>
													<span class="pix10">[ Non-Contract from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												</cfif>
											</CFCASE>
											<CFCASE VALUE="B">
												<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Contract ]</span>
												<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Contract from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
													<span class="pix10">[ Contract to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelse>
													<span class="pix10">[ Contract from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												</cfif>
											</CFCASE>
											<CFCASE VALUE="C">
												<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Short Loan ]</span>
												<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Short Loan from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
													<span class="pix10">[ Short Loan to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelse>
													<span class="pix10">[ Short Loan from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												</cfif>
											</CFCASE>
											<CFCASE VALUE="D">
												<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Long Loan ]</span>
												<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Long Loan from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
													<span class="pix10">[ Long Loan to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelse>
													<span class="pix10">[ Long Loan from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												</cfif>
											</CFCASE>
											<CFCASE VALUE="E">
												<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Work Experience ]</span>
												<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Work Experience from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
													<span class="pix10">[ Work Experience to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelse>
													<span class="pix10">[ Work Experience from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												</cfif>
											</CFCASE>
											<CFCASE VALUE="G">
												<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Lapsed ]</span>
												<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Lapsed from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
													<span class="pix10">[ Lapsed to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelse>
													<span class="pix10">[ Lapsed from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												</cfif>
											</CFCASE>
											<CFCASE VALUE="F">
												<cfif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Temporary ]</span>
												<cfelseif FirstDayOfRegistration IS NOT "" AND LastDayOfRegistration IS "">
													<span class="pix10">[ Temporary from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelseif FirstDayOfRegistration IS "" AND LastDayOfRegistration IS NOT "">
													<span class="pix10">[ Temporary to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												<cfelse>
													<span class="pix10">[ Temporary from #DateFormat(FirstDayOfRegistration, 'DD MMM YY')# to #DateFormat(LastDayOfRegistration, 'DD MMM YY')# ]</span>
												</cfif>
											</CFCASE>
											<CFDEFAULTCASE> <!--- Only A to F used at present - Should never get here! ABORT --->
												Error in LUList.cfm - RegType <cfoutput>#RegType#</cfoutput> ..... ABORTING
												<CFABORT> 
											</CFDEFAULTCASE>
										</CFSWITCH>
										</td>
										<td colspan="1" align="CENTER" class="bg_registr"><a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#RI#"><span class="pix10">upd/del</span></a></td>
										<td colspan="1" class="bg_originalcolor">&nbsp;</td>
									</tr>
								</cfif>
							</cfoutput> 
							<cfif FirstNumber IS NOT "" AND FirstNumber IS LastNumber >
								<cfinclude template="queries/qry_QSimilarName.cfm">
								<cfif QSimilarName.RecordCount GT 1>
									<tr align="center">
										<td colspan="8" valign="top">
											<table border="1" cellpadding="2" cellspacing="0">
												<tr>
													<td  align="left" colspan="6"><span class="pix10bold">please check this list for duplicates ...</span></td>
												</tr>
												<cfloop query="QSimilarName">
													<cfif shortcol IS PlayerList.RegNo >
														<tr class="bg_highlight">
															<td><span class="pix13">&nbsp;</span></td>
															<td align="right"><span class="pix13">#shortcol#</span></td>
															<td align="left"><span class="pix13bold">#surname#</span></td>
															<td align="left"><span class="pix13">#forename#</span></td>
															<td align="left"><span class="pix13">#DateFormat(mediumcol, 'DD/MM/YYYY')#</span></td>
															<td><span class="pix13">&nbsp;</span></td>
														</tr>
													<cfelse>
														<tr>
															<cfif PlayerList.Forename IS QSimilarName.forename >
																<td align="center"><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#"><span class="pix10">upd/del</span></a></td>
																<td bgcolor="Red" align="right"><span class="pix13boldwhite">#shortcol#</span></td>
																<td align="left" bgcolor="Red"><span class="pix13boldwhite">#surname#</span></td>
																<td align="left" bgcolor="Red"><span class="pix13boldwhite">#forename#</span></td>
																<td align="left" bgcolor="Red"><span class="pix13boldwhite">#DateFormat(mediumcol, 'DD/MM/YYYY')#</span></td>
																<td align="left" ><span class="pix13boldred">WARNING: same forename</span></td>
															<cfelseif PlayerList.DOB IS QSimilarName.mediumcol >
																<td align="center" ><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#"><span class="pix10">upd/del</span></a></td>
																<td bgcolor="Red"align="right"><span class="pix13boldwhite">#shortcol#</span></td>
																<td align="left" bgcolor="Red"><span class="pix13boldwhite">#surname#</span></td>
																<td align="left" bgcolor="Red"><span class="pix13boldwhite">#forename#</span></td>
																<td align="left" bgcolor="Red"><span class="pix13boldwhite">#DateFormat(mediumcol, 'DD/MM/YYYY')#</span></td>
																<td align="left" ><span class="pix13boldred">WARNING: same date of birth</span></td>
															<cfelse>
																<td align="center" ><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#"><span class="pix10">upd/del</span></a></td>
																<td align="right"><span class="pix13">#shortcol#</span></td>
																<td align="left" ><span class="pix13bold">#surname#</span></td>
																<td align="left" ><span class="pix13">#forename#</span></td>
																<td align="left" ><span class="pix13">#DateFormat(mediumcol, 'DD/MM/YYYY')#</span></td>
																<td><span class="pix13">&nbsp;</span></td>
															</cfif>
														</tr>
													</cfif>
												</cfloop>
											</table>
										</td>
									</tr>
								</cfif>
							</cfif>
						</cfoutput> 
						<cfset CurrRow = CurrentRow >
    				</cfoutput>
				</table>
			</td>
		</tr>
		
		
	<cfelse> <!---  STRING1 isn't "Player" --->
		<cfoutput QUERY="#STRING2#" startrow="#Start#" maxrows="#MaxRows#" >
	    	<tr align="left">
			<!--- 1 --->
				<td valign="top" class="bg_originalcolor"><a href="UpdateForm.cfm?TblName=#STRING1#&ID=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#"><span class="pix13">*</span></a></td>
			<!--- 2 --->
				<td valign="top" class="bg_originalcolor">
					<cfif STRING1 IS "MatchReport">
						<span class="pix10"><a href="SeeMatchReport.cfm?MatchReportID=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#&TblName=Matches&LeagueName=#URLEncodedFormat(LeagueName)#&SeasonName=#SeasonName#"
						target="#LeagueCode#MatchReport#EVALUATE(STRING4)#">Preview</a></span>
					<cfelseif STRING1 IS "Rule">
						<span class="pix13">#NumberFormat(ShortCol, "9,999.99")#</span>				
					<cfelseif STRING1 IS "Noticeboard">
						<cfset ThisCounty = GetToken(ShowForTheseCounties, 1, ",") >
						<span class="pix10"><a href="Noticeboard.cfm?countieslist=#ThisCounty#&LeagueCode=#LeagueCode#" target="NoticeboardPreview">Preview</a></span>
					<cfelseif STRING1 IS "Document">
						<cfif FileExists("#request.xpath#/fmstuff/#Extension#/#LeagueCodePrefix#/#Filename#.#Extension#")>
							<span class="pix13"><a href="fmstuff/#Extension#/#LeagueCodePrefix#/#Filename#.#Extension#" target="DocumentPreview">Preview</a></span>
						<cfelse>
							<span class="pix13boldred">MISSING</span>
						</cfif>
					<cfelse>
						<a href="UpdateForm.cfm?TblName=#STRING1#&ID=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#"><span class="pix13">#ShortCol#</span></a>
					</cfif>
				</td>
			<!--- 3 --->
				<td valign="top" class="bg_originalcolor">
					<cfif #STRING1# IS "Noticeboard">
						<span class="pix10">#AdvertTitle#</span>
					<cfelseif STRING1 IS "Document">
						<span class="pix13">[<strong>#GroupName#</strong>] #Description#</span>
					<cfelseif STRING1 IS "Committee">
						<cfif Len(Trim('#Title##Surname##Forename#')) IS 0 >
							<a href="UpdateForm.cfm?TblName=#STRING1#&ID=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#"><span class="pix13">#MediumCol#</span></a>
						<cfelse>
							<a href="UpdateForm.cfm?TblName=#STRING1#&ID=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#"><span class="pix13">#Title# #Forename# <strong>#Surname#</strong></span></a>
						</cfif>
					<cfelse>
						<a href="UpdateForm.cfm?TblName=#STRING1#&ID=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#"><span class="pix13">#MediumCol#</span></a>
					</cfif>	
				</td>
			<!--- 4 --->
				<td valign="top" class="bg_originalcolor">
					<cfif STRING1 IS "Noticeboard">
						<span class="pix10">#AdvertHTML#</span>
					<cfelseif STRING1 IS "Document">
						<span class="pix13">#FileName#</span>
					<cfelse>
						<a href="UpdateForm.cfm?TblName=#STRING1#&ID=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#">
						<span class="pix13">
						<cfif STRING1 IS "Referee">
							<cfif Len(Trim('#Surname##Forename#')) IS 0 >
								#LongCol#
							<cfelse>
								#Forename# <strong>#Surname#</strong>
							</cfif>
						<cfelseif STRING1 IS "Team" AND ShortCol IS "Guest">	
							<i>#LongCol#</i>
						<cfelse>#LongCol#
						</cfif></span></a>
					</cfif>
				</td>
				<cfif STRING1 IS "Referee">
					<td width="200" align="left" valign="top" class="bg_originalcolor">
						<span class="pix10">#Left(Trim(Restrictions),100)#<cfif Len(Trim(Restrictions)) GT 100><br><strong> ... MORE</strong></cfif></span>
					</td>
				
					<td valign="top" align="CENTER" class="bg_originalcolor"> 
						<cfif Level IS 0>
							<span class="pix10">&nbsp;</span>
						<cfelse>
							<span class="pix10">#NumberFormat(level, '99')#</span>
						</cfif>
						
					</td>
					<td valign="top" align="CENTER" class="bg_originalcolor">  
						<span class="pix10"><cfif PromotionCandidate IS "Yes">Promo</cfif></span>
					</td>
					<td valign="top" align="CENTER" class="bg_originalcolor">  
						<span class="pix10">
							<a href="RefsHist.cfm?RI=#EVALUATE(STRING4)#&LeagueCode=#LeagueCode#">See History</a>
						</span>
					</td>
					<td valign="top" align="center" class="bg_originalcolor">
						<cfset EmailSubject = URLEncodedFormat("Referee: #LongCol# - #LeagueName#") >
						<span class="pix10">
						<a href="mailto:#TRIM(EmailAddress1)#?subject=#EmailSubject#">#TRIM(EmailAddress1)#</a>
						<br />
						<a href="mailto:#TRIM(EmailAddress2)#?subject=#EmailSubject#">#TRIM(EmailAddress2)#</a>
						</span>
					</td>
					
				</cfif>

				<cfif STRING1 IS "Noticeboard">
				<td align="CENTER" class="bg_originalcolor">  
					<span class="pix10">#ImageFile#</span>
				</td>
				</cfif>
				<td valign="top" class="bg_originalcolor">
					<cfif STRING1 IS "MatchReport" >
						<span class="pix10">#Left(Notes, 300)#...........</span>
					<cfelseif STRING1 IS "Document">
						<span class="pix13">#Extension#</span>
	<!--- #DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')#</span> --->

					<cfelseif STRING1 IS "Referee" >
						<span class="pix10">
						<cfif Len(Trim(AddressLine1)) GT 0>#AddressLine1#<br /></cfif>
						<cfif Len(Trim(AddressLine2)) GT 0>#AddressLine2#<br /></cfif>
						<cfif Len(Trim(AddressLine3)) GT 0>#AddressLine3#<br /></cfif>
						<cfif Len(Trim(Postcode))     GT 0>#Postcode#<br /></cfif>
						<cfif Len(Trim(HomeTel)) GT 0>Home: #HomeTel#<br /></cfif>
						<cfif Len(Trim(WorkTel)) GT 0>Work: #WorkTel#<br /></cfif>
						<cfif Len(Trim(MobileTel)) GT 0>Mobile: #MobileTel#<br /></cfif>
						<cfif Len(Trim(Notes)) GT 0>#Notes#<br /></cfif>
						</span>
					<cfelseif STRING1 IS "Committee" >
						<span class="pix10">
						<cfif Len(Trim(AddressLine1)) GT 0>#AddressLine1#<br /></cfif>
						<cfif Len(Trim(AddressLine2)) GT 0>#AddressLine2#<br /></cfif>
						<cfif Len(Trim(AddressLine3)) GT 0>#AddressLine3#<br /></cfif>
						<cfif Len(Trim(Postcode))     GT 0>#Postcode#<br /></cfif>
						<cfif Len(Trim(EmailAddress1)) GT 0>Email Address 1: <a href="mailto:#EmailAddress1#?subject=#replacelist(LeagueName,"&,<br>,<br />", "and, , ")#">#EmailAddress1#</a><br /></cfif>
						<cfif Len(Trim(EmailAddress2)) GT 0>Email Address 2: <a href="mailto:#EmailAddress2#?subject=#replacelist(LeagueName,"&,<br>,<br />", "and, , ")#">#EmailAddress2#</a><br /></cfif>
						<cfif Len(Trim(HomeTel)) GT 0>Home: #HomeTel#<br /></cfif>
						<cfif Len(Trim(WorkTel)) GT 0>Work: #WorkTel#<br /></cfif>
						<cfif Len(Trim(MobileTel)) GT 0>Mobile: #MobileTel#<br /></cfif>
						<cfif Len(Trim(Notes)) GT 0><em>#Notes#</em><br /></cfif>
						</span>
					<cfelseif STRING1 IS "Venue" >
						<span class="pix10">
						<cfif Len(Trim(AddressLine1)) GT 0>#AddressLine1#<br /></cfif>
						<cfif Len(Trim(AddressLine2)) GT 0>#AddressLine2#<br /></cfif>
						<cfif Len(Trim(AddressLine3)) GT 0>#AddressLine3#<br /></cfif>
						<cfif Len(Trim(Postcode))     GT 0>#Postcode#<br /></cfif>
						<cfif Len(Trim(VenueTel)) GT 0>Venue Tel: #VenueTel#<br /></cfif>
						<cfif Len(Trim(MapURL)) GT 0>
						<cfset This_URL = "#TRIM(MapURL)#">
						<br /><a href="#This_URL#" target="_blank"><strong>MAP</strong></a><br /><br />
						</cfif>
						<cfif Len(Trim(Notes)) GT 0>#Notes#<br /></cfif>
						</span>
					<cfelseif STRING1 IS "Team" >
						<!---
						FACharterStandardType 
						
						Unspecified = 0
						FA Charter Standard Club (Adult) = 1
						FA Charter Standard Club (Youth) = 2
						FA Charter Standard Development Club = 3
						FA Charter Standard Community Club = 4
						not FA Charter Standard = 9
						--->
					
						<cfif FACharterStandardType IS 1>
							<img src="images/Charter Standard Adult Club Logo tiny.jpg"><br>
						<cfelseif FACharterStandardType IS 2>
							<img src="images/Charter Standard Youth Club Logo tiny.jpg"><br>
						<cfelseif FACharterStandardType IS 3>
							<img src="images/Charter Standard Development Club Logo tiny.jpg"><br>
						<cfelseif FACharterStandardType IS 4>
							<img src="images/Charter Standard Community Club Logo tiny.jpg"><br>
						<cfelseif FACharterStandardType IS 9>
							<span class="pix10">not Charter Standard<br></span>
						</cfif>
						<cfif Len(Trim(ParentCountyFA)) GT 0 OR Len(Trim(AffiliationNo)) GT 0 >
							<span class="pix10bold">#ParentCountyFA# #AffiliationNo#<br></span>
						</cfif>
						<cfif Len(Trim(Notes)) GT 0>
							<span class="pix10">#Trim(Notes)#<br></span>
						</cfif>
						<cfif VenueAndPitchAvailable IS "Yes" >
							<cfinclude template="queries/qry_QTeamNormalVenue2.cfm">
							<cfif QTeamNormalVenue2.RecordCount IS 1>
								<cfloop query="QTeamNormalVenue2">
									<span class="pix10"><cfif OrdinalName IS ""><cfelse><em>#OrdinalName#</em>: </cfif>#Trim(VenueName)#<cfif Len(Trim(AddressLine1)) GT 0>, #Trim(AddressLine1)#</cfif><cfif Len(Trim(AddressLine2)) GT 0>, #Trim(AddressLine2)#</cfif><cfif Len(Trim(AddressLine3)) GT 0>, #Trim(AddressLine3)#</cfif><cfif Len(Trim(PostCode)) GT 0>, #Trim(PostCode)#</cfif><cfif Len(Trim(VenueTel)) GT 0>. Tel: #VenueTel#</cfif></span>						
								</cfloop>
							<cfelseif QTeamNormalVenue2.RecordCount GT 1>
								<cfloop query="QTeamNormalVenue2">
									<span class="pix10"><cfif OrdinalName IS ""><em>1st Team</em>: <cfelse><em>#OrdinalName#</em>: </cfif>#Trim(VenueName)#<cfif Len(Trim(AddressLine1)) GT 0>, #Trim(AddressLine1)#</cfif><cfif Len(Trim(AddressLine2)) GT 0>, #Trim(AddressLine2)#</cfif><cfif Len(Trim(AddressLine3)) GT 0>, #Trim(AddressLine3)#</cfif><cfif Len(Trim(PostCode)) GT 0>, #Trim(PostCode)#</cfif><cfif Len(Trim(VenueTel)) GT 0>. Tel: #VenueTel#</cfif><br></span>						
								</cfloop>
							<cfelseif TeamList.ShortCol IS NOT "GUEST" >
								<span class="pix13boldred">Normal Venue missing<br></span> 
							</cfif>
						</cfif>
					<cfelse>
						<span class="pix10">#Notes#</span>
					</cfif>
				</td>
			</tr>
			<tr bgcolor="white">
				<td height="2" colspan="20"></td>
			</tr>

			<cfset CurrRow = CurrentRow >				<!--- Introduce paging Jan. 2001 --->
	    </cfoutput>
	</cfif>
	<cfoutput>
		<tr class="bg_originalcolor">
			<td colspan="8">
				<!--- "Paging" --->
				<cfset NextStart = CurrRow + 1 >
				<cfif NextStart LTE STRING5 AND ((FirstNumber LT LastNumber) OR FirstLetter IS NOT "" OR Suspended IS "Y" OR Suspended IS "MB" OR Unregistered IS "Y") >
					<cfset Start = NextStart>
					<a href="LUList.cfm?Start=#Start#&FirstLetter=#FirstLetter#&Unregistered=#Unregistered#&Transfer=#Transfer#&Suspended=#Suspended#&FirstNumber=#FirstNumber#&LastNumber=#LastNumber#&TblName=#TblName#&LeagueCode=#LeagueCode#"><span class="pix18bold">More...</span></a>	
				</cfif>
			</td>
		</tr>
	</cfoutput>
</table>

<cfif STRING1 IS "Committee">
	<cfinclude template="queries/qry_CommitteeEmailAddresses.cfm">
	<cfif QCommitteeEmailAddresses.RecordCount GT 0 >
	<hr>
	<table width="33%" border="0" align="center" cellpadding="0" cellspacing="2" bgcolor="white">
		<tr>
			<td><span class="pix10bold">Please copy and paste for your Committee email list.....<br>&nbsp;</span></td>
		</tr>	
		<cfoutput query="QCommitteeEmailAddresses">
			<tr>
				<cfif REFindNoCase(".+@.+\..+", emailaddr) IS 0 >
					<td><span class="pix10boldred">#emailaddr# * ERROR *</span></td>
				<cfelse>
					<td><span class="pix10">#emailaddr#</span></td>
				</cfif> 
			</tr>	
		</cfoutput>
		
		<tr>
			<td height="50"><span class="pix10"> </span></td>
		</tr>
		<table border="1" align="center" cellpadding="2" cellspacing="0">
			<cfoutput query="QCommitteeEmailAddresses">
				<tr>
					<cfif REFindNoCase(".+@.+\..+", emailaddr) IS 0 >
						<td><span class="pix10boldred">#emailaddr# * ERROR *</span></td>
						<td><span class="pix10boldred">#CName#</span></td>
					<cfelse>
						<td><span class="pix10">#emailaddr#</span></td>
						<td><span class="pix10">#CName#</span></td>
					</cfif> 
				</tr>	
			</cfoutput>
		</table>
		
		
	</table>
	</cfif>
<cfelseif STRING1 IS "Referee">
	<cfinclude template="queries/qry_RefereeEmailAddresses.cfm">
	<cfif QRefereeEmailAddresses.RecordCount GT 0 >
	<hr>
	<table width="33%" border="0" align="center" cellpadding="0" cellspacing="2" bgcolor="white">
		<tr>
			<td><span class="pix10bold">Please copy and paste for your Referee email list.....<br>&nbsp;</span></td>
		</tr>	
		<cfoutput query="QRefereeEmailAddresses">
			<tr>
				<cfif REFindNoCase(".+@.+\..+", emailaddr) IS 0 >
					<td><span class="pix10boldred">#emailaddr# * ERROR *</span></td>
				<cfelse>
					<td><span class="pix10">#emailaddr#</span></td>
				</cfif> 
				</tr>	
		</cfoutput>
		
		
		<tr>
			<td height="50"><span class="pix10"> </span></td>
		</tr>
		<table border="1" align="center" cellpadding="2" cellspacing="0">
			<cfoutput query="QRefereeEmailAddresses">
				<tr>
					<cfif REFindNoCase(".+@.+\..+", emailaddr) IS 0 >
						<td><span class="pix10boldred">#emailaddr# * ERROR *</span></td>
						<td><span class="pix10boldred">#CName#</span></td>
					<cfelse>
						<td><span class="pix10">#emailaddr#</span></td>
						<td><span class="pix10">#CName#</span></td>
					</cfif> 
				</tr>	
			</cfoutput>
		</table>


		
	</table>
	</cfif>
<cfelseif STRING1 IS "Team">
	<cfinclude template="queries/qry_QRedundantTeamDetails.cfm">
	<cfif QRedundantTeamDetails.RecordCount GT 0 >
		<table border="1" align="center" cellpadding="4" cellspacing="0">
				<tr>
					<td colspan="3" align="center" bgcolor="red"><span class="pix13boldwhite">WARNING<br>Redundant Team Details have been found for</span></td>
				</tr>	
				<cfoutput query="QRedundantTeamDetails">
					<tr>
						<td align="left"><span class="pix10boldred">#team#</span></td>
						<td align="left"><span class="pix10boldred">#ordinal#</span></td>
						<td align="right"><span class="pix10bold"><a href="DeleteRedundantTeamDetails.cfm?LeagueCode=#LeagueCode#&id=#id#">Delete</a> Team Details</span></td>
					</tr>	
				</cfoutput>
				<tr>
					<td colspan="3" align="center" bgcolor="white"><span class="pix10">After each deletion please click on the Back button of your browser</span></td>
				</tr>	
				
		</table>
	</cfif>
	
	<cfinclude template="queries/qry_TeamEmailAddresses.cfm">
	<cfif QTeamEmailAddresses.RecordCount GT 0 >
	<hr>
	<table width="33%" border="0" align="center" cellpadding="0" cellspacing="2" bgcolor="white">
		<tr>
			<td><span class="pix10bold">Please copy and paste for your Team email list.....<br>&nbsp;</span></td>
		</tr>	
		<cfoutput query="QTeamEmailAddresses">
			<tr>
				<cfif REFindNoCase(".+@.+\..+", emailaddr) IS 0 >
					<td><span class="pix10boldred">#emailaddr# * ERROR *</span></td>
				<cfelse>
					<td><span class="pix10">#emailaddr#</span></td>
				</cfif> 
			</tr>	
		</cfoutput>
		
		
		<tr>
			<td height="50"><span class="pix10"> </span></td>
		</tr>
		<table border="1" align="center" cellpadding="2" cellspacing="0">
			<cfoutput query="QTeamEmailAddresses">
				<tr>
					<cfif REFindNoCase(".+@.+\..+", emailaddr) IS 0 >
						<td><span class="pix10boldred">#emailaddr# * ERROR *</span></td>
						<td><span class="pix10boldred">#TName#</span></td>
					<cfelse>
						<td><span class="pix10">#emailaddr#</span></td>
						<td><span class="pix10">#TName#</span></td>
					</cfif> 
				</tr>	
			</cfoutput>
		</table>


		
	</table>
	</cfif>
</cfif>

<cfif STRING1 IS "Document">
	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="2" bgcolor="white">
	
		<cfset ExtensionType = "PDF">
		<cfdirectory directory="#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#" action="list" name="QDirectory" listInfo="name" SORT="name ASC" type="file">
		<cfoutput>
			<tr align="left">
				<td colspan="2"><span class="pix18"><strong>#ExtensionType#</strong></span></td>
			</tr>
			<tr align="left">
				<td colspan="2"><span class="pix13"><strong>#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#</strong> - #QDirectory.RecordCount# #ExtensionType# files</span></td>
			</tr>
		</cfoutput>	
		<cfoutput query="QDirectory">
			<cfif ListFindNoCase( #FileNameList#, #Left(Name,Len(Name)-4)#, "|") IS 0 >
				<cfset FN = "#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#\#Name#">
				<tr align="left">
					<td width="5%"><span class="pix13"><a href="DeleteFile.cfm?LeagueCode=#LeagueCode#&FN=#FN#">Delete</a></span></td>
					<td><span class="pix13">#Name#</span><cfif Right(Name,3) IS "#ExtensionType#"><cfelse><span class="pix13boldred"> - WARNING</span></cfif></span></td>
				</tr>
			</cfif>	
		</cfoutput>
		
		
		<cfset ExtensionType = "DOC">
		<cfdirectory directory="#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#" action="list" name="QDirectory" listInfo="name" SORT="name ASC" type="file">
		<cfoutput>
			<tr align="left">
				<td colspan="2"><span class="pix18"><strong>#ExtensionType#</strong></span></td>
			</tr>
			<tr align="left">
				<td colspan="2"><span class="pix13"><strong>#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#</strong> - #QDirectory.RecordCount# #ExtensionType# files</span></td>
			</tr>
		</cfoutput>	
		<cfoutput query="QDirectory">
			<cfif ListFindNoCase( #FileNameList#, #Left(Name,Len(Name)-4)#, "|") IS 0 >
				<cfset FN = "#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#\#Name#">
				<tr align="left">
					<td width="5%"><span class="pix13"><a href="DeleteFile.cfm?LeagueCode=#LeagueCode#&FN=#FN#">Delete</a></span></td>
					<td><span class="pix13">#Name#</span><cfif Right(Name,3) IS "#ExtensionType#"><cfelse><span class="pix13boldred"> - WARNING</span></cfif></span></td>
				</tr>
			</cfif>	
		</cfoutput>

		<cfset ExtensionType = "XLS">
		<cfdirectory directory="#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#" action="list" name="QDirectory" listInfo="name" SORT="name ASC" type="file">
		<cfoutput>
			<tr align="left">
				<td colspan="2"><span class="pix18"><strong>#ExtensionType#</strong></span></td>
			</tr>
			<tr align="left">
				<td colspan="2"><span class="pix13"><strong>#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#</strong> - #QDirectory.RecordCount# #ExtensionType# files</span></td>
			</tr>
		</cfoutput>	
		<cfoutput query="QDirectory">
			<cfif ListFindNoCase( #FileNameList#, #Left(Name,Len(Name)-4)#, "|") IS 0 >
				<cfset FN = "#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#\#Name#">
				<tr align="left">
					<td width="5%"><span class="pix13"><a href="DeleteFile.cfm?LeagueCode=#LeagueCode#&FN=#FN#">Delete</a></span></td>
					<td><span class="pix13">#Name#</span><cfif Right(Name,3) IS "#ExtensionType#"><cfelse><span class="pix13boldred"> - WARNING</span></cfif></span></td>
				</tr>
			</cfif>	
		</cfoutput>

		<cfset ExtensionType = "JPG">
		<cfdirectory directory="#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#" action="list" name="QDirectory" listInfo="name" SORT="name ASC" type="file">
		<cfoutput>
			<tr align="left">
				<td colspan="2"><span class="pix18"><strong>#ExtensionType#</strong></span></td>
			</tr>
			<tr align="left">
				<td colspan="2"><span class="pix13"><strong>#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#</strong> - #QDirectory.RecordCount# #ExtensionType# files</span></td>
			</tr>
		</cfoutput>	
		<cfoutput query="QDirectory">
			<cfif ListFindNoCase( #FileNameList#, #Left(Name,Len(Name)-4)#, "|") IS 0 >
				<cfset FN = "#request.xpath#fmstuff\#ExtensionType#\#LeagueCodePrefix#\#Name#">
				<tr align="left">
					<td width="5%"><span class="pix13"><a href="DeleteFile.cfm?LeagueCode=#LeagueCode#&FN=#FN#">Delete</a></span></td>
					<td><span class="pix13">#Name#</span><cfif Right(Name,3) IS "#ExtensionType#"><cfelse><span class="pix13boldred"> - WARNING</span></cfif></span></td>
				</tr>
			</cfif>	
		</cfoutput>

		<cfoutput>
			<tr align="left">
				<td width="25%" height="50"><span class="pix18bold"><a href="UploadLeagueDocs_DOC.cfm?LeagueCode=#LeagueCode#">Upload .DOC</a></span></td>
				<td width="25%"><span class="pix18bold"><a href="UploadLeagueDocs_PDF.cfm?LeagueCode=#LeagueCode#">Upload .PDF</a></span></td>
				<td width="25%"><span class="pix18bold"><a href="UploadLeagueDocs_JPG.cfm?LeagueCode=#LeagueCode#">Upload .JPG</a></span></td>
				<!---
				<td width="25%"><span class="pix18bold"><a href="UploadLeaguePics_JPG.cfm?LeagueCode=#LeagueCode#">Upload .JPG</a></span></td>
				--->
				<td width="25%"><span class="pix18bold"><a href="UploadLeagueDocs_XLS.cfm?LeagueCode=#LeagueCode#">Upload .XLS</a></span></td>
			</tr>
		</cfoutput>
	</table>
</cfif>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
