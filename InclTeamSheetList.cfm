<!--- included by RegistListForm.cfm --->
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<table width="100%"  border="1" cellpadding="2" cellspacing="0" bgcolor="beige" >
	<tr>
		<td colspan="7"><span class="pix10"><cfoutput>#QFixtures.RecordCount#</cfoutput> fixtures</span></td>
	</tr>
	<cfoutput query="QFixtures" >
	<cfset ThisDate = DateFormat(FixtureDate, 'YYYY-MM-DD') >
	<cfset HideFixtures = "No">
	<!--- Hide the fixtures from the public if the Event Text says so --->
	<cfinclude template="queries/qry_QEventText.cfm">
	<cfif QEventText.RecordCount IS 1>
		<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
			<cfset HideFixtures = "Yes">
		</cfif>
	</cfif>
	<cfif HideFixtures IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
		<tr>
			<td colspan="2" >&nbsp;</td>
			<td><span class="pix10">#DateFormat( FixtureDate , "DDDD, DD MMMM")#</span></td>
			<td colspan="4" align="center"><span class="pix10bold">fixture hidden</span></td>
		</tr>
		
	<cfelseif Result IS "T" AND ListFind("Yellow",request.SecurityLevel) >
		<!--- suppress TEMP fixture from clubs --->	
	<cfelse>
	<tr <cfif HideFixtures IS "Yes">bgcolor="gray"</cfif>>
		<cfif ListFind( #request.ChosenConstitsAllSides#, HomeID ) GT "0" >
			<cfset HA = "H">
		<cfelseif ListFind( #request.ChosenConstitsAllSides#, AwayID ) GT "0" >
			<cfset HA = "A">
		<cfelse>
			ERROR in InclTeamSheetList - aborting
			<cfabort>
		</cfif>
		<!--- allow Home club to enter the KO time of the game if fixture date is in the future, unless option is suppressed with SuppressKOTimeEntry --->
		<cfif DateCompare(FixtureDate, Now()) IS 1 AND HA is "H" >
			<cfif SuppressKOTimeEntry IS "1" AND ListFind("Yellow",request.SecurityLevel) >
				<td>&nbsp;</td>
			<cfelse>
				<td width="7%" align="center"><a href="KOTime.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#"><img src="gif/KOTime.gif" alt="KO Time" border="1"></a></td>
			</cfif>
		<cfelseif DateCompare(FixtureDate, Now()) IS 1 AND HA is "A">
			<td>&nbsp;</td>
		<cfelse>
		<!--- otherwise allow club access to the team sheet --->
			<td width="7%" align="center"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#"><img src="gif/TeamSheet.gif" alt="KO Time" border="1"></a></td>
		</cfif>
		
		<td width="3%" align="center">
			<span class="pix10">
				<cfif HomeAway IS "H" >
					<cfif IsNumeric(#HomeGoals#) >
						<cfif IsNumeric(#AwayGoals#) >
							<cfif HomeGoals GT AwayGoals >
								W
							<cfelseif AwayGoals GT HomeGoals >
								L
							<cfelse>
								<CFSWITCH expression="#Result#">
									<CFCASE VALUE="U"> <!--- Home Win on penalties --->
										W
									</CFCASE>
									<CFCASE VALUE="V"> <!--- Away Win on penalties --->
										L
									</CFCASE>
									<CFDEFAULTCASE>
										D
									</CFDEFAULTCASE>
								</CFSWITCH>
							</cfif>
						</cfif>
					</cfif>
				<cfelseif HomeAway IS "A" >
					<cfif IsNumeric(#HomeGoals#) >
						<cfif IsNumeric(#AwayGoals#) >
							<cfif HomeGoals GT AwayGoals >
								L
							<cfelseif AwayGoals GT HomeGoals >
								W
							<cfelse>
								<CFSWITCH expression="#Result#">
									<CFCASE VALUE="U"> <!--- Home Win on penalties --->
										L
									</CFCASE>
									<CFCASE VALUE="V"> <!--- Away Win on penalties --->
										W
									</CFCASE>
									<CFDEFAULTCASE>
										D
									</CFDEFAULTCASE>
								</CFSWITCH>
							</cfif>
						</cfif>
					</cfif>
				</cfif>
		
				<cfif HomeAway IS "H" >
					<cfif NOT IsNumeric(#HomeGoals#) >
						<cfif NOT IsNumeric(#AwayGoals#) >
							<CFSWITCH expression="#Result#">
								<CFCASE VALUE="H">
								W
								</CFCASE>
								<CFCASE VALUE="A">
								L
								</CFCASE>
								<CFCASE VALUE="D">
								D
								</CFCASE>
								<CFDEFAULTCASE>
								&nbsp;
								</CFDEFAULTCASE>
							</CFSWITCH>
						</cfif>
					</cfif>
				<cfelseif HomeAway IS "A" >
					<cfif NOT IsNumeric(#HomeGoals#) >
						<cfif NOT IsNumeric(#AwayGoals#) >
							<CFSWITCH expression="#Result#">
								<CFCASE VALUE="H">
								L
								</CFCASE>
								<CFCASE VALUE="A">
								W
								</CFCASE>
								<CFCASE VALUE="D">
								D
								</CFCASE>
								<CFDEFAULTCASE>
								&nbsp;
								</CFDEFAULTCASE>
							</CFSWITCH>
						</cfif>
					</cfif>
				</cfif>
			</span>
		</td>

		<td width="30%" >
			<span class="pix10">#CompetitionName#<cfif TRIM(#RoundName#)IS NOT "" > #RoundName#</cfif><br />#DateFormat( FixtureDate , "DDDD, DD MMMM")#<cfif TRIM(#KOTime#)IS NOT "" ><br>KO #TimeFormat(KOTime, "h:mm TT")#</cfif></span>
		</td>
		
		<cfif HomeAway IS "H">
			<td width="25%" align="right" bgcolor="Cornsilk">
				<span class="pix10navy">#HomeTeam# #HomeOrdinal#</span>
				<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0>
					<span class="pix9"><br />#NumberFormat(HomePointsAdjust,"+9")# <cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>point<cfelse>points</cfif></span>
				</cfif>						
			</td>
		<cfelse>
			<td width="25%" align="right">
				<span class="pix10">#HomeTeam# #HomeOrdinal#</span>
				<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0>
					<span class="pix9"><br />#NumberFormat(HomePointsAdjust,"+9")# <cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>point<cfelse>points</cfif></span>
				</cfif>						
			</td>
		</cfif>
	
		
		<!--- merge cells if Postponed or Abandoned or Void --->
		<cfif Result IS "P" >
			<td colspan="2" align="center"><span class="pix18boldgray">P</span></td>
		<cfelseif Result IS "Q" >
			<td colspan="2" align="center"><span class="pix18boldgray">A</span></td>
		<cfelseif Result IS "W" >
			<td colspan="2" align="center"><span class="pix18boldgray">V</span></td>
		<cfelseif Result IS "T" >
			<td colspan="2" align="center" bgcolor="aqua"><span class="pix18boldgray">TEMP</span></td>
		<cfelse>
			<td width="5%" align="center" >
				<span class="pix10">
				<cfif Result IS "H" >
					H
				<cfelseif Result IS "A" >
					-
				<cfelseif Result IS "D" >
					D 
				<cfelseif Result IS "" AND DateCompare(FixtureDate, Now()) IS 1 AND HA is "H" >
					<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#"><img src="gif/TeamSheet.gif" alt="Team Sheet" border="1"></a>
				<cfelse>
					&nbsp;#HomeGoals#&nbsp;
				</cfif>
				</span>
			</td>
			<td width="5%" align="center" >
				<span class="pix10">
				<cfif Result IS "H" >
					-
				<cfelseif Result IS "A" >
					A
				<cfelseif Result IS "D" >
					D 
				<cfelseif Result IS "" AND DateCompare(FixtureDate, Now()) IS 1 AND HA is "A" >
					<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#"><img src="gif/TeamSheet.gif" alt="Team Sheet" border="1"></a>
				<cfelse>
					&nbsp;#AwayGoals#&nbsp;
				</cfif> 
				</span>		
			</td>
		</cfif>
		<cfif HomeAway IS "A">
			<td width="25%" align="left" bgcolor="Cornsilk">
				<span class="pix10navy">#AwayTeam# #AwayOrdinal#</span>
				<span class="pix10">
				<!--- HideScore irrelevant here because always logged in as Silver, SkyBlue or Yellow --->
				<cfif Result IS "H" >[ Home Win was awarded ]
				<cfelseif Result IS "A" >[ Away Win was awarded ]
				<cfelseif Result IS "U" >[ Home Win on penalties ]
				<cfelseif Result IS "V" >[ Away Win on penalties ]
				<cfelseif Result IS "D" >[ Draw was awarded ]
				<cfelseif Result IS "P" >[ Postponed ]
				<cfelseif Result IS "Q" >[ Abandoned ]
				<cfelseif Result IS "W" >[ Void ]
				<cfelseif Result IS "T" ><em> fixture hidden from the public</em>
				<cfelse>
				</cfif> 
				</span>
				<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0>
					<span class="pix9"><br />#NumberFormat(AwayPointsAdjust,"+9")# <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>point<cfelse>points</cfif></span>
				</cfif>
			</td>
		<cfelse>
			<td width="25%" align="left">
				<span class="pix10">#AwayTeam# #AwayOrdinal#</span>
				<span class="pix10">
				<!--- HideScore irrelevant here because always logged in as Silver, SkyBlue or Yellow --->
				<cfif Result IS "H" >[ Home Win was awarded ]
				<cfelseif Result IS "A" >[ Away Win was awarded ]
				<cfelseif Result IS "U" >[ Home Win on penalties ]
				<cfelseif Result IS "V" >[ Away Win on penalties ]
				<cfelseif Result IS "D" >[ Draw was awarded ]
				<cfelseif Result IS "P" >[ Postponed ]
				<cfelseif Result IS "Q" >[ Abandoned ]
				<cfelseif Result IS "W" >[ Void ]
				<cfelseif Result IS "T" ><em> fixture hidden from the public</em>
				<cfelse>
				</cfif> 
				</span>
				<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0>
					<span class="pix9"><br />#NumberFormat(AwayPointsAdjust,"+9")# <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>point<cfelse>points</cfif></span>
				</cfif>
			</td>
		</cfif>
	</tr>
	</cfif>
	</cfoutput>
</table>
