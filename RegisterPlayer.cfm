<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cflock scope="session" timeout="10" type="readonly">
	<cfif StructKeyExists(session, "CurrentDate") >
        <cfset request.CurrentDate = session.CurrentDate >
	<cfelse>
		<cfset request.CurrentDate = Now() >
	</cfif>
	<cfif NOT IsDate(request.CurrentDate) >
		<cfset request.CurrentDate = Now() >
	</cfif>
	<!---
	<cfif StructKeyExists(session, "fmTeamID") >
        <cfset request.fmTeamID = session.fmTeamID >
	<cfelse>
		<cfset request.fmTeamID = 0 >
	</cfif>
	--->
</cflock>


<cfif NOT StructKeyExists(url, "RI") AND NOT StructKeyExists(form, "StateVector")>
<!---					**********************
						* Add a registration *
						**********************
--->
	<cfif NOT StructKeyExists(url, "PI")>
	Player's ID is missing.......
		<CFABORT>
	</cfif>
	<!--- get rid of any unused registrations --->
	<cfinclude template = "queries/del_QDeleteAllEmptyRegistration.cfm">
	<cfinclude template = "queries/ins_QAddRegistration.cfm">
	<cfinclude template = "queries/qry_QGetNewRegistration.cfm">
	<cfinclude template = "queries/upd_NewRegistration.cfm"> <!--- update with request.CurrentDate as default First Day, request.fmTeamID if non zero --->
	<cflocation URL="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#QGetNewRegistration.ID#" addtoken="no">			
	<CFABORT>
<!---					***********************************
						* Update or remove a registration *
						*********************************
--->
<cfelseif NOT StructKeyExists(form, "StateVector")>
	<!--- First time in --->
	<cfinclude template = "queries/qry_GetRegistration.cfm">
	<CFFORM ACTION="RegisterPlayer.cfm?LeagueCode=#LeagueCode#" METHOD="POST" name="RegisterPlayerForm">
		<input type="Hidden" name="StateVector" value="1">
		<cfoutput>
		<cfif StructKeyExists(url, "L")>
			<input type="Hidden" name="L" value="#url.L#">
		<cfelse>
			<input type="Hidden" name="L" value="0">
		</cfif>
		<input type="Hidden" name="RID" value="#GetRegistration.RID#">
		<input type="Hidden" name="RegNo" value="#GetRegistration.RegNo#">
		<input type="Hidden" name="PlayerID" value="#GetRegistration.PlayerID#">
		</cfoutput>

		<cfinclude template="queries/qry_QGetTeam.cfm">
		<cfset PlayerID = "#GetRegistration.PlayerID#" >
		<cfinclude template = "queries/qry_QAppearanceC.cfm">
		<table width="100%" >
			<tr>
				<td align="CENTER">
					<table width="500" border="0" cellpadding="2" cellspacing="0" class="bg_registr">
						<tr>
							<cfoutput>
								<td><span class="pix13"><strong>#GetRegistration.Surname#</strong> #GetRegistration.Forename#</span></td>
								<td align="right"><span class="pix13">Reg. No. #GetRegistration.RegNo#</span></td>
							</cfoutput>
						</tr>
						<!--- applies to season 2012 onwards only --->
						<cfif RIGHT(request.dsn,4) GE 2012>
							<tr>
								<td colspan="2" align="center"><span class="pix10"><cfoutput>#GetRegistration.AddressLine1#&nbsp;&##8226;&nbsp;#GetRegistration.AddressLine2#&nbsp;&##8226;&nbsp;#GetRegistration.AddressLine3#&nbsp;&##8226;&nbsp;#GetRegistration.Postcode#</cfoutput></span></td>
							</tr>
						</cfif>
						<tr>
							<td colspan="2" align="center"><span class="pix10"><cfoutput><em>#GetRegistration.Notes#</em></cfoutput></span></td>
						</tr>
						<tr>
							<td height="20" colspan="2" align="center"><span class="pix10bold">Registration</span></td>
						</tr>
						<td colspan="2" align="center">
							<table border="0" align="center" cellpadding="5" cellspacing="0" class="bg_originalcolor">
								<tr>
									<td height="40" align="right"><span class="pix10">NEW</span></td>
									<td height="40">
										<cfset tooltiptext="The current player registration number is #GetRegistration.RegNo#. Enter a different number here if you want to change it.">
										<cfoutput>
											<input name="NewRegNo" 
											type="text" 
											onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=80;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=4;this.T_WIDTH=400;return escape('#ToolTipText#');" value="#GetRegistration.RegNo#" >
										</cfoutput>
									</td>					
								</tr>
							</table>
						</td>
						<tr>
							<td height="50" align="right"><span class="pix10">Club</span></td>
							<td height="50">
								<select name="TeamID_ClubName" size="1">
									<cfoutput query="GetTeam" >
										<option value="#ID#^#LongCol#" <cfif IsNumeric(GetRegistration.TeamID) AND GetRegistration.TeamID IS ID>selected<cfelseif NOT IsNumeric(GetRegistration.TeamID) AND request.fmTeamID IS ID>selected</cfif> >#LongCol#</option>
									</cfoutput>
								</select>
							</td>					
						</tr>
						<tr>
							<td align="right"><span class="pix10">First day</span></td>
							<td>
							<cfoutput>
								<cfif NOT IsDate(GetRegistration.FirstDay) >
									<cfset FirstDayDate = Now() >
								<cfelseif DateCompare( GetRegistration.FirstDay, DateAdd('D', -60, SeasonStartDate) ) IS -1 >
									<cfset FirstDayDate = Now() >
								<cfelse>
									<cfset FirstDayDate = GetRegistration.FirstDay >
								</cfif>
								<cfif StructKeyExists(url, "FDToday")>
									<cfif url.FDToday IS "Yes">
										<cfset FirstDayDate = Now() >
									</cfif> 
								</cfif>
								<SELECT NAME="FirstDay"  size="1">
								<OPTION VALUE="" <cfif FirstDayDate IS "">selected </cfif>  ></OPTION>
								<cfloop index="z" from="-60" to="365" step="1">
									<cfset pqr = SeasonStartDate + CreateTimeSpan(z, 0, 0, 0)>
									<cfif DateCompare( pqr, SeasonEndDate ) IS 1 >
										<CFBREAK>
									</cfif>			
					    			<OPTION VALUE="#pqr#" 
									<cfif #DateFormat(SeasonStartDate + CreateTimeSpan(z, 0, 0, 0) , "DDDD, DD MMMM YYYY")#
							  		IS #DateFormat(FirstDayDate , "DDDD, DD MMMM YYYY")# >selected </cfif> >
										#DateFormat( SeasonStartDate + CreateTimeSpan(z, 0, 0, 0) , "DDDD, DD MMMM YYYY")#
									</OPTION>
								</cfloop>
								</select>
								<cfset TooltipText="Set First day to #DateFormat(Now(),'DDDD, DD MMMM YYYY')#">
									<a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#url.RI#&FDToday=Yes" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix9">Today</span></a>
								</cfoutput>
							</td>
												
						</tr>
						<tr>
							<td align="right"><span class="pix10">Last day</span></td>
							<td>
							
							<cfif GetRegistration.RegType IS "F"><!-- no "KEEP THE LAST DAY BLANK" warning if Temporary registration --->
								<cfoutput>
									<SELECT NAME="LastDay"  size="1">
									<OPTION VALUE="" <cfif GetRegistration.LastDay IS "">selected </cfif>  ></OPTION>
									<cfloop index="z" from="0" to="365" step="1">
										<cfset pqr = SeasonStartDate + CreateTimeSpan(z, 0, 0, 0)>
										<cfif DateCompare( pqr, SeasonEndDate ) IS 1 >
											<CFBREAK>
										</cfif>			
										<OPTION VALUE="#pqr#" <cfif #DateFormat(SeasonStartDate + CreateTimeSpan(z, 0, 0, 0) , "DDDD, DD MMMM YYYY")#
										IS #DateFormat(GetRegistration.LastDay , "DDDD, DD MMMM YYYY")# >selected </cfif>  >
											#DateFormat( SeasonStartDate + CreateTimeSpan(z, 0, 0, 0) , "DDDD, DD MMMM YYYY")#
										</OPTION>
									</cfloop>
									</select>
								</cfoutput>
							<cfelse>
								<cfoutput>
									<SELECT NAME="LastDay"  size="1" >
									<OPTION VALUE="" <cfif GetRegistration.LastDay IS "">selected </cfif>  ></OPTION>
									<cfloop index="z" from="0" to="365" step="1">
										<cfset pqr = SeasonStartDate + CreateTimeSpan(z, 0, 0, 0)>
										<cfif DateCompare( pqr, SeasonEndDate ) IS 1 >
											<CFBREAK>
										</cfif>			
										<OPTION VALUE="#pqr#" <cfif #DateFormat(SeasonStartDate + CreateTimeSpan(z, 0, 0, 0) , "DDDD, DD MMMM YYYY")#
										IS #DateFormat(GetRegistration.LastDay , "DDDD, DD MMMM YYYY")# >selected </cfif> 
										<cfif StructKeyExists(url, "LDToday")><cfif url.LDToday IS "Yes">
										<cfif #DateFormat(SeasonStartDate + CreateTimeSpan(z, 0, 0, 0) , "DDDD, DD MMMM YYYY")#
										IS #DateFormat(Now() , "DDDD, DD MMMM YYYY")# >selected </cfif>
										</cfif></cfif> >
											#DateFormat( SeasonStartDate + CreateTimeSpan(z, 0, 0, 0) , "DDDD, DD MMMM YYYY")#
										</OPTION>
									</cfloop>
									</select>
								</cfoutput>
							</cfif>
							<cfif GetRegistration.LastDay IS "">
								<cfset TooltipText="Set Last day to #DateFormat(Now(),'DDDD, DD MMMM YYYY')#">
								<cfoutput>
									<a href="RegisterPlayer.cfm?LeagueCode=#LeagueCode#&RI=#url.RI#&LDToday=Yes" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix9">Today</span></a>
								</cfoutput>
							</cfif>
							</td>
					
						</tr>
						<tr>
							<td colspan="2">
								<span class="pix10boldnavy">
									KEEP THE LAST DAY BLANK unless the player has left the club, or the Registration Type is being changed. 
									Do not put in the last day of this season.
								</span>
							</td>
						</tr>
						
						<!--- In Development ......................
						<tr>
							<cfif GetRegistration.LastDay IS "">
								<cfset Date02 = "" >
							<cfelse>
								<cfset Date02 = GetRegistration.LastDay >
							</cfif>
							<td>
								<cfoutput>
									<span class="pix10">
									Please <a href="" onClick="cal1.select(RegisterPlayerForm.LastDay,'anchor1','EE, dd MMM yyyy'); return false;"  NAME="anchor1" ID="anchor1">choose</a> Last day
									<input name="LastDay" type="text" size="30" readonly="true" value="#DateFormat(Date02, "DDDD, DD MMMM YYYY")#" >
									</span>
								</cfoutput>
							</td>					
						</tr>
						--->
						
						<tr>
							<td height="80" align="right"><span class="pix10">Registration Type</span></td>
							<td height="80">
								<SELECT NAME="RegType"  size="1">
					    			<OPTION VALUE="A" <cfif GetRegistration.RegType IS 'A' >selected </cfif>  >Non-Contract</OPTION>
					    			<OPTION VALUE="B" <cfif GetRegistration.RegType IS 'B' >selected </cfif>  >Contract</OPTION>
					    			<OPTION VALUE="C" <cfif GetRegistration.RegType IS 'C' >selected </cfif>  >Short Loan</OPTION>
					    			<OPTION VALUE="D" <cfif GetRegistration.RegType IS 'D' >selected </cfif>  >Long Loan</OPTION>
					    			<OPTION VALUE="E" <cfif GetRegistration.RegType IS 'E' >selected </cfif>  >Work Experience</OPTION>
					    			<OPTION VALUE="G" <cfif GetRegistration.RegType IS 'G' >selected </cfif>  >Lapsed</OPTION>
					    			<OPTION VALUE="F" <cfif GetRegistration.RegType IS 'F' >selected </cfif>  >Temporary</OPTION>
								</select>
							</td>					
						</tr>

						<tr>
							<cfoutput>
								<td>
								<span class="pix13">
								<input type="Submit" name="Action" value="Update"> 
								<cfif StructKeyExists(url, "L")>
									<cfif url.L IS "1" OR url.L IS "2">
										<input type="Submit" name="Action" value="Update Many">
									</cfif>
								</cfif>
								</span>
								</td>
								<td align="right"><cfif QAppearanceC.AppCount GT 0>
								<span class="pix13">
									<cfset AppearanceCount = QAppearanceC.AppCount >
									<input name="Action" type="submit" disabled="true" value="Delete"></span>
								<cfelse>
									<cfset AppearanceCount = 0 >
									<input name="Action" type="submit" value="Delete">
								</cfif>
								</td>
							</cfoutput>
						</tr>
						<cfoutput>
						<cfif AppearanceCount IS 0>
							<tr>
								<td height="40" colspan="2"><span class="pix10">Between #FDate# and #LDate# this player made no appearances.</span></td>
							</tr>
						<cfelseif QAppearanceC.AppCount IS 1>
							<tr>
								<td height="40" colspan="2"><span class="pix10">Between #FDate# and #LDate# this player made one appearance, <a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#">click here</a> to see it.<br />
								If the player has departed then update with the Last day.</span></td>
							</tr>	
						<cfelse>
							<tr>
								<td height="40" colspan="2"><span class="pix10">Between #FDate# and #LDate# this player made #QAppearanceC.AppCount# appearances, <a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#">click here</a> to see them.<br />
								If the player has departed then update with the Last day.</span></td>
							</tr>	
						</cfif>
						<tr>
							<td colspan="2"><span class="pix10">If <em>Registration Type</em> is <strong>Temporary</strong> then leave <em>Last day</em> blank and the system will automatically add five days.</span></td>
						</tr>
						
						</cfoutput>
						
					</table>
				</td>
			</tr>
		</table>
		<!---
		<cfset ThisPlayerID = GetRegistration.PlayerID >
		<cfinclude template="PlayedWhileUnregistered2.cfm">
		--->
	</cfform>
<cfelseif StructKeyExists(form, "StateVector")>
	<cfif Form.StateVector IS 1>
		<cfif Form.Action IS "Update" OR Form.Action IS "Update Many">
		
			<!--- check to see if the first date is greater than the last date! --->
			<cfif FirstDay NEQ "" AND LastDay NEQ "" >
				<cfif Evaluate(DateDiff("D", FirstDay, LastDay)+1) LE 0>
					<span class="pix18boldred"><BR><BR>ERROR: The Last Day is before the First Day<BR><BR>Please click on the Back button of your browser....<BR><BR><BR></span>
					<!--- get rid of any unused registrations (already used higher on page) --->
					<cfinclude template = "queries/del_QDeleteAllEmptyRegistration.cfm">
					<CFABORT>
				</cfif>
			</cfif>
			
			<!--- update the player registration number if necessary .... --->
				<cfif form.NewRegNo NEQ form.RegNo> <!--- did they change the number? --->
					<cfset PlayerRegNo = form.NewRegNo >
					<cfif IsValid("integer", PlayerRegNo)>
					<cfelse>
						<cfoutput>
							<span class="pix18boldred"><br><br>Registration number "#PlayerRegNo#" is invalid. It must be numeric.
							<br><br>
							Please click on the Back button of your browser....
							<br><br><br></span>
						</cfoutput>
						<cfabort>
					</cfif>
					<cfinclude template = "queries/qry_QPlayerRegNo.cfm"> <!--- see if a player already owns the proposed new number --->
					<cfif QPlayerRegNo.RecordCount GT 1><!--- should not be more than one player with the same reg. no.  --->
						ERROR 6428 in RegisterPlayer.cfm
						<cfabort>
					<cfelseif QPlayerRegNo.RecordCount IS 1><!--- yes, the number is already in use --->
						<cfoutput>
							<span class="pix18boldred"><br><br>Registration number #form.NewRegNo# is already used by this player: #QPlayerRegNo.Forename# <u>#QPlayerRegNo.Surname#</u>
							<br><br>
							Please click on the Back button of your browser....
							<br><br><br></span>
						</cfoutput>
						<cfabort>
					<cfelse> QPlayerRegNo.RecordCount IS 0><!--- OK to use the new number so update is done --->
						<cfinclude template = "queries/upd_PlayerRegNo.cfm">
						<cfset form.RegNo = form.NewRegNo >
					</cfif>
				</cfif>

			<!--- let's look at all the registrations for this player, there must be no overlap of date ranges.
			Treat a blank First Day as 01/01/1900. Treat a blank Last Day as 31/12/2999 --->
			<cfinclude template = "queries/qry_QGetOtherRegistrations.cfm">
			<cfif form.FirstDay IS "">
				<cfset Day001 = '1900-01-01'>
			<cfelse>
				<cfset Day001 = form.FirstDay>
			</cfif>
			<cfif form.LastDay IS "">
				<cfset Day002 = '2999-12-31'>
			<cfelse>
				<cfset Day002 = form.LastDay>
			</cfif>
			<cfset request.errorA = 0>
			<cfset request.errorB = 0>
			<cfset request.errorC = 0>
			<cfset request.errorD = 0>
			<!--- separate the components of the proposed TeamID_ClubName using ^ as delimiter --->
			<cfset Form.TeamID = GetToken(TeamID_ClubName, 1, '^' ) >
			<cfset Form.ClubName = GetToken(TeamID_ClubName, 2, '^' ) >
			<table border="1" align="center" cellpadding="5" cellspacing="0">
				<tr>
					<td height="50" colspan="5" align="center" valign="middle"><span class="pix13bold">Existing Registrations</span></td>
				</tr>
				<cfoutput query="QGetOtherRegistrations">
					<cfif DateCompare(Day001,Day1) GE 0 AND DateCompare(Day001,Day2) LE 0>
						<cfset request.errorA = 1>
					</cfif>
					<cfif DateCompare(Day002,Day1) GE 0 AND DateCompare(Day002,Day2) LE 0>
						<cfset request.errorB = 1>
					</cfif>
					<cfif DateCompare(Day1,Day001) GE 0 AND DateCompare(Day1,Day002) LE 0>
						<cfset request.errorC = 1>
					</cfif>
					<cfif DateCompare(Day2,Day001) GE 0 AND DateCompare(Day2,Day002) LE 0>
						<cfset request.errorD = 1>
					</cfif>
					<tr>
						<td><span class="pix13"><!---#RegisterID#---> #ClubName#</span></td>
						<td><span class="pix13">from</span></td>
						<td><span class="pix13">#DateFormat(Day1, 'dddd, dd mmmm yyyy')#</span></td>
						<td><span class="pix13">to</span></td>
						<td><span class="pix13">#DateFormat(Day2, 'dddd, dd mmmm yyyy')#</span></td>
					</tr>
				</cfoutput>
				<tr>
					<td height="50" colspan="5" align="center" valign="middle"><span class="pix13bold">Proposed Registration</span></td>
				</tr>
				<tr>
					<cfoutput>
					<td><span class="pix13">#form.ClubName#</span></td>
					<td><span class="pix13">from</span></td>
					<td><span class="pix13">#DateFormat(Day001, 'dddd, dd mmmm yyyy')#</span></td>
					<td><span class="pix13">to</span></td>
					<td><span class="pix13">#DateFormat(Day002, 'dddd, dd mmmm yyyy')#</span></td>
					</cfoutput>
				</tr>
				<cfif request.errorA + request.errorB + request.errorC + request.errorD GT 0 >
					<tr>
						<td height="50" colspan="5" align="center" valign="middle">
						<cfoutput>
							<span class="pix18boldred">ERROR: Date ranges overlap<br><br></span>
							<span class="pix18bold"><br />Please <a href="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#Form.RegNo#&LastNumber=#Form.RegNo#">click here</a> to continue</span>
						</cfoutput>
						</td>
					</tr>
					<cfabort>
				</cfif>
			</table>
			
			<!--- at this point we are all clear to do the update...... --->
			<cfinclude template = "queries/upd_QUpdateRegistration.cfm">
			<cflock scope="session" timeout="10" type="exclusive">
				<cfif Form.FirstDay IS "">
				<cfelse>
					<cfset session.CurrentDate = #CreateODBCDate(Form.FirstDay)# >
				</cfif>
									
				<cfset session.fmTeamID = Form.TeamID >
			</cflock>
				
			<!--- warn of any appearances while unregistered --->	
			<cfset ThisPlayerID = Form.PlayerID >
			<cfinclude template="PlayedWhileUnregistered2.cfm">
			<cfif PlayedWhileUnregistered2.RecordCount GT 0>
				<cfoutput><span class="pix18bold"><br />Please <a href="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#Form.RegNo#&LastNumber=#Form.RegNo#">click here</a> to continue</span></cfoutput>
				<cfabort>			
			</cfif>
			<cfif Form.Action IS "Update">
				<!--- display the latest info. for this player only --->
				<cflocation URL="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#Form.RegNo#&LastNumber=#Form.RegNo#" addtoken="no">		
			</cfif>
			<cfif Form.Action IS "Update Many">
				<cfif form.L IS 1>
					<cflocation URL="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#Form.TeamID#&SortSeq=Name" addtoken="no">
				<cfelseif form.L IS 2>
					<cflocation URL="RegisteredList2.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#Form.TeamID#&SortSeq=Name" addtoken="no">
				<cfelse>
				<!--- display the latest info. for this player only --->
					<cflocation URL="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#Form.RegNo#&LastNumber=#Form.RegNo#" addtoken="no">		
				</cfif>
			</cfif>
			
		<cfelseif Form.Action IS "Delete">
			<cfinclude template = "queries/del_QDeleteRegistration.cfm">
			
			<!--- warn of any appearances while unregistered --->	
			<cfset ThisPlayerID = Form.PlayerID >
			<cfinclude template="PlayedWhileUnregistered2.cfm">
			<cfif PlayedWhileUnregistered2.RecordCount GT 0>
				<cfoutput><span class="pix18bold"><br />Please <a href="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#Form.RegNo#&LastNumber=#Form.RegNo#">click here</a> to continue</span></cfoutput>
				<cfabort>			
			</cfif>

			<cflocation URL="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode#&FirstNumber=#Form.RegNo#&LastNumber=#Form.RegNo#" addtoken="no">		
		</cfif>

	</cfif>
	
</cfif>


<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
