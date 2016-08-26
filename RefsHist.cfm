<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.RefsID = RI >
</cflock>
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.RefsID = session.RefsID > 
	<!--- <cfset request.fmTeamID = session.fmTeamID > --->
	<cfset request.LeagueType = session.LeagueType >
	<cfset request.RefMarksOutOfHundred = session.RefMarksOutOfHundred>
</cflock>


<cfinclude template="queries/qry_QReferee_v1.cfm">
<cfset RefsHist = "Yes">  <!--- a switch to tell the Heading in Toolbar2 that it's a Referee's History --->
<cfinclude template="InclBegin.cfm">
<!--- After putting the Referee's name in Toolbar2, clear it out ready for the UpdateForm.cfm screen --->
<!---
Get information on marks awarded to this referee across ALL the Matches officiated by the specified Referee
across ALL competitions
--->
<cfinclude template="queries/qry_QRefereeGrades.cfm">
<cfinclude template="queries/qry_QAsstRef1Grades.cfm">
<cfinclude template="queries/qry_QAsstRef2Grades.cfm">
<cfinclude template="queries/qry_QRefereeHistory.cfm">

				<cfswitch expression="#request.LeagueType#">
					<cfcase value="Normal">
						<cfif #QRefereeGrades.SumRefereeMarksH# IS "">
							<cfset RefMarksH = 0>
						<cfelse>
							<cfset RefMarksH = #QRefereeGrades.SumRefereeMarksH#>
						</cfif>
						<cfif #QRefereeGrades.SumRefereeMarksA# IS "">
							<cfset RefMarksA = 0>
						<cfelse>
							<cfset RefMarksA = #QRefereeGrades.SumRefereeMarksA#>
						</cfif>
						<cfset Value000 = RefMarksH + RefMarksA >
						<cfif #QAsstRef1Grades.SumAsstRef1Marks# IS "">
							<cfset Value001 = 0>
						<cfelse>
							<cfset Value001 = #QAsstRef1Grades.SumAsstRef1Marks#>
						</cfif>
						<cfif #QAsstRef2Grades.SumAsstRef2Marks# IS "">
							<cfset Value002 = 0>
						<cfelse>
							<cfset Value002 = #QAsstRef2Grades.SumAsstRef2Marks#>
						</cfif>
						<cfset ARMarkedGames = QAsstRef1Grades.AsstRef1MarkedGames + QAsstRef2Grades.AsstRef2MarkedGames>
					</cfcase>
					<cfcase value="Contributory">
						<!--- Referee H --->
						<cfif #QRefereeGrades.SumRefereeMarksH# IS "">
							<cfset RefMarksH = 0>
						<cfelse>
							<cfset RefMarksH = #QRefereeGrades.SumRefereeMarksH#>
						</cfif>
						<!--- Referee A --->
						<cfif #QRefereeGrades.SumRefereeMarksA# IS "">
							<cfset RefMarksA = 0>
						<cfelse>
							<cfset RefMarksA = #QRefereeGrades.SumRefereeMarksA#>
						</cfif>
						
						<cfset Value000 = RefMarksH + RefMarksA >
						
						<!--- Assistant1 H --->
						<cfif #QAsstRef1Grades.SumAsstRef1MarksH# IS "">
							<cfset Value001H = 0>
						<cfelse>
							<cfset Value001H = #QAsstRef1Grades.SumAsstRef1MarksH#>
						</cfif>
						<!--- Assistant1 A --->
						<cfif #QAsstRef1Grades.SumAsstRef1MarksA# IS "">
							<cfset Value001A = 0>
						<cfelse>
							<cfset Value001A = #QAsstRef1Grades.SumAsstRef1MarksA#>
						</cfif>
						<!--- Assistant2 H --->
						<cfif #QAsstRef2Grades.SumAsstRef2MarksH# IS "">
							<cfset Value002H = 0>
						<cfelse>
							<cfset Value002H = #QAsstRef2Grades.SumAsstRef2MarksH#>
						</cfif>
						<!--- Assistant2 A --->
						<cfif #QAsstRef2Grades.SumAsstRef2MarksA# IS "">
							<cfset Value002A = 0>
						<cfelse>
							<cfset Value002A = #QAsstRef2Grades.SumAsstRef2MarksA#>
						</cfif>

						<cfset Value001 = Value001H + Value001A>
						<cfset Value002 = Value002H + Value002A>
						<cfset ARMarkedGames = QAsstRef1Grades.AsstRef1MarkedGamesH + QAsstRef1Grades.AsstRef1MarkedGamesA 
											+  QAsstRef2Grades.AsstRef2MarkedGamesH + QAsstRef2Grades.AsstRef2MarkedGamesA >
					</cfcase>
					<cfdefaultcase>
						Reached defaultcase in RefsHist - Aborting
						<CFABORT>	
					</cfdefaultcase>
				</cfswitch>


<cfif QRefereeHistory.RecordCount IS "0">
	<span class="pix18">No history.</span>
<cfelse>
	<!--- display the query result set as a table with the appropriate headings ---> 
	
	<BR>
	<table border="1" cellspacing="0" cellpadding="5" align="CENTER"  class="loggedinScreen">
		<tr>
			<cfoutput>
				<td><span class="pix13boldnavy">#QReferee.RefsName#<br /></span><span class="pix10boldnavy">#QReferee.RefDetails#</span></td>
				<td>
					<span class="pix10boldnavy">
						<cfif QReferee.Level GT 0>Level #QReferee.Level#<cfelse>&nbsp;</cfif>
						<cfif QReferee.PromotionCandidate IS "Yes"><br />Promotion Candidate</cfif>
					</span>
				</td>					
				<cfset EmailSubject = URLEncodedFormat("Referee: #QReferee.RefsName#    #LeagueName#") >
				<td align="center">
					<span class="pix10">
						<cfif LEN(QReferee.EmailAddress1) GT 0 AND LEN(QReferee.EmailAddress2) GT 0 >
							<a href="mailto:#TRIM(QReferee.EmailAddress1)#?cc=#TRIM(QReferee.EmailAddress2)#&subject=#EmailSubject#">Send an email</a>
						<cfelseif LEN(QReferee.EmailAddress1) GT 0>
							<a href="mailto:#TRIM(QReferee.EmailAddress1)#?subject=#EmailSubject#">Send an email</a>
						<cfelseif LEN(QReferee.EmailAddress2) GT 0>
							<a href="mailto:#TRIM(QReferee.EmailAddress2)#?subject=#EmailSubject#">Send an email</a>
						<cfelse>
							No Email
						</cfif>
					</span>
				</td>
				<td align="center"><span class="pix10"><a href="UpdateForm.cfm?TblName=Referee&ID=#RI#&LeagueCode=#LeagueCode#">Update Details</a></span></td>
			</cfoutput>
		</tr>
		<cfif Len(Trim(QReferee.PostCode)) GT 0 >
			<tr>
				<td width="500" colspan="4"><span class="pix10">
				<cfoutput>
				Referee location <a href="http://www.streetmap.co.uk/streetmap.dll?postcode2map?#URLEncodedFormat(QReferee.PostCode)#" target="_blank">see map</a>
				</cfoutput>
				</span></td>
			</tr>
		</cfif>
		
		<cfif Len(Trim(QReferee.Restrictions)) GT 0 >
			<tr>
				<td width="500" colspan="4"><span class="pix10">
				<cfoutput>
				<b>#QReferee.Restrictions#</b>
				</cfoutput>
				</span></td>
			</tr>
		</cfif>
		<cfif Len(Trim(QReferee.RefsNotes)) GT 0 >
			<tr>
				<td width="500" colspan="4"><span class="pix10">
				<cfoutput>
				Notes for publication: #QReferee.RefsNotes#
				</cfoutput>
				</span></td>
			</tr>
		</cfif>
	
		<tr>
			<td><span class="pix13">&nbsp;</span></td>
			<td align="CENTER"><span class="pix13bold">Total<BR>Marks</span></td>
			<td align="CENTER"><span class="pix13bold">Number of<BR>Marks</span></td>
			<td align="CENTER"><span class="pix13bold">Average<BR>Marks</span></td>
		</tr>
		<tr>
			<td><span class="pix13bold">As Referee:</span></td>
			<td align="CENTER"><span class="pix13"><cfoutput>#NumberFormat(Value000,"9999")#</cfoutput></span></td>
			<cfset RefereeMarkedGames = QRefereeGrades.RefereeMarkedGamesH + QRefereeGrades.RefereeMarkedGamesA >
			<td align="CENTER"><span class="pix13"><cfoutput>#RefereeMarkedGames#</cfoutput></span></td>
			<td align="CENTER"><span class="pix13">
			<cfif RefereeMarkedGames IS NOT 0>
				<cfoutput>#NumberFormat( Value000 / RefereeMarkedGames ,"99.999")#</cfoutput>
			<cfelse>&nbsp;
			</cfif></span></td>
		</tr>
		<tr>
			<td><span class="pix13bold">As Assistant Referee:</span></td>
			<td align="CENTER"><span class="pix13"><cfoutput>#Evaluate(Value001 + Value002)#</cfoutput></span></td>
			<td align="CENTER"><span class="pix13"><cfoutput>#ARMarkedGames#</cfoutput></span></td>
			<td align="CENTER"><span class="pix13">
			<cfif ARMarkedGames IS NOT 0>
			<cfoutput>#NumberFormat( (Value001 + Value002) / ARMarkedGames ,"99.999")#</cfoutput>
			<cfelse>&nbsp;
			</cfif></span></td>
		</tr>
		<tr>
			<td colspan="4" align="center"><img src="images/icon_referee.png" border="0" align="middle"> <a href=<cfoutput>"RefsRanking.cfm?RI=#request.RefsID#&LeagueCode=#LeagueCode#"</cfoutput>><span class="pix10">Referee's Ranking</span></a>
			&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/icon_line1.png" border="0" align="middle"> <img src="images/icon_line2.png" border="0" align="middle">
			<a href=<cfoutput>"AsstRefsRanking.cfm?RI=#request.RefsID#&LeagueCode=#LeagueCode#"</cfoutput>><span class="pix10">Assistant Referee's Ranking</span></a>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="2" cellpadding="0"  class="loggedinScreen">
	<tr>
		<td>
		<span class="pix13bold"><cfoutput>#QRefereeHistory.RecordCount#</cfoutput> in list<BR></span>
		</td>
	</tr>
	<cfoutput query="QRefereeHistory" >
		<cfset Highlight = "No">
		<cfif request.fmTeamID IS HomeTeamID>
			<cfset Highlight = "Yes">
		</cfif>
		<cfif request.fmTeamID IS AwayTeamID>
			<cfset Highlight = "Yes">
		</cfif>
		<tr>
			<td align="left"<cfif Highlight>class="bg_highlight"</cfif> >
				<span class="pix13">#CompetitionName#</span>
				<cfif TRIM(#RoundName#)IS NOT "" >
					 <span class="pix13"><BR>#RoundName#</span>
				</cfif>
			</td>
			<td align="right" <cfif Highlight>class="bg_highlight"</cfif> >
			  <span class="pix10red">#HomeSportsmanshipMarks#</span>
			</td>
			<td align="right" <cfif Highlight>class="bg_highlight"</cfif> >
				<cfset ToolTipText = "Click to see the Home Team Sheet.">
				<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H"><span class="pix13">#HomeTeam# #HomeOrdinal#</span></a>
			</td>
			<cfif Result IS "P">
				<td colspan="2" align="center"><span class="pix18boldgray">P</span></td>
			<cfelseif Result IS "Q">
				<td colspan="2" align="center"><span class="pix18boldgray">A</span></td>
			<cfelseif Result IS "W">
				<td colspan="2" align="center"><span class="pix18boldgray">V</span></td>
			<cfelseif Result IS "T">
				<td colspan="2" align="center" bgcolor="aqua"><span class="pix18boldgray">TEMP</span></td>
			<cfelse>
				<td align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> >
					<span class="pix13">
					<cfif Result IS "H" >
						H
					<cfelseif Result IS "A" >
						-
					<cfelseif Result IS "D" >
						D 
					<cfelse>
						&nbsp;#HomeGoals#&nbsp;
					</cfif>
					</span>
				</td>
				<td align="CENTER" <cfif Highlight>class="bg_highlight"</cfif> >
					<span class="pix13">
					<cfif Result IS "H" >
						-
					<cfelseif Result IS "A" >
						A
					<cfelseif Result IS "D" >
						D 
					<cfelse>
						&nbsp;#AwayGoals#&nbsp;
					</cfif> 
					</span>		
				</td>
			</cfif>
			
			<td align="left" <cfif Highlight>class="bg_highlight"</cfif> >
				<cfset ToolTipText = "Click to see the Away Team Sheet.">
				<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A">
				<span class="pix13">
				#AwayTeam# #AwayOrdinal#
				<cfif Result IS "H" >[ Home Win was awarded ]
				<cfelseif Result IS "A" >[ Away Win was awarded ]
				<cfelseif Result IS "U" >[ Home Win on penalties ]
				<cfelseif Result IS "V" >[ Away Win on penalties ]
				<cfelseif Result IS "D" >[ Draw was awarded ]
				<cfelseif Result IS "P" >[ Postponed ]
				<cfelseif Result IS "Q" >[ Abandoned ]
				<cfelseif Result IS "W" >[ Void ]
				<cfelseif Result IS "T" > <strong><em>hidden from the public</em></strong>			
				<cfelse>
				</cfif> 
				</span>
			</td>
			<td align="right" <cfif Highlight>class="bg_highlight"</cfif> >
				<span class="pix10red">#AwaySportsmanshipMarks#</span>
			</td>
			<td align="left"<cfif Highlight>class="bg_highlight"</cfif> >
				<cfset ToolTipText = "Click to see the Match Day screen for #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#.">
				<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix13">#DateFormat( FixtureDate , "DDD, DD MMM YYYY")#</span></a>
			</td>			
	
			<td align="left"<cfif Highlight>class="bg_highlight"</cfif> >
				<cfif RIGHT(request.dsn,4) GE 2012>		<!--- applies to season 2012 onwards only --->
					<cfif RefereeReportReceived IS 1 >
						<cfset ToolTipText = "Match report received">
						<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=150;return escape('#ToolTipText#')" >
						<img src="gif/tick.gif"  onMouseOver="#onMouseOverText#"> 
					</cfif>
				</cfif>
				<cfset ToolTipText = "Click to see the Match Update Details screen.">
				<span class="pix13">
				<cfif RefereeID IS #RI#><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#&Whence=RH">Ref H[#IIF(RefereeMarksH IS "",DE("&nbsp;&nbsp;"),"#RefereeMarksH#")#] A[#IIF(RefereeMarksA IS "",DE("&nbsp;&nbsp;"),"#RefereeMarksA#")#]</a></cfif>
				<cfswitch expression="#request.LeagueType#">
					<cfcase value="Normal">
						<cfif AsstRef1ID IS #RI#><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#&Whence=RH">Asst1 [#IIF(AsstRef1Marks IS "",DE("&nbsp;&nbsp;"),"#AsstRef1Marks#")#]</a></cfif>
						<cfif AsstRef2ID IS #RI#><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#&Whence=RH">Asst2 [#IIF(AsstRef2Marks IS "",DE("&nbsp;&nbsp;"),"#AsstRef2Marks#")#]</a></cfif>
					</cfcase>
					<cfcase value="Contributory">
						<cfif AsstRef1ID IS #RI#><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#&Whence=RH">Asst1 H[#IIF(AsstRef1MarksH IS "",DE("&nbsp;&nbsp;"),"#AsstRef1MarksH#")#] A[#IIF(AsstRef1MarksA IS "",DE("&nbsp;&nbsp;"),"#AsstRef1MarksA#")#]</a></cfif>
						<cfif AsstRef2ID IS #RI#><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#&Whence=RH">Asst2 H[#IIF(AsstRef2MarksH IS "",DE("&nbsp;&nbsp;"),"#AsstRef2MarksH#")#] A[#IIF(AsstRef2MarksA IS "",DE("&nbsp;&nbsp;"),"#AsstRef2MarksA#")#]</a></cfif>
					</cfcase>
					<cfdefaultcase>
						Reached defaultcase in RefsHist - Aborting
						<CFABORT>	
					</cfdefaultcase>
				</cfswitch>
				<!--- applies to season 2012 onwards only --->
				<cfif RIGHT(request.dsn,4) GE 2012>
					<cfif RefereeID IS #RI#>Referee 
						<cfif DateDiff('d',FixtureDate,Now()) GE 0>
							<cfif Len(Trim(RefMatchCardAnswers)) GT 0>
								<cfif RefMatchCardProblems IS 1>
									<a href="MatchCard.cfm?LeagueCode=#LeagueCode#&RI=#RI#&FID=#FID#&HA=H"><img src="gif/MatchCardProblem.gif" alt="Match Card" width="33" height="24" border="0" align="absmiddle"></a>
								<cfelse>
									<a href="MatchCard.cfm?LeagueCode=#LeagueCode#&RI=#RI#&FID=#FID#&HA=H"><img src="gif/MatchCardNoProblem.gif" alt="Match Card" width="33" height="24" border="0" align="absmiddle"></a>
								</cfif>
							<cfelse>
								<a href="MatchCard.cfm?LeagueCode=#LeagueCode#&RI=#RI#&FID=#FID#&HA=H"><img src="gif/MatchCardEmpty.gif" alt="Match Card" width="33" height="24" border="0" align="absmiddle"></a>
							</cfif>
						</cfif>
					</cfif>
				</cfif>
				<cfif FourthOfficialID IS #RI#><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#&Whence=RH">Fourth</a></cfif>
				<cfif AssessorID IS #RI#><a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='WhiteSmoke';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#&Whence=RH">Assessor</a></cfif>
				</span>
			</td>			
		</tr>
		<cfif RefereeID IS #RI#>
			<cfinclude template="queries/qry_QRefereeCardsH.cfm">
			<cfinclude template="queries/qry_QRefereeCardsA.cfm">
			<cfif (QRefereeCardsH.RecordCount + QRefereeCardsA.RecordCount) GT 0 >
				<tr>
					<td colspan="3" align="right">
						<cfif QRefereeCardsH.RecordCount GT 0 >
							<table border="1" cellpadding="2" cellspacing="0">
								<tr>
									<cfloop query="QRefereeCardsH">
										<cfif Card Is 1>
											<td bgcolor="Yellow" align="center"><span class="pix10">#PlayerName#</span></td>
										<cfelseif Card IS 3>
											<td bgcolor="Red" align="center"><span class="pix10white">#PlayerName#</span></td>							
										<cfelseif Card IS 4>
											<td bgcolor="Orange" align="center"><span class="pix10">#PlayerName#</span></td>							
										<cfelse>
											RefsHist.cfm ERROR 1
											<cfabort>
										</cfif>
									</cfloop>
								</tr>
							</table>
						</cfif>
					</td>
					<td colspan="2" align="center">&nbsp;</td>
					<td colspan="3" align="left">
						<cfif QRefereeCardsA.RecordCount GT 0 >
							<table border="1" cellpadding="2" cellspacing="0">
								<tr>
									<cfloop query="QRefereeCardsA">
										<cfif Card Is 1>
											<td bgcolor="Yellow" align="center"><span class="pix10">#PlayerName#</span></td>
										<cfelseif Card IS 3>
											<td bgcolor="Red" align="center"><span class="pix10white">#PlayerName#</span></td>							
										<cfelseif Card IS 4>
											<td bgcolor="Orange" align="center"><span class="pix10">#PlayerName#</span></td>							
										<cfelse>
											RefsHist.cfm ERROR 2
											<cfabort>
										</cfif>
									</cfloop>
								</tr>
							</table>
						</cfif>
					</td>
				
				</tr>
			</cfif>
		</cfif>
	<tr>
		<td height="4" colspan="9" bgcolor="white"></td>
	</tr>
	</cfoutput>
	</table>
</cfif>

<BR>
<BR>
<HR>
<cfoutput><span class="pix10">Use the section below (easier to copy and paste into a document) for County Promotion Candidate report</span></cfoutput>
<HR>
<BR>
<BR><cfoutput><span class="pix13">#QReferee.RefsName#</span></cfoutput><BR><BR>
	<cfoutput query="QRefereeHistory" >
		<cfif AsstRef1ID IS #RI# OR AsstRef2ID IS #RI# OR FourthOfficialID IS #RI# OR AssessorID IS #RI#>
		<!--- Ignore non-referee information --->
		<cfelse>
		<span class="pix13">
		#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#<BR>
		#CompetitionName#<cfif TRIM(#RoundName#)IS NOT "" >&nbsp;#RoundName#</cfif>: 
		#HomeTeam# #HomeOrdinal#
			<cfif Result IS "H" >
				H
			<cfelseif Result IS "A" >
				-
			<cfelseif Result IS "D" >
				D
			<cfelse>
				&nbsp;#HomeGoals#&nbsp;
			</cfif>
			 v 
			<cfif Result IS "H" >
				-
			<cfelseif Result IS "A" >
				A
			<cfelseif Result IS "D" >
				D
			<cfelse>
				&nbsp;#AwayGoals#&nbsp;
			</cfif> 
			#AwayTeam# #AwayOrdinal#
			<cfif Result IS "H" >[ Home Win was awarded ]
			<cfelseif Result IS "A" >[ Away Win was awarded ]
			<cfelseif Result IS "D" >[ Draw was awarded ]
			<cfelseif Result IS "P" ><strong>[ Postponed ]</strong>
			<cfelseif Result IS "Q" ><strong>[ Abandoned ]</strong>
			<cfelseif Result IS "W" ><strong>[ Void ]</strong>
			<cfelseif Result IS "U" >[ Home Win on penalties ]			
			<cfelseif Result IS "V" >[ Away Win on penalties ]
			<cfelseif Result IS "T" > <strong><em>TEMP hidden from the public</em></strong>			
			<cfelse>
			</cfif> 
			 <BR>
			<cfif RefereeID IS #RI#>Home = #RefereeMarksH#  Away = #RefereeMarksA# </cfif><BR><BR>
			</span>
		</cfif>
	</cfoutput>
<BR><BR><HR>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>

