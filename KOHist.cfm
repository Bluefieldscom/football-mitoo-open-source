<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
<cfelse>
	<cfoutput>
		<cflocation url="http://www.mitoo.com/beta?league&leaguecode=#request.CurrentLeagueCodePrefix#&nonko=1" addtoken="no">
	</cfoutput>
	<cfabort>
</cfif>

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition
If it IS NOT, then we'll jump over to League Table instead
--->

<CFPARAM name="KO" default="No">

<cfinclude template="queries/qry_QKnockOut.cfm">

<cfif Left(QKnockOut.Notes,2) IS NOT "KO" >
<!--- Jumping here.... --->
	<CFLOCATION URL="LeagueTab.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
</cfif>

<cfinclude template="queries/qry_QKOHist.cfm">

<table width="100%" border="0" cellspacing="1" cellpadding="1" >
	<cfoutput query="QKOHist" group="RoundSort">
	<cfset MtchCount = "0">
	<tr>
		<td colspan="5" align="left"><span class="pix13bold">#RoundName#</span></td>
	</tr>
		<cfoutput>
		
			<cfset Highlight = "No">
			<!---
			<cflock scope="session" timeout="10" type="readonly">
				<cfset request.fmTeamID = session.fmTeamID >
			</cflock>
			--->
			<cfif request.fmTeamID IS HomeTeamID>
				<cfset Highlight = "Yes">
			</cfif>
			<cfif request.fmTeamID IS AwayTeamID>
				<cfset Highlight = "Yes">
			</cfif>
			<cfset MtchCount = IncrementValue(MtchCount)>
			<tr>
				<cfset HideFixtures = "No">
				<!--- Hide the fixtures from the public if the Event Text says so --->
				<cfset ThisDate = DateFormat(QKOHist.FixtureDate,'YYYY-MM-DD') >
				<cfinclude template="queries/qry_QEventText.cfm">
				<cfif QEventText.RecordCount IS 1>
					<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
						<cfset HideFixtures = "Yes">
					</cfif>
				</cfif>
				<cfif HideFixtures IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
					<!--- suppress the line for this date --->
				<cfelseif ListFindNoCase( "H,A,D,P,Q,W,T", QKOHist.AwardedResult) IS 0 >
						<cfif HomeGoals GT AwayGoals >                   <!---------- is it a winning score for the Home Team ?---------->
							<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">#HomeGoals#</span></td> <!---------- Home goals scored ---------->
							<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">#AwayGoals#</span></td> <!---------- Away goals scored ---------->
							<td align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<cfif Find( "MatchNumbers", QKnockOut.Notes )>		<!--- e.g. 004 in italics --->
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
								</cfif>
								<cfif UCase(HomeGuest) IS "GUEST">
									<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<span class="pix13bolditalic">#HomeTeamName# #HomeOrdinal#</span></a>
								<cfelse>
									<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<span class="pix13bold">#HomeTeamName# #HomeOrdinal#</span></a>
								</cfif>
								&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
								<cfif UCase(AwayGuest) IS "GUEST">
									<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
								<cfelse>
									<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
								</cfif>	
							</td>
							<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13"></span></td>
							
						<cfelseif AwayGoals GT HomeGoals >                   <!---------- this is a winning score for the Away Team ---------->
							<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">#HomeGoals#</span></td> <!---------- Home goals scored ---------->
							<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">#AwayGoals#</span></td> <!---------- Away goals scored ---------->
							<td align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<cfif Find( "MatchNumbers", QKnockOut.Notes )>		<!--- e.g. 004 in italics --->
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
								</cfif>
								<cfif UCase(HomeGuest) IS "GUEST">
									<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
								<cfelse>
									<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
								</cfif>
								&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
								<cfif UCase(AwayGuest) IS "GUEST">
									<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<span class="pix13bolditalic">#AwayTeamName# #AwayOrdinal#</span></a>
								<cfelse>
									<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<span class="pix13bold">#AwayTeamName# #AwayOrdinal#</span></a>
								</cfif>
							</td>
							<td align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<td  <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">&nbsp;</span></td>
							
						<cfelse>                   <!---------- it was a Drawn or no result ---------->
							<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">#HomeGoals#</span></td> <!---------- Home goals scored ---------->
							<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">#AwayGoals#</span></td> <!---------- Away goals scored ---------->
							<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<cfif Find( "MatchNumbers", QKnockOut.Notes )>		<!--- e.g. 004 in italics --->
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>								
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
								</cfif>
								<cfif UCase(HomeGuest) IS "GUEST">
									<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<cfif QKOHist.AwardedResult IS "U" >
										<span class="pix13bolditalic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelseif QKOHist.AwardedResult IS "V" >
										<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
								<cfelse>
									<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<cfif QKOHist.AwardedResult IS "U" >
										<span class="pix13bold">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelseif QKOHist.AwardedResult IS "V" >
										<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
								</cfif>
								&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
								<cfif UCase(AwayGuest) IS "GUEST">
									<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<cfif QKOHist.AwardedResult IS "U" >
										<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelseif QKOHist.AwardedResult IS "V" >
										<span class="pix13bolditalic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>
								<cfelse>
									<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
									<cfif QKOHist.AwardedResult IS "U" >
										<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelseif QKOHist.AwardedResult IS "V" >
										<span class="pix13bold">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>
								</cfif>	
							</td>
							<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<!---------- Date of Match ---------->
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<!---------- because it was a Draw it might have been settled on penalties ---------->
							<cfif QKOHist.AwardedResult IS "U">
								<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10">Home Win on penalties</span></td>
							<cfelseif QKOHist.AwardedResult IS "V">
								<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10">Away Win on penalties</span></td>
							<cfelse>
								<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10"></span></td>
							</cfif>
							
						</cfif> <!---------- Home, Away or Drawn result or Postponed or Abandoned or Void ---------->
				<cfelse>
						<CFSWITCH expression="#QKOHist.AwardedResult#">
						
							<CFCASE VALUE="H">
								<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">H</span></td>
								<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">-</span></td>
								<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>		<!--- e.g. 004 in italics --->
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
									<cfif UCase(HomeGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13bolditalic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13bold">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
									&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
									<cfif UCase(AwayGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>	
								</td>
							<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<!---------- Date of Match ---------->
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10">Home Win was awarded</span></td>
							</CFCASE>
			
							<CFCASE VALUE="A">
								<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">-</span></td>
								<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">A</span></td>
								<td align="left" <cfif Highlight>class="bg_highlight"</cfif>>
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>		<!--- e.g. 004 in italics --->
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
									<cfif UCase(HomeGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
									&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
									<cfif UCase(AwayGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13bolditalic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13bold">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>	
								</td>
							<td align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<!---------- Date of Match ---------->
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10">Away Win was awarded</span></td>
							</CFCASE>
			
							<CFCASE VALUE="D">
								<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">D</span></td>
								<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">D</span></td>
								<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>		<!--- e.g. 004 in italics --->
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
									<cfif UCase(HomeGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
									&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
									<cfif UCase(AwayGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>	
								</td>
							<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<!---------- Date of Match ---------->
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10">Draw was awarded</span></td>
							</CFCASE>

							<!--- Postponed --->
							<CFCASE VALUE="P">
								<td colspan="2" align="center"><span class="pix18boldgray">P</span></td>
								
								<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>		<!--- e.g. 004 in italics --->
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
									<cfif UCase(HomeGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
									&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
									<cfif UCase(AwayGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>	
								</td>
							<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<!---------- Date of Match ---------->
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10">Postponed</span></td>
							</CFCASE>

							<!--- Abandoned --->
							<CFCASE VALUE="Q">
								<td colspan="2" align="center"><span class="pix18boldgray">A</span></td>
								
								<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>		<!--- e.g. 004 in italics --->
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
									<cfif UCase(HomeGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
									&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
									<cfif UCase(AwayGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>	
								</td>
							<td align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<!---------- Date of Match ---------->
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10">Abandoned</span></td>
							</CFCASE>
							
							<!--- Void --->
							<CFCASE VALUE="W">
								<td colspan="2" align="center"><span class="pix18boldgray">V</span></td>
								
								<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>		<!--- e.g. 004 in italics --->
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
									<cfif UCase(HomeGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
									&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
									<cfif UCase(AwayGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>	
								</td>
							<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
								<!---------- Date of Match ---------->
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
								<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
							</td>
							<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10">Void</span></td>
							</CFCASE>

							<!--- TEMP --->
							<CFCASE VALUE="T">
								<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
									<td colspan="2" align="center" bgcolor="aqua"><span class="pix18boldgray">TEMP</span></td>
									
									<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
										<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>		<!--- e.g. 004 in italics --->
											<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
										</cfif>
										<cfif UCase(HomeGuest) IS "GUEST">
											<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
											<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
										<cfelse>
											<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
											<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
										</cfif>
										&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
										<cfif UCase(AwayGuest) IS "GUEST">
											<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
											<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
										<cfelse>
											<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
											<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
										</cfif>	
									</td>
									<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
										<!---------- Date of Match ---------->
										<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
										<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
									</td>
									<td <cfif Highlight>class="bg_highlight"</cfif> width="150" align="center"><span class="pix10italic"> fixture hidden from the public </span></td>
								</cfif>
							</CFCASE>

							<CFDEFAULTCASE>
								<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">&nbsp;</span></td>
								<td <cfif Highlight>class="bg_highlight"</cfif> align="center"><span class="pix13">&nbsp;</span></td>
								<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
									<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0>		<!--- e.g. 004 in italics --->
										<span class="pix10italic">&nbsp; #NumberFormat(MatchNumber,"000")#</span>
									</cfif>
									<cfif UCase(HomeGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#HomeTeamName# #HomeOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#HomeID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#HomeTeamName# #HomeOrdinal#</span></a>
									</cfif>
									&nbsp;<span class="pix13">v</span>&nbsp; <!---------- Versus ---------->
									<cfif UCase(AwayGuest) IS "GUEST">
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13italic">#AwayTeamName# #AwayOrdinal#</span></a>
									<cfelse>
										<a href="TeamHist.cfm?CI=#AwayID#&DivisionID=#DivisionID#&TblName=Matches&LeagueCode=#LeagueCode#">
										<span class="pix13">#AwayTeamName# #AwayOrdinal#</span></a>
									</cfif>	
								</td>
								<td  align="left" <cfif Highlight>class="bg_highlight"</cfif>>
									<!---------- Date of Match ---------->
									<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">
									<span class="pix13">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
								</td>
								<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix13">&nbsp;</span></td>
							</CFDEFAULTCASE>
		
						</CFSWITCH>
				</cfif>
				<cfif HideFixtures IS "Yes" AND ListFind("Silver,Skyblue",request.SecurityLevel)><td bgcolor="gray"><span class="pix9white">fixture hidden from the public</span></td></cfif>
			</tr>
		</cfoutput>
	<tr>
		<td colspan="5" align="CENTER"><span class="pix10bold">Total #MtchCount#</td>
	</tr>
	</cfoutput>
</table>
