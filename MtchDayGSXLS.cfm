<cfset BatchInput = "No">
<cfset MDate = url.ThisDate >
<cfinclude template="InclBegin.cfm">
<cfsilent>
	<cfinclude template="queries/qry_QFixtures_v2.cfm">
</cfsilent>

<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=Fixtures&Results.xls">
<cfset ThisColSpan = 6 >
<cfoutput>
	<table border="0">
	<tr> <td colspan="#ThisColSpan#" align="center">#SeasonName#</td></tr>
	<tr> <td colspan="#ThisColSpan#" align="center">#LeagueName#</td></tr>
	<tr> <td colspan="#ThisColSpan#" align="center" valign="top">#DateFormat(url.ThisDate, 'DDDD, DD MMMM YYYY')#</td></tr>
	<tr bgcolor="White">
		<td height="20" colspan="#ThisColSpan#">&nbsp;</td>
	</tr>
</cfoutput>

</table>
<cfif QFixtures.RecordCount GT 0 >
		<!--- Hide the fixtures from the public if the Event Text says so --->
		<cfinclude template="queries/qry_QEventText.cfm">
		<cfif QEventText.RecordCount IS 1>
			<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
				<cfoutput>
				<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
					<tr>
						<cfif QFixtures.RecordCount IS 1>
							<td height="20" colspan="#ThisColSpan#" align="center" bgcolor="red"><span class="pix13boldwhite">Today's fixture has been hidden from the public</span></td>
						<cfelseif QFixtures.RecordCount GT 1>
							<td height="20" colspan="#ThisColSpan#" align="center" bgcolor="red"> <span class="pix13boldwhite">Today's fixtures have been hidden from the public</span></td>
						</cfif>
					</tr>
				<cfelse>
					<tr>
						<cfif QFixtures.RecordCount IS 1>
							<td colspan="#ThisColSpan#" align="center"><span class="pix13bold">Today's fixture has been hidden</span></td>
							<cfabort>
						<cfelseif QFixtures.RecordCount GT 1>
							<td colspan="#ThisColSpan#" align="center"> <span class="pix13bold">Today's fixtures have been hidden</span></td>
							<cfabort>
						</cfif>
					</tr>
				</cfif>
				</cfoutput>
			</cfif>
		</cfif>
			<cfoutput>
			<table width="100%" border="0" cellspacing="2" cellpadding="0" >
				<tr> 
					<td>&nbsp;</td>
					<td align="right">Home Team&nbsp;&nbsp;&nbsp;</td>
					<td colspan="2" align="center">Score</td>
					<td colspan="2">&nbsp;&nbsp;&nbsp;Away Team</td>
				</tr>
			</cfoutput>
			
			
			<cfif KickOffTimeOrder>
			<cfoutput query="QFixtures" group="DivName1"> 
				<tr> 
					<cfif ExternalComp IS 'Yes'>
						<td height="30" colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="+1"><strong><em>#DivName1#</em></strong></font></td>
					<cfelse>
						<td height="30" colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="+1"><strong>#DivName1#</strong></font></td>
					</cfif>
				</tr>
				
				<cfoutput group="KOTime">
					<tr>
						<td  colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="-1">#TimeFormat(KOTime, 'h:mm tt')#</font></td>
					</tr>
					<cfoutput>
						<cfif Result IS "H" >
							<cfset message01 = "[ Home Win was awarded ]">
						<cfelseif Result IS "A" >
							<cfset message01 = "[ Away Win was awarded ]">
						<cfelseif Result IS "U" >
							<cfset message01 = "[ Home Win on penalties ]">
						<cfelseif Result IS "V" >
							<cfset message01 = "[ Away Win on penalties ]">
						<cfelseif Result IS "D" >
							<cfset message01 = "[ Draw was awarded ]">
						<cfelseif Result IS "P" >
							<cfset message01 = "[ Postponed ]">
						<cfelseif Result IS "Q" >
							<cfset message01 = "[ Abandoned ]">
						<cfelseif Result IS "W" >
							<cfset message01 = "[ Void ]">
						<cfelseif Result IS "T" AND ListFind("Silver,Skyblue",request.SecurityLevel) >
							<cfset message01 = "hidden from the public">
						<cfelse>
							<cfset message01 = "">
						</cfif>
						<!--- suppress TEMP fixtures if not logged in --->
						<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND Result IS "T">
							<!--- do nothing --->
						<cfelse>
							<tr>
								<td>#RoundName#</td>
							<cfif UCase(HomeGuest) IS "GUEST">
									<td align="right"><em>#HomeTeam# #HomeOrdinal#</em>&nbsp;&nbsp;&nbsp;</td>
								<cfelse>
									<td align="right">#HomeTeam# #HomeOrdinal#&nbsp;&nbsp;&nbsp;</td>
							</cfif>
								<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND HomeGoals IS "" AND AwayGoals IS "" AND Result IS "" >
									<td colspan="2" align="center">&nbsp;</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
									<td colspan="2" align="center">Played</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
										<td colspan="2" align="center">Played</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
										<td colspan="2" align="center">Played</td>
								<cfelseif Result IS "P" >
									<td colspan="2" align="center" >P</td>
								<cfelseif Result IS "Q">
									<td colspan="2" align="center" >A</td>
								<cfelseif Result IS "W">
									<td colspan="2" align="center" >V</td>
								<cfelseif Result IS "T">
									<td colspan="2" align="center" >TEMP</td>
								<cfelse>
									<td align="CENTER" > 
										<cfif Result IS "H" >
										  H 
										  <cfelseif Result IS "A" >
										  - 
										  <cfelseif Result IS "D" >
										  D 
										  <cfelse>
										  #HomeGoals# 
										</cfif>
									</td>
									<td align="CENTER"> 
										<cfif Result IS "H" >
										  - 
										  <cfelseif Result IS "A" >
										  A 
										  <cfelseif Result IS "D" >
										  D 
										  <cfelse>
										  #AwayGoals# 
										</cfif>
									</td>
								</cfif>
								<cfif UCase(AwayGuest) IS "GUEST">
									<td>&nbsp;&nbsp;&nbsp;<em>#AwayTeam# #AWayOrdinal#</em></td>
								<cfelse>
									<td>&nbsp;&nbsp;&nbsp;#AwayTeam# #AWayOrdinal#</td>
								</cfif>
								<td>#message01#</td>
							</tr>
						</cfif>
		
					</cfoutput> 
			</cfoutput>
		</cfoutput>
			<cfelse> <!--- not in KickOffTimeOrder --->
			<cfoutput query="QFixtures" group="DivName1"> 
				<tr> 
					<cfif ExternalComp IS 'Yes'>
						<td height="30" colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="+1"><strong><em>#DivName1#</em></strong></font></td>
					<cfelse>
						<td height="30" colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="+1"><strong>#DivName1#</strong></font></td>
					</cfif>
				</tr>
					<cfoutput>
						<cfif Result IS "H" >
							<cfset message01 = "[ Home Win was awarded ]">
						<cfelseif Result IS "A" >
							<cfset message01 = "[ Away Win was awarded ]">
						<cfelseif Result IS "U" >
							<cfset message01 = "[ Home Win on penalties ]">
						<cfelseif Result IS "V" >
							<cfset message01 = "[ Away Win on penalties ]">
						<cfelseif Result IS "D" >
							<cfset message01 = "[ Draw was awarded ]">
						<cfelseif Result IS "P" >
							<cfset message01 = "[ Postponed ]">
						<cfelseif Result IS "Q" >
							<cfset message01 = "[ Abandoned ]">
						<cfelseif Result IS "W" >
							<cfset message01 = "[ Void ]">
						<cfelseif Result IS "T" AND ListFind("Silver,Skyblue",request.SecurityLevel) >
							<cfset message01 = "hidden from the public">
						<cfelse>
							<cfset message01 = "">
						</cfif>
						<!--- suppress TEMP fixtures if not logged in --->
						<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND Result IS "T">
							<!--- do nothing --->
						<cfelse>
							<tr>
								<td>#RoundName#</td>
							<cfif UCase(HomeGuest) IS "GUEST">
									<td align="right"><em>#HomeTeam# #HomeOrdinal#</em>&nbsp;&nbsp;&nbsp;</td>
								<cfelse>
									<td align="right">#HomeTeam# #HomeOrdinal#&nbsp;&nbsp;&nbsp;</td>
							</cfif>
								<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND HomeGoals IS "" AND AwayGoals IS "" AND Result IS "" >
									<td colspan="2" align="center">&nbsp;</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
									<td colspan="2" align="center">Played</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
										<td colspan="2" align="center">Played</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
										<td colspan="2" align="center">Played</td>
								<cfelseif Result IS "P" >
									<td colspan="2" align="center" >P</td>
								<cfelseif Result IS "Q">
									<td colspan="2" align="center" >A</td>
								<cfelseif Result IS "W">
									<td colspan="2" align="center" >V</td>
								<cfelseif Result IS "T">
									<td colspan="2" align="center" >TEMP</td>
								<cfelse>
									<td align="CENTER" > 
										<cfif Result IS "H" >
										  H 
										  <cfelseif Result IS "A" >
										  - 
										  <cfelseif Result IS "D" >
										  D 
										  <cfelse>
										  #HomeGoals# 
										</cfif>
									</td>
									<td align="CENTER"> 
										<cfif Result IS "H" >
										  - 
										  <cfelseif Result IS "A" >
										  A 
										  <cfelseif Result IS "D" >
										  D 
										  <cfelse>
										  #AwayGoals# 
										</cfif>
									</td>
								</cfif>
								<cfif UCase(AwayGuest) IS "GUEST">
									<td>&nbsp;&nbsp;&nbsp;<em>#AwayTeam# #AWayOrdinal#</em></td>
								<cfelse>
									<td>&nbsp;&nbsp;&nbsp;#AwayTeam# #AWayOrdinal#</td>
								</cfif>
								<td>#message01#</td>
							</tr>
							
							<tr>
							<cfset FIDList = #FID# >
							<td colspan="2" align="right" >
							<cfinclude template="queries/qry_QAllHomeGoalscorers.cfm">
							<cfinclude template="queries/qry_QGoalscorersH2.cfm">
							<cfif QGoalscorersH.RecordCount GT 0>
								<cfset HomeGoalscorersSurnameList=ValueList(QGoalscorersH.PlayerSurname)>
								<cfset HomeGoalscorersForenameList=ValueList(QGoalscorersH.PlayerForename)>						
								<cfset HomeGoalscoredList=ValueList(QGoalscorersH.GoalsScored)>
								<cfif ListGetAt(HomeGoalscorersSurnameList, 1) IS 'Own Goal'>
									<cfif ListGetAt(HomeGoalscoredList, 1) GT 1>
											OG(#ListGetAt(HomeGoalscoredList, 1)#)
									<cfelse>
											OG
									</cfif>
								<cfelse>
									<cfif ListGetAt(HomeGoalscoredList, 1) GT 2>
											#Left(ListGetAt(HomeGoalscorersForenameList, 1),1)#.#ListGetAt(HomeGoalscorersSurnameList, 1)#(#ListGetAt(HomeGoalscoredList, 1)#)
									<cfelseif ListGetAt(HomeGoalscoredList, 1) GT 1>
											#Left(ListGetAt(HomeGoalscorersForenameList, 1),1)#.#ListGetAt(HomeGoalscorersSurnameList, 1)#(#ListGetAt(HomeGoalscoredList, 1)#)
									<cfelse>
											#Left(ListGetAt(HomeGoalscorersForenameList, 1),1)#.#ListGetAt(HomeGoalscorersSurnameList, 1)#
									</cfif>
								</cfif>
								<cfloop index="w" from="2" to="#QGoalscorersH.RecordCount#" step="1">
									<cfif ListGetAt(HomeGoalscorersSurnameList, w) IS 'Own Goal'>
										<cfif ListGetAt(HomeGoalscoredList, w) GT 1>
												&nbsp;OG(#ListGetAt(HomeGoalscoredList, w)#)
										<cfelse>
												&nbsp;OG
										</cfif>
									<cfelse>
										<cfif ListGetAt(HomeGoalscoredList, w) GT 2>
												&nbsp;#Left(ListGetAt(HomeGoalscorersForenameList, w),1)#.#ListGetAt(HomeGoalscorersSurnameList, w)#(#ListGetAt(HomeGoalscoredList, w)#)
										<cfelseif ListGetAt(HomeGoalscoredList, w) GT 1>
												&nbsp;#Left(ListGetAt(HomeGoalscorersForenameList, w),1)#.#ListGetAt(HomeGoalscorersSurnameList, w)#(#ListGetAt(HomeGoalscoredList, w)#)
										<cfelse>
												&nbsp;#Left(ListGetAt(HomeGoalscorersForenameList, w),1)#.#ListGetAt(HomeGoalscorersSurnameList, w)#
										</cfif>
									</cfif>
								</cfloop>
							</cfif>
							</td>
							<td></td>
							<td></td>
							<td colspan="2" align="left" >
							<cfinclude template="queries/qry_QAllAwayGoalscorers.cfm">
							<cfinclude template="queries/qry_QGoalscorersA2.cfm">
							<cfif QGoalscorersA.RecordCount GT 0>
								<cfset AwayGoalscorersSurnameList=ValueList(QGoalscorersA.PlayerSurname)>
								<cfset AwayGoalscorersForenameList=ValueList(QGoalscorersA.PlayerForename)>						
								<cfset AwayGoalscoredList=ValueList(QGoalscorersA.GoalsScored)>
								<cfif ListGetAt(AwayGoalscorersSurnameList, 1) IS 'Own Goal'>
									<cfif ListGetAt(AwayGoalscoredList, 1) GT 1>
											OG(#ListGetAt(AwayGoalscoredList, 1)#)
									<cfelse>
											OG
									</cfif>
								<cfelse>
									<cfif ListGetAt(AwayGoalscoredList, 1) GT 2>
											#Left(ListGetAt(AwayGoalscorersForenameList, 1),1)#.#ListGetAt(AwayGoalscorersSurnameList, 1)#(#ListGetAt(AwayGoalscoredList, 1)#)
									<cfelseif ListGetAt(AwayGoalscoredList, 1) GT 1>
											#Left(ListGetAt(AwayGoalscorersForenameList, 1),1)#.#ListGetAt(AwayGoalscorersSurnameList, 1)#(#ListGetAt(AwayGoalscoredList, 1)#)
									<cfelse>
											#Left(ListGetAt(AwayGoalscorersForenameList, 1),1)#.#ListGetAt(AwayGoalscorersSurnameList, 1)#
									</cfif>
								</cfif>
								<cfloop index="w" from="2" to="#QGoalscorersA.RecordCount#" step="1">
									<cfif ListGetAt(AwayGoalscorersSurnameList, w) IS 'Own Goal'>
										<cfif ListGetAt(AwayGoalscoredList, w) GT 1>
												&nbsp;OG(#ListGetAt(AwayGoalscoredList, w)#)
										<cfelse>
												&nbsp;OG
										</cfif>
									<cfelse>
										<cfif ListGetAt(AwayGoalscoredList, w) GT 2>
												&nbsp;#Left(ListGetAt(AwayGoalscorersForenameList, w),1)#.#ListGetAt(AwayGoalscorersSurnameList, w)#(#ListGetAt(AwayGoalscoredList, w)#)
										<cfelseif ListGetAt(AwayGoalscoredList, w) GT 1>
												&nbsp;#Left(ListGetAt(AwayGoalscorersForenameList, w),1)#.#ListGetAt(AwayGoalscorersSurnameList, w)#(#ListGetAt(AwayGoalscoredList, w)#)
										<cfelse>
												&nbsp;#Left(ListGetAt(AwayGoalscorersForenameList, w),1)#.#ListGetAt(AwayGoalscorersSurnameList, w)#
										</cfif>
									</cfif>
								</cfloop>
							</cfif>
							</tr>
						</cfif>
				</cfoutput>
			</cfoutput>
		</table>
		
	</cfif>
</cfif>