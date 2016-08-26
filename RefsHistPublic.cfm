<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>


<cfinclude template="queries/qry_QReferee_v1.cfm">
<cfset RefsHist = "Yes">  <!--- a switch to tell the Heading in Toolbar2 that it's a Referee's History --->
<cfinclude template="InclBegin.cfm">
<!--- After putting the Referee's name in Toolbar2, clear it out ready for the UpdateForm.cfm screen --->
<!---
Get information on marks awarded to this referee across ALL the Matches officiated by the specified Referee
across ALL competitions
--->

<cfinclude template="queries/qry_QRefereeHistory.cfm">
<cfif QRefereeHistory.RecordCount IS "0">
	<span class="pix18">No history.</span>
<cfelse>

	<cfif ListFind("Yellow",request.SecurityLevel) >
		<cfinclude template="queries/qry_QHide_Fixtures.cfm">
		<cfset HideDatesList = QuotedValueList(QHide_Fixtures.EventDate)>
	</cfif>
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
	<tr>
		<td>
		<span class="pix13bold"><cfoutput>#QRefereeHistory.RecordCount#</cfoutput> in list<BR></span>
		</td>
	</tr>
	<cfoutput query="QRefereeHistory" >
		<!--- Check Hide_Fixtures for Yellow security Level --->
		<cfif ListFind("Yellow",request.SecurityLevel) AND Find('#DateFormat(QRefereeHistory.FixtureDate,"YYYY-MM-DD")#','#HideDatesList#')>
			<tr>
				<td colspan="7" bgcolor="silver">
					<span class="pix13bold">Fixture Hidden for #DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span>
				</td>
			</tr>
		<cfelseif ListFind("Yellow",request.SecurityLevel) AND QRefereeHistory.Result IS "T">
			<!--- do not display TEMP fixtures --->
		<cfelse>

			<tr>
				<td align="left">
					<span class="pix13">#CompetitionName#</span>
					<cfif TRIM(#RoundName#)IS NOT "" >
						 <span class="pix13"><BR>#RoundName#</span>
					</cfif>
				</td>
				<td align="right">
					<span class="pix13">#HomeTeam# #HomeOrdinal#</span>
				</td>
				<cfif Result IS "P">
					<td colspan="3" align="center"><span class="pix18boldgray">P</span></td>
				<cfelseif Result IS "Q">
					<td colspan="3" align="center"><span class="pix18boldgray">A</span></td>
				<cfelseif Result IS "W">
					<td colspan="3" align="center"><span class="pix18boldgray">V</span></td>
				<cfelseif Result IS "T">
					<td colspan="3" align="center" bgcolor="aqua"><span class="pix18boldgray">TEMP</span></td>
				<cfelse>
					<cfif HideScore IS "Yes" AND ListFind("Yellow",request.SecurityLevel) >
						<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
					<cfelse>
						<td align="CENTER">
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
						<td>v</td>
						<td align="CENTER">
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
				</cfif>
				<td align="left">
					<span class="pix13">
					#AwayTeam# #AwayOrdinal#
					<cfif Result IS "H" AND HideScore IS "No">[ Home Win was awarded ]
					<cfelseif Result IS "A" AND HideScore IS "No">[ Away Win was awarded ]
					<cfelseif Result IS "U" AND HideScore IS "No">[ Home Win on penalties ]
					<cfelseif Result IS "V" AND HideScore IS "No">[ Away Win on penalties ]
					<cfelseif Result IS "D" AND HideScore IS "No">[ Draw was awarded ]
					<cfelseif Result IS "P" >[ Postponed ]
					<cfelseif Result IS "Q" >[ Abandoned ]
					<cfelseif Result IS "W" >[ Void ]
					<cfelseif Result IS "T" > <strong><em>hidden from the public</em></strong>
					<cfelse>
					</cfif> 
					</span>
				</td>
				<td align="left">
					<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix13bold">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a>
				</td>			
				<td align="left">
					<span class="pix13">
					<cfif AsstRef1ID IS #RI#>Asst1</cfif>
					<cfif AsstRef2ID IS #RI#>Asst2</cfif>
					<cfif RefereeID IS #RI#>Referee</cfif>
					<cfif FourthOfficialID IS #RI#>Fourth</cfif>
					</span>
				</td>			
			</tr>
		</cfif>
	</cfoutput>
	</table>
</cfif>
<hr>
