<!--- called by FixtResMonth.cfm   MtchDay.cfm --->
<cfoutput>
	<td>
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
			<table>
				<tr>
				<cfif RefsName IS NOT "">
					<td valign="middle"><img src="images/icon_referee.png" border="0" align="middle"></td>
					<cfif RIGHT(request.dsn,4) GE 2012>		<!--- applies to season 2012 onwards only --->
					
					
					
					
					
					
						<cfif RefereeReportReceived IS 1 ><cfset ToolTipText = "Match report received"><cfelse><cfset ToolTipText = "Match report not received"></cfif>
						<cfset onMouseOverText = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='##FFFF99';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=150;return escape('#ToolTipText#')" >
						<cfif RefMatchCardProblems IS 1 >
							<cfset ToolTipTxt = "Match Card Problems Reported">
							<cfset onMouseOverTxt = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='pink';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=150;return escape('#ToolTipTxt#')" >
						<cfelse>
							<cfset ToolTipTxt = "No Match Card Problems">
							<cfset onMouseOverTxt = "onMouseOver=this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='lightgreen';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=150;return escape('#ToolTipTxt#')" >
						</cfif>
						
						
						<td valign="middle" >
							<cfif DateDiff('d',FixtureDate,Now()) GE 0> <!--- today or before today --->
								<cfif Len(Trim(RefMatchCardAnswers)) GT 0>
									<a href="MatchCard.cfm?LeagueCode=#LeagueCode#&RI=#RefsID#&FID=#FID#&HA=H" onMouseOver="#onMouseOverTxt#"><cfif RefMatchCardProblems IS 1 ><img src="gif/MatchCardProblem.gif" alt="Match Card" width="33" height="24" border="0" align="absmiddle"><cfelse><img src="gif/MatchCardNoProblem.gif" alt="Match Card" width="33" height="24" border="0" align="absmiddle"></cfif></a>
								</cfif>
								<cfif RefereeReportReceived IS 1 ><img src="gif/tick.gif"></cfif>
								<a href="RefsHist.cfm?RI=#RefsID#&LeagueCode=#LeagueCode#"><span class="pix13bold" onMouseOver="#onMouseOverText#">#RefsFullName#</span></a>
							<cfelse> <!--- future game --->
								<a href="RefsHist.cfm?RI=#RefsID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#RefsFullName#</span></a>
							</cfif>
						</td>
						
						
						
						
						
						
						
						
					<cfelse>
						<td valign="middle"><a href="RefsHist.cfm?RI=#RefsID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#RefsFullName#</span></a></td>
					</cfif>
				</cfif>
				<cfif AR1Name IS NOT "">
					<td valign="middle"><img src="images/icon_line1.png" border="0" align="middle"></td>
					<td valign="middle"><a href="RefsHist.cfm?RI=#AR1ID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#AR1FullName#</span></a></td>
				</cfif>
				<cfif AR2Name IS NOT "">
					<td valign="middle"><img src="images/icon_line2.png" border="0" align="middle"></td>									
					<td valign="middle"><a href="RefsHist.cfm?RI=#AR2ID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#AR2FullName#</span></a></td>
				</cfif>

				<cfif FourthOfficialName IS NOT "">
					<td valign="middle"><img src="images/icon_4th.png" border="0" align="middle"></td>   									
					<td valign="middle"><a href="RefsHist.cfm?RI=#FourthOfficialID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#FourthOfficialFullName#</span></a></td>
				</cfif>

				<cfif AssessorName IS NOT "">
					<td valign="middle"><img src="images/icon_assesment.png" border="0" align="top"></td>									
					<td valign="middle"><a href="RefsHist.cfm?RI=#AssessorID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#AssessorFullName#</span></a></td>
				</cfif>
				</tr>
				<cfif RIGHT(request.dsn,4) GE 2012>		<!--- applies to season 2012 onwards only --->
					<cfif QFixtures.HideMatchOfficials IS 1 >
						<img src="gif/animatedhidden.gif"   onmouseover="this.src='gif/MOHidden1.GIF';"  onMouseOut="this.src='gif/animatedhidden.gif';">
					</cfif>
				</cfif>
			</table>
		<cfelse>
			<table>
				<tr>
					<cfif RIGHT(request.dsn,4) GE 2012>		<!--- applies to season 2012 onwards only --->
						<cfif QFixtures.HideMatchOfficials IS 1 >
							<!--- do not display match officials --->
						<cfelse>
								<cfif RefsName IS NOT "">
									<cfif LTRIM(RTRIM(RefsNo)) IS "">
										<td valign="top"><img src="images/icon_referee.png" border="0" align="middle"><span class="pix13bold">&nbsp;#RefsName#</span></td>
									<cfelse>
										<td valign="top"><img src="images/icon_referee.png" border="0" align="middle"><span class="pix13bold">&nbsp;#RefsNo#</span></td>
									</cfif>
								</cfif>
								<cfif AR1Name IS NOT "">
									<cfif LTRIM(RTRIM(AR1No)) IS "">
										<td valign="top"><img src="images/icon_line1.png" border="0" align="middle"><span class="pix13bold">&nbsp;#AR1Name#</span></td>
									<cfelse>
										<td valign="top"><img src="images/icon_line1.png" border="0" align="middle"><span class="pix13bold">&nbsp;#AR1No#</span></td>
									</cfif>
								</cfif>
								<cfif AR2Name IS NOT "">
									<cfif LTRIM(RTRIM(AR2No)) IS "">
										<td valign="top"><img src="images/icon_line2.png" border="0" align="middle"><span class="pix13bold">&nbsp;#AR2Name#</span></td>
									<cfelse>
										<td valign="top"><img src="images/icon_line2.png" border="0" align="middle"><span class="pix13bold">&nbsp;#AR2No#</span></td>
									</cfif>
								</cfif>
								<cfif FourthOfficialName IS NOT "">
									<cfif LTRIM(RTRIM(FourthOfficialNo)) IS "">
										<td valign="top"><img src="images/icon_4th.png" border="0" align="middle"><span class="pix13bold">&nbsp;#FourthOfficialName#</span></td>
									<cfelse>
										<td valign="top"><img src="images/icon_4th.png" border="0" align="middle"><span class="pix13bold">&nbsp;#FourthOfficialNo#</span></td>
									</cfif>
								</cfif>
								<cfif AssessorName IS NOT "" AND ShowAssessor IS 1 >
									<td valign="top"><img src="images/icon_assesment.png"  border="0" align="top"><span class="pix13bold">&nbsp;#AssessorName#</span></td>
								</cfif>
						</cfif>
					<cfelse>		<!--- applies to season 2011 and earlier only --->
						<cfif RefsName IS NOT "">
							<cfif LTRIM(RTRIM(RefsNo)) IS "">
								<td valign="top"><img src="images/icon_referee.png" border="0" align="middle"><span class="pix13bold">&nbsp;#RefsName#</span></td>
							<cfelse>
								<td valign="top"><img src="images/icon_referee.png" border="0" align="middle"><span class="pix13bold">&nbsp;#RefsNo#</span></td>
							</cfif>
						</cfif>
						<cfif AR1Name IS NOT "">
							<cfif LTRIM(RTRIM(AR1No)) IS "">
								<td valign="top"><img src="images/icon_line1.png" border="0" align="middle"><span class="pix13bold">&nbsp;#AR1Name#</span></td>
							<cfelse>
								<td valign="top"><img src="images/icon_line1.png" border="0" align="middle"><span class="pix13bold">&nbsp;#AR1No#</span></td>
							</cfif>
						</cfif>
						<cfif AR2Name IS NOT "">
							<cfif LTRIM(RTRIM(AR2No)) IS "">
								<td valign="top"><img src="images/icon_line2.png" border="0" align="middle"><span class="pix13bold">&nbsp;#AR2Name#</span></td>
							<cfelse>
								<td valign="top"><img src="images/icon_line2.png" border="0" align="middle"><span class="pix13bold">&nbsp;#AR2No#</span></td>
							</cfif>
						</cfif>
						<cfif FourthOfficialName IS NOT "">
							<cfif LTRIM(RTRIM(FourthOfficialNo)) IS "">
								<td valign="top"><img src="images/icon_4th.png" border="0" align="middle"><span class="pix13bold">&nbsp;#FourthOfficialName#</span></td>
							<cfelse>
								<td valign="top"><img src="images/icon_4th.png" border="0" align="middle"><span class="pix13bold">&nbsp;#FourthOfficialNo#</span></td>
							</cfif>
						</cfif>
						<cfif AssessorName IS NOT "" AND ShowAssessor IS 1 >
							<td valign="top"><img src="images/icon_assesment.png"  border="0" align="top"><span class="pix13bold">&nbsp;#AssessorName#</span></td>
						</cfif>
					</cfif>
				</tr>
			</table>
		</cfif>
	</td>
</cfoutput>

