<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
<cfelse>
	<cfoutput>
		<cflocation url="http://www.mitoo.com/beta?league&leaguecode=#request.CurrentLeagueCodePrefix#&nonko=1" addtoken="no">
	</cfoutput>
	<cfabort>
</cfif>


<cfset ListingClubs = "Yes">
<cfinclude template="InclBegin.cfm">

<!--- The user has selected a Club from the full list of clubs and so we show him/her what competitions
the one or more teams in that club have participated in.
--->
<cfset ClubInfoID = 0 >
<cfset ThisLeagueCodeYear = LeagueCodeYear >

<cfif StructKeyExists(url, "fmTeamID")>
	<cfset request.fmTeamID = #url.fmTeamID#>
	<!--- Set session variables for this Club's originating fmTeamID  --->
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.fmTeamID = #request.fmTeamID#> <!--- e.g. 74 --->
	</cflock>
	<cfinclude template="queries/qry_QClubStuff.cfm">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER">
	
	<cfif ListFind("Silver",request.SecurityLevel) > <!--- JAB Only --->
		
		<!--- Does a teaminfo record exist for this fmTeamID and LeagueInfoID ?
		
		<cfinclude template="queries/qry_QTeamInfo1.cfm">
		<cfif QTeamInfo1.RecordCount IS 0 >
			<tr>
				<td><span class="pix10">No teaminfo record</span></td>
			</tr>
		<cfelseif QTeamInfo1.RecordCount IS 1 >
			<cfoutput>
				<tr>
					<td><span class="pix10">CIID = #QTeamInfo1.CIID#, TIID = #QTeamInfo1.TIID#, LIID = #QTeamInfo1.LIID#</span></td>
				</tr>
			</cfoutput>
			<cfinclude template="queries/qry_QClubInfo1.cfm">
			<cfif QClubInfo1.RecordCount IS 0 >
				<tr>
					<td><span class="pix10">No club umbrella</span></td>
				</tr>
			<cfelseif QClubInfo1.RecordCount IS 1 >
				<cfoutput>
					<tr>
						<td><span class="pix10">#QClubInfo1.ClubName# <cfif QClubInfo1.Location IS ""><cfelse> [#QClubInfo1.Location#]</cfif></span></td>
					</tr>
				</cfoutput>
			</cfif>
		<cfelse>
			ERROR
		</cfif>
		 --->
		<cfinclude template="queries/qry_QClubInfoID.cfm">	
		<cfif QClubInfoID.RecordCount GT 0 >
			<cfset ClubInfoID = QClubInfoID.ClubInfoID >
			 <!--- get all the existing TeamInfo rows for this Club for the currently displayed season so they can be listed --->
			<cfinclude template="queries/qry_QSeasonsTeamInfo.cfm">
			<!--- 						 
				**************************
				* Table of TeamInfo rows *
				**************************
			--->
			<cfif QSeasonsTeamInfo.RecordCount GT 0>
				<tr>
					<td align="left">
						<table  bgcolor="white" border="1" align="center" cellpadding="4" cellspacing="0" >
							<tr>
								<cfoutput>
									<td colspan="3" align="center" valign="middle"><span class="pix13boldrealblack">#QClubInfoID.ClubName# - #QSeasonsTeamInfo.SeasonName#</span></td>
								</cfoutput>
							</tr>
							<cfoutput query="QSeasonsTeamInfo">
								<cfif request.fmTeamID IS QSeasonsTeamInfo.fmTeamID>
									 <!---  show the current ClubList team greyed out --->
									<!---  Identify the "fmnnnn" datasource, e.g. fm2004, and then get the Team LongCol e.g. "Reds United" 	--->
									<cfinclude template="queries/qry_QTeamLongCol.cfm"> 
									<tr bgcolor="#bg_highlight#" class="pix10">
										<td>#QTeamLongCol.LongCol#</td>
										<td>#QSeasonsTeamInfo.NameSort#</td>
									</tr>
								<cfelse>
									<!---  Identify the "fmnnnn" datasource, e.g. fm2004, and then get the Team LongCol e.g. "Reds United" 	--->
									<cfinclude template="queries/qry_QTeamLongCol.cfm"> 
									<tr class="pix10">
										<td>#QTeamLongCol.LongCol#</td>
										<td><a href="ClubList.cfm?fmTeamID=#QSeasonsTeamInfo.fmTeamID#&LeagueCode=#QSeasonsTeamInfo.DefaultLeagueCode#">#QSeasonsTeamInfo.NameSort#</a></td>
									</tr>
								</cfif>
							</cfoutput>
						</table>
					</td>
				</tr>
			</cfif>
		<cfelse>
				<tr>
					<td>
						<table  bgcolor="white" border="1" align="center" cellpadding="4" cellspacing="0" >
							<tr>
								<cfoutput>
									<td colspan="3" align="center" valign="middle"><span class="pix18boldred">NO CLUB UMBRELLA</span></td>
								</cfoutput>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table  bgcolor="white" border="1" align="center" cellpadding="4" cellspacing="0" >
							<tr>
								<cfoutput>
									<td colspan="3" align="center" valign="middle"><span class="pix13realblack">searching for "#QClubStuff.ClubName#" ....</span></td>
								</cfoutput>
							</tr>
						</table>
					</td>
				</tr>
		</cfif>
	</cfif> <!--- "Silver" only --->
	
	
	<cfoutput query="QClubStuff" group="ClubName">
		<cfif HomeGuest IS "Guest">
			<tr>
				<td align="CENTER"><span class="pix24bold"><em>#ClubName# - GUEST TEAM</em></span></td>
			</tr>
		<cfelse>
			<tr>
				<td align="CENTER"><span class="pix24bold">#ClubName#</span></td>
			</tr>
		</cfif>
		<tr>
			<td align="CENTER">
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
				<span class="pix10bold">#ParentCountyFA# #AffiliationNo#<br><br></span>
			</td>
		</tr>
		<cfif Len(Trim(TeamInfo)) GT 0 >
			<tr>
				<td align="left">
					<table width="30%" border="0" align="center" cellpadding="2" cellspacing="0">
						<tr>
							<td align="center"><span class="pix10">#TeamInfo#</span></td>
						</tr>
					</table>
				</td>
			</tr>
		</cfif>
		
		<cfset AllEmailString = "">
		<cfoutput group="OrdnlName">
			
			<cfif HomeGuest IS "Guest">
				<cfif Len(Trim(OrdnlName)) GT 0>
					<tr bgcolor="white">
						<td height="40" align="center"><span class="pix18bold"><em>#OrdnlName#</em></span></td>
					</tr>
				</cfif>
			<cfelse>
				<cfif Len(Trim(OrdnlName)) GT 0>
					<tr bgcolor="white">
						<td height="40" align="center"><span class="pix18bold">#OrdnlName#</span></td>
					</tr>
				</cfif>
			</cfif>
			
			<!--- Team Unavailable Dates --->
			<cfinclude template="queries/qry_QTeamUnavailableDates.cfm">	
			<tr>
				<td align="center">
					<table border="1" align="center" cellpadding="2" cellspacing="0">
						<cfloop query="QTeamUnavailableDates">
								<tr><td align="left">&nbsp;<img src="gif/unavailable.gif">&nbsp;&nbsp;<span class="pix13bold">#DateFormat(FreeDate, "DDDD, DD MMMM YYYY")#</span></td></tr>
						</cfloop>
					</table>
				</td>
			</tr>
			
			<tr>
				<td>
					<table border="0" align="center" cellpadding="2" cellspacing="0" >
						<tr>
							<td align="center" valign="middle" bgcolor="silver"><span class="pix13boldnavy">Competitions</span></td>
						</tr>
						<cfoutput>
							<cfset SponsorTokenStart = FindNoCase( "Sponsor[", DivNotes)>
							<cfset SquareBracketEnd = FindNoCase( "]", DivNotes)>
							<cfif SponsorTokenStart GT 0 AND SquareBracketEnd GT SponsorTokenStart >
								<cfset SponsorTokenEnd = Find( "]", DivNotes, SponsorTokenStart )>
								<cfset SponsorTokenLength = SponsorTokenEnd - SponsorTokenStart - 8>
								<cfset SponsoredByText = " sponsored by #Trim(MID(DivNotes, SponsorTokenStart+8, SponsorTokenLength))#" >
							<cfelse>
								<cfset SponsoredByText = "">
							</cfif>
							<cfset ThisDivName = "#DivnName##SponsoredByText#">
							<tr>
								<td bgcolor="silver"><span class="pix13boldrealblack">#ThisDivName#</span></td>
							</tr>
							<cfif ListFind("Silver",request.SecurityLevel) > <!--- JAB Only --->
								<tr>
									<td>
										<a href="ConstitList.cfm?TblName=Constitution&LeagueCode=#LeagueCode#&DivisionID=#DivisionID#"><span class="pix10bold">Update Constitution - JAB Only</span></a>
									</td>
								</tr>
							</cfif>
						</cfoutput>
					</table>
				</td>
			</tr>
			<!--- Need to be logged in as administrator to see "Update Details" link --->
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<tr>
					<td>
						<table border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="beige">
							<tr>
								<td align="center" bgcolor="thistle"><span class="pix13boldnavy">To add, update or delete team details <cfif VenueAndPitchAvailable IS "Yes">and to see Pitch Availability calendar </cfif><a href="TeamDetailsUpdate.cfm?LeagueCode=#LeagueCode#&TID=#TeamID#&OID=#OrdinalID#"><u>click here</u></a></span></td>
							</tr>
						</table>
					</td>
				</tr>
			</cfif>
			<cfset ThisPA = "Team">
			<cfset ThisTeamID = QClubStuff.TeamID >
			<cfset ThisOrdinalID = QClubStuff.OrdinalID >
			<cfinclude template="queries/qry_TeamDetails.cfm">
			<cfif QTeamDetails.RecordCount GT 0>
				<tr>
					<td align="left">
						<table border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="beige">
							<cfloop query="QTeamDetails">
								<cfinclude template="TeamDetailsLoop.cfm">
								<cfif Len(Trim(ThisEmailString)) GT 0>
									<cfset AllEmailString = "#AllEmailString##ThisEmailString#," >
								</cfif>
							</cfloop>
						</table>
					</td>
				</tr>
			</cfif>
			<cfif VenueAndPitchAvailable IS "Yes" AND UCase(HomeGuest) IS NOT "GUEST">
				<cfinclude template="queries/qry_QPitchAvailable.cfm">
				<cfif QPitchAvailable.RecordCount IS 0>
					<tr>
						<td>
							<table border="1" align="center" cellpadding="2" cellspacing="0" bgcolor="lightgreen">
								<tr><td><span class="pix13boldred">No Home Pitch Availability</span></td></tr>
							</table>
						</td>
					</tr>
				<cfelse>
					<cfinclude template="queries/qry_QVenueInfo.cfm">
					<cfset VenueList = ValueList(QVenueInfo.VenueName)>
					<cfset HVIDList = ValueList(QVenueInfo.HVID)>
					<tr>
						<td height="10">&nbsp;</td>
					</tr>
					<tr>
						<td>
							<table border="0" align="center" cellpadding="3" cellspacing="3" bgcolor="lightgreen">
								<cfloop index="x" from="1" to="#QVenueInfo.RecordCount#" step="1" >
								<cfif ListGetAt(VenueList,x) IS "*UNKNOWN*">
								<cfelse>
									<tr>
										<td><span class="pix13boldrealblack">#ListGetAt(VenueList,x)# </span></td>
										<td><a href="javascript:void window.open('VenueInformation.cfm?ID=#ListGetAt(HVIDList,x)#&LeagueCode=#LeagueCode#','VenueInformation','height=700,width=450,left=50,top=50,resizable=yes,scrollbars=yes').focus()"><img src="gif/VenueInformation.gif" alt="Venue Information" border="1"  align="absmiddle"></a></td>
									</tr>
								</cfif>
								</cfloop>
								
							</table>
						</td>
					</tr>
					<tr>
						<td height="10">&nbsp;</td>
					</tr>
					<cfset VenueNameList = ValueList(QPitchAvailable.VenueName)>
					<cfset PitchNameList = ValueList(QPitchAvailable.PitchName)>
					<cfset PitchStatusList = ValueList(QPitchAvailable.PitchStatus)>
					<cfset BookingDateList = ValueList(QPitchAvailable.BookingDate)>
					<tr>
						<td>
							<table border="1" align="center" cellpadding="2" cellspacing="0" bgcolor="lightgreen">
								<tr>
									<td colspan="4" align="center"><span class="pix10">Please immediately advise the Fixture Secretary of any changes</span></td>
								</tr>
							
								<tr>
									<td colspan="4" align="center"><span class="pix10bold">Home Pitch Availability</span></td>
								</tr>
								<tr>
									<td><span class="pix10">Date</span></td>
									<td><span class="pix10">Venue</span></td>
									<td><span class="pix10">Pitch</span></td>
									<td><span class="pix10">Status</span></td>
								</tr>
								<cfloop index="x" from="1" to="#QPitchAvailable.RecordCount#" step="1" >
									<cfif ListGetAt(VenueNameList,x) IS "*UNKNOWN*">
										<tr>
											<td><span class="pix10">#DateFormat(ListGetAt(BookingDateList,x),'DDDD, DD MMMM YYYY')#</span></td>
											<td colspan="3" bgcolor="white"><span class="pix10">not specified</span></td>
										</tr>
									<cfelse>								
										<tr>
											<td><span class="pix10">#DateFormat(ListGetAt(BookingDateList,x),'DDDD, DD MMMM YYYY')#</span></td>
											<td><span class="pix10">#ListGetAt(VenueNameList,x)#</span></td>
											<td><span class="pix10">#ListGetAt(PitchNameList,x)#</span></td>
											<td><span class="pix10">#ListGetAt(PitchStatusList,x)#</span></td>
										</tr>
									</cfif>
								</cfloop>
							</table>
						</td>
					</tr>
				</cfif>
			</cfif>
		</cfoutput>
		<cfset LenAllEmailString = Len(Trim(AllEmailString))>
		<cfif LenAllEmailString GT 0>
			<cfset AllEmailString = Left(AllEmailString, (LenAllEmailString-1))>
			<tr>
				<td>
					<table border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="beige">
						<tr>
							<td height="40" colspan="2" align="center"><span class="pix10bold">#TN#<br><a href="mailto:#AllEmailString#?subject=#TN# - #LN#">Email All Contacts</a></span></td>
						</tr>
					</table>
				</td>
			</tr>
		</cfif>

	</cfoutput>

<cfelse>
	<!--- Set session variables for this Club's originating fmTeamID --->
	<cfset request.fmTeamID = 0>
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.fmTeamID = #request.fmTeamID#>
	</cflock>
</cfif>		
<!---
							**************************************************************
							* Produce the full Club list across the bottom of the screen *
							* in four columns (variable, see NoOfCols)					 *
							**************************************************************
--->
<cfinclude template="queries/qry_QClubList.cfm">
<cfif QClubList.RecordCount IS "0" >
		<cfoutput><span class="pix13boldrealblack">No Clubs found - try adding some first!</span></cfoutput>
		<!--- <CFABORT> --->
<cfelse>
	<cfset ClubCount = QClubList.RecordCount>
	<cfset NoOfCols = 4>
	<cfif ClubCount Mod NoOfCols IS 0 >
		<cfset NoOfClubsPerCol = ClubCount / NoOfCols>
	<cfelse>
		<cfset NoOfClubsPerCol = Round((ClubCount / NoOfCols)+ 0.5) >
	</cfif>
	<!---
	<cfoutput>
	<span class="pix10red">Club Count is #ClubCount#<br>Number of Columns is #NoOfCols#<br>Number of Clubs per Column is #NoOfClubsPerCol#<br></span>
	</cfoutput>
	--->
	<cfset ClubList=ValueList(QClubList.Longcol)>
	<cfset GuestList=ValueList(QClubList.Guest)>
	<cfset RedundantTeamList=ValueList(QClubList.RedundantTeam)>	
	<cfset HasAMapList=ValueList(QClubList.HasAMap)>
	<cfset HasAWebsiteList=ValueList(QClubList.HasAWebsite)>
	<cfset IDList=ValueList(QClubList.ID)>
	<cfoutput>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER">
		<cfif request.fmTeamID GT 0>
			<tr>
				<td height="30" align="center" colspan="#NoOfCols#">
					<span class="pix13realblack">To remove <span class="bg_highlight">highlight</span> click on <b>Clubs</b> (top right hand corner)</span>
				</td>
			</tr>
		<cfelse>
			<tr>
				<td height="30" align="center" colspan="#NoOfCols#">
					<span class="pix13realblack">To <span class="bg_highlight">highlight your club</span> in all screens click on its name in the list below.</span>
				</td>
			</tr>
		</cfif>
		<tr valign="TOP">
			<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
				<cfset xxx=((#ColN#-1) * #NoOfClubsPerCol#)+1>
				<cfset yyy=MIN((#ColN# * #NoOfClubsPerCol#),#ClubCount#)>
				<td align="left">
					<table border="0" cellspacing="0" cellpadding="0" >
						<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
							<tr>
								<cfset Thisbgcolor = "white">
								<!--- <cfif StructKeyExists(url, "fmTeamID")> --->
								<cfif #ListGetAt(IDList, RowN)# IS "#request.fmTeamID#" >
									<cfset Thisbgcolor = "bg_highlight">
								</cfif>
								<!--- </cfif> --->
								<td class="#Thisbgcolor#">
									<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
										<a href="UpdateForm.cfm?TblName=Team&ID=#ListGetAt(IDList, RowN)#&LeagueCode=#LeagueCode#&Whence=CI"><span class="pix9">upd/del</span></a>
									</cfif>
<!---
							******************************************************
							* Club link - its appearance will indicate the state *
							* of the number or teams and leagues involved under  *
							* the club umbrella              					 *
							******************************************************
--->
								<cfif ListFind("Silver",request.SecurityLevel) >
									<!--- ignore guest teams --->
									<cfif ListGetAt(GuestList, RowN) IS "No">
										<cfinclude template="queries/qry_QTeamInfo2.cfm">
										<cfif QTeamInfo2.RecordCount IS 0 >
											<!--- no clubinfo record found, Club link shows in bold red and not underlined --->
											<span class="pix10boldred">Club</span>
										<cfelseif QTeamInfo2.RecordCount IS 1 >
											<cfset ToolTipText = "Parent Club: #QTeamInfo2.Clubname#<br>">
											<cfif Len(QTeamInfo2.Location) GT 0 >
												<cfset ToolTipText = "#ToolTipText# [#QTeamInfo2.Location#]">
											</cfif>
											<cfset ToolTipText = "#ReplaceList(ToolTipText, Chr(38), '& ')#" > <!--- & --->
											
											<!--- normal: one clubinfo record found --->
											<cfset ClubInfoID = QTeamInfo2.ClubInfoID >
											 <!--- get all the existing TeamInfo rows for this Club for the currently displayed season so they can be listed --->
											<cfinclude template="queries/qry_QSeasonsTeamInfo.cfm">
											<cfif QSeasonsTeamInfo.RecordCount GT 0>
												<cfset LinkText = "Club">
												<cfif QSeasonsTeamInfo.RecordCount GT 1>
													<cfset ToolTipText = "#ToolTipText#<hr>see also ...">
													<cfset LinkText = "*Club">
												</cfif> 
											
												<cfloop query="QSeasonsTeamInfo">
													<cfset fmTeamID = QSeasonsTeamInfo.fmTeamID>
													<cfinclude template="queries/qry_QTeamLongCol.cfm">
													<cfif QSeasonsTeamInfo.LeagueInfoID IS request.LeagueID>
													<cfelse>
														<cfset ToolTipText = "#ToolTipText#<br>#QSeasonsTeamInfo.NameSort# (#QTeamLongCol.LongCol#)">
														<cfset ToolTipText = "#ReplaceList(ToolTipText, Chr(38), '& ')#" > <!--- & --->
													</cfif>
												</cfloop>
											<cfelse>
												<cfset LinkText = "ERROR">
											</cfif>
											<cfif Len(QTeamInfo2.Location) GT 0 >
												<a href="" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=600;return escape('#ToolTipText#')"><span class="pix9"><strong><em>#LinkText#</em></strong></span></a>
											<cfelseif QTeamInfo2.Clubname IS ListGetAt(ClubList, RowN) >
												<a href="" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=600;return escape('#ToolTipText#')"><span class="pix9">#LinkText#</span></a>
											<cfelse>
												<a href="" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=600;return escape('#ToolTipText#')"><span class="pix9"><strong>#LinkText#</strong></span></a>
											</cfif>
										<cfelse>
											<!--- multiple clubinfo records found, should never happen --->
											<span class="pix10boldred">bad</span>
										</cfif>
									</cfif>
								</cfif>



									<cfif ListGetAt(GuestList, RowN) IS "Yes"> <!--- GUEST TEAM  displayed in italics --->
										<span class="pix10">&nbsp;</span>
										<cfif ListGetAt(RedundantTeamList, RowN) IS "Yes"> <!--- REDUNDANT displayed in silver --->
											<span class="pix13silver"><em>#ListGetAt(ClubList, RowN)#</em></span>
										<cfelse> <!--- NOT REDUNDANT --->
											<a href="ClubList.cfm?fmTeamID=#ListGetAt(IDList, RowN)#&LeagueCode=#LeagueCode#"><span class="pix13realblack"><em>#ListGetAt(ClubList, RowN)#</em></span></a>
										</cfif>
									<cfelse> <!--- NOT A GUEST TEAM --->
										<span class="pix10">&nbsp;</span>
										<cfif ListGetAt(RedundantTeamList, RowN) IS "Yes"> <!--- REDUNDANT displayed in silver --->
											<span class="pix13silver">#ListGetAt(ClubList, RowN)#</span>
										<cfelse> <!--- NOT REDUNDANT --->
											<a href="ClubList.cfm?fmTeamID=#ListGetAt(IDList, RowN)#&LeagueCode=#LeagueCode#"><span class="pix13realblack">#ListGetAt(ClubList, RowN)#</span></a>
										</cfif>
									</cfif>		
									<cfif ListGetAt(HasAMapList, RowN) IS "Yes"><span class="pix10red">M</span></cfif>
									<cfif ListGetAt(HasAWebsiteList, RowN) IS "Yes"><span class="pix10red">W</span></cfif>
								</td>
							</tr>
						</cfloop>
					</table>
				</td>
			</cfloop>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" >
		<tr align="center">
			<td align="center" valign="middle" bgcolor="aqua">
				<table width="30%" border="0" cellspacing="5" cellpadding="2" align="CENTER">
					<tr>
						<td align="center" bgcolor="white">
							<cfset ToolTipText = "#LeagueName#<br>Names and contact details of people on the management committee.">
							<a href="ShowContacts.cfm?LeagueCode=#LeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="#LeagueCode#Contacts" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=600;return escape('#TooltipText#')"><span class="pix13bold">Contacts</span></a>
						</td>
						<td align="center" bgcolor="white">
							<cfset TooltipText="Search for a club on <em>football.mitoo</em> in #SeasonName#."> 
							<a href="SearchClubForm.cfm?LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=600;return escape('#TooltipText#')"><span class="pix13bold">Search</span></a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<cfif ListFind("Silver",request.SecurityLevel)> <!--- JAB Only --->
			<tr align="left">
				<cfset NonGuestTeamsToBeDeletedCount = 0>
				<cfset DeletionIDs = "">
				<td bgcolor="silver" align="left"> 
					<span class="pix13realblack">
						<cfloop index="k" from="1" to="#ClubCount#">
							<cfif #ListGetAt(RedundantTeamList, k)# IS "Yes" AND #ListGetAt(GuestList, k)# IS "No">
								#ListGetAt(ClubList, k)# (#ListGetAt(IDList, k)#)<br>
								<cfset NonGuestTeamsToBeDeletedCount = NonGuestTeamsToBeDeletedCount + 1>
								<cfset DeletionIDs = "#DeletionIDs##ListGetAt(IDList, k)#,">
							</cfif>
						</cfloop>
						<cfif NonGuestTeamsToBeDeletedCount GT 0>
							<cfset TheseIDs = "">
							<cfset ThisMany = 10>
							<cfloop index="m" from="1" to="#MIN(ListLen(DeletionIDs),ThisMany)#" > <!--- can only cope with ten at a time --->
								<cfset TheseIDs = "#TheseIDs##ListGetAt(DeletionIDs, m)#," >
							</cfloop>
							 <br>JAB Only: <a href="DeleteUnwantedTeams.cfm?LeagueCode=#LeagueCode#&DeletionIDs=#TheseIDs#">Delete</a> #NonGuestTeamsToBeDeletedCount# Non-Guest teams #ThisMany# at a time.
						</cfif>
					</span>
				</td>
			</tr>
			<tr>
				<td height="20" bgcolor="silver"><span class="pix10">&nbsp;</span></td>
			</tr>
			<tr>
				<cfset GuestTeamsToBeDeletedCount = 0>
				<cfset DeletionIDs = "">
				<td bgcolor="silver" align="left">
					<span class="pix13realblack">
						<cfloop index="k" from="1" to="#ClubCount#">
							<cfif #ListGetAt(RedundantTeamList, k)# IS "Yes" AND #ListGetAt(GuestList, k)# IS "Yes">
								#ListGetAt(ClubList, k)# (#ListGetAt(IDList, k)#)<br>
								<cfset GuestTeamsToBeDeletedCount = GuestTeamsToBeDeletedCount + 1>
								<cfset DeletionIDs = "#DeletionIDs##ListGetAt(IDList, k)#,">
							</cfif>
						</cfloop>
						<cfif GuestTeamsToBeDeletedCount GT 0>
							<cfset TheseIDs = "">
							<cfset ThisMany = 10>
							<cfloop index="m" from="1" to="#MIN(ListLen(DeletionIDs),ThisMany)#" > <!--- can only cope with ten at a time --->
								<cfset TheseIDs = "#TheseIDs##ListGetAt(DeletionIDs, m)#," >
							</cfloop>
							 <br>JAB Only: <a href="DeleteUnwantedTeams.cfm?LeagueCode=#LeagueCode#&DeletionIDs=#TheseIDs#">Delete</a> #GuestTeamsToBeDeletedCount# Guest teams #ThisMany# at a time.
						</cfif>
					</span>
				</td>
			</tr>
			<tr>
				<td height="20" bgcolor="silver"><span class="pix10">&nbsp;</span></td>
			</tr>
			
		</cfif>
		
		
	</table>			
	</cfoutput>
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" >
	<tr>
		<td align="CENTER">
			<span class="pix10red">M = map link available, W = website link available</span>
		</td>
	</tr>
</table>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
