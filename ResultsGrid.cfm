<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
<cfelse>
	<cfoutput>
		<cflocation url="http://www.mitoo.com/beta?league&leaguecode=#request.CurrentLeagueCodePrefix#&nonko=1" addtoken="no">
	</cfoutput>
	<cfabort>
</cfif>

<cfinclude template="InclBegin.cfm">
<cfsilent>

<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition
If it is, then we'll jump over to Knock Out History instead
--->

<CFPARAM name="KO" default="No">

<cfinclude template="queries/qry_QKnockOut.cfm">

<cfif Left(QKnockOut.Notes,2) IS "KO" >
<!--- Jumping here.... --->
	<CFLOCATION URL=
		"KOHist.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" 
				ADDTOKEN="NO">
</cfif>

</cfsilent>

<cfif QKnockOut.CompetitionDescription IS "Miscellaneous" OR QKnockOut.CompetitionDescription IS "Friendly" >
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
		<table width="100%" border="0" cellspacing="2" cellpadding="0" >
			<tr>
				<cfoutput>
				<td align="CENTER"><span class="pix10">This #QKnockOut.CompetitionDescription# Grid has been hidden from the public </span></td>
				</cfoutput>
			</tr>
		</table>
	<cfelse>
		<table width="100%" border="0" cellspacing="2" cellpadding="0" >
			<tr>
				<cfoutput>
				<td align="CENTER"><span class="pix10">#QKnockOut.CompetitionDescription# Grid has been suppressed</span></td>
				</cfoutput>
			</tr>
		</table>
		<CFABORT>
	</cfif>
</cfif>

<cfinclude template = "queries/qry_QTeamList.cfm">
<cfinclude template = "queries/qry_QResults.cfm">
<cfset CIDList=ValueList(QTeamList.CID)>
<cfset TeamIDList=ValueList(QTeamList.TeamID)>
<cfset SaveColSpan = QTeamList.RecordCount + 1>

<br>
<table  border="0" cellspacing="2" cellpadding="2" >
	<tr>
		<td  align="CENTER"></td>

		<cfoutput query="QTeamList">
		<td width="100" align="center" bgcolor="##F5F5F5">
			<span class="pix10realblack"><cfif TeamNameMedium IS "">#TeamName#<cfelse>#TeamNameMedium#</cfif>
			<cfif OrdinalNameShort IS "">#OrdinalName#<cfelse>#OrdinalNameShort#</cfif></span>
		</td>
		</cfoutput>
	</tr>
	
	<cfoutput query="QTeamList">
		<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >

		<td align="LEFT" ><span class="pix10realblack">#TeamName# #OrdinalName#</span></td>
		<cfloop index="ColN" from="1" to="#QTeamList.RecordCount#" step="1" >
			<td align="CENTER"
			
			<cfif QTeamList.CID IS ListGetAt(CIDList, ColN)>
				class="bg_white"
			<cfelseif ListGetAt(TeamIDList, ColN) IS session.fmTeamID >
				class="bg_highlight"
			<cfelseif ListGetAt(TeamIDList, CurrentRow) IS session.fmTeamID >
				class="bg_highlight"
			</cfif>
			
			  >
				<!---<span class="pix10"><b><i>#ColN#</i></b></span>--->
				<cfif QTeamList.CID IS ListGetAt(CIDList, ColN)>
					<cfinclude template = "queries/qry_QGridHomeGames.cfm">
					<cfinclude template = "queries/qry_QGridAwayGames.cfm">
					<cfset HGCount = IIF(IsNumeric(QGridHomeGames.HomeGames),QGridHomeGames.HomeGames,0)>
					<cfset AGCount = IIF(IsNumeric(QGridAwayGames.AwayGames),QGridAwayGames.AwayGames,0)>

					<cfif HGCount IS 0 AND AGCount IS 0>
						&nbsp;
					<cfelse>
				 		<cfif ABS(HGCount - AGCount) GT 2>
							<span class="pix10red">H#HGCount# A#AGCount#</span>
						<cfelse>
							<span class="pix10grey">H#HGCount# A#AGCount#</span>
						</cfif>
					</cfif>
				<cfelse>
					
					<cfinclude template = "queries/qry_QGetResult.cfm">
					<cfset TooltipText="click to see match details">
					<cfloop query="QGetResult">
						<cfset HideFixtures = "No">
						<cfset ThisDate = DateFormat(FixtureDate, 'YYYY-MM-DD')>
						<!--- Hide the fixtures from the public if the Event Text says so --->
						<cfinclude template="queries/qry_QEventText.cfm">
						<cfif QEventText.RecordCount IS 1>
							<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
								<cfset HideFixtures = "Yes">
							</cfif>
						</cfif>
						<cfif HideFixtures IS "Yes">
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<cfset DateString = '#DateFormat(FixtureDate,"D MMM")#<br>hidden'>
							<cfelse>
								<cfset DateString = ''>
							</cfif>
						<cfelse>	
							<cfset DateString = '#DateFormat(FixtureDate,"D MMM")#'>							
						</cfif>
						<cfif Result IS "H" >
							<!--- Home Win --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR><span class="pix10realblack">Home Win<BR></span>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a>
								<cfif HideScore IS "Yes">
									<span class="pix10realblack"><BR>Played<BR></span>
								<cfelse>
									<span class="pix10realblack"><BR>Home Win<BR></span>
								</cfif>
							</cfif>
						<cfelseif Result IS "A" >
							<!--- Away Win --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR><span class="pix10realblack">Away Win<BR></span>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a>
								<cfif HideScore IS "Yes">
									<span class="pix10realblack"><BR>Played<BR></span>
								<cfelse>
									<span class="pix10realblack"><BR>Away Win<BR></span>
								</cfif>
							</cfif>
						<cfelseif Result IS "U" >
							<!--- Home Win on Penalties --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR><span class="pix10realblack">Home Win on pens<BR></span>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a>
								<cfif HideScore IS "Yes">
									<span class="pix10realblack"><BR>Played<BR></span>
								<cfelse>
									<span class="pix10realblack"><BR>Home Win on pens<BR></span>
								</cfif>
							</cfif>
						<cfelseif Result IS "V" >
							<!--- Away Win on Penalties --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR><span class="pix10realblack">Away Win on pens<BR></span>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a>
								<cfif HideScore IS "Yes">
									<span class="pix10realblack"><BR>Played<BR></span>
								<cfelse>
									<span class="pix10realblack"><BR>Away Win on pens<BR></span>
								</cfif>
							</cfif>
						<cfelseif Result IS "D" >
							<!--- Draw awarded --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR><span class="pix10realblack">Draw<BR></span>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a>
								<cfif HideScore IS "Yes">
									<span class="pix10realblack"><BR>Played<BR></span>
								<cfelse>
									<span class="pix10realblack"><BR>Draw<BR></span>
								</cfif>
							</cfif>
						<cfelseif Result IS "P" >
							<!--- Postponed --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR><span class="pix10boldred">Postponed</span><BR>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a>
								<span class="pix10boldred"><BR>Postponed<BR></span>								
							</cfif>
						<cfelseif Result IS "Q" >
							<!--- Abandoned --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR><span class="pix10bold">Abandoned</span><BR>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a>
								<span class="pix10bold"><BR>Abandoned<BR></span>								
							</cfif>
						<cfelseif Result IS "W" >
							<!--- Void --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR><span class="pix10bold">Void</span><BR>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a>
								<span class="pix10bold"><BR>Void<BR></span>								
							</cfif>
						<cfelseif Result IS "T" >
							<!--- TEMP --->
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR>							
								<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="aqua"><tr><td align="center"><span class="pix10grey"><strong>TEMP</strong></span><span class="pix9"><BR><em>hidden</em></span></td></tr></table>
							<cfelse>
							</cfif>
						<cfelse>
							<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DivisionID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=RG" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10realblack">#DateString#</span></a><BR>							
							<cfelse>
								<cfset TooltipText = "Go to #DateFormat(FixtureDate,'DDDD, DD MMMM YYYY')#">
								<cfset MDate = DateFormat(FixtureDate,'DD-MMM-YYYY')>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#MDate#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#DateString#</span></a><BR>								
							</cfif>
							<cfif HomeGoals IS "">
							<cfelseif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND HideScore IS "Yes" >
								<cfif HomeGoals GT AwayGoals><span class="pix10boldrealblack">Played<BR></span>
								<cfelseif HomeGoals LT AwayGoals><span class="pix10boldrealblack">Played<BR></span>
								<cfelseif HomeGoals IS AwayGoals><span class="pix10boldrealblack">Played<BR></span>
								</cfif>
							<cfelse>
							<span class="pix10boldrealblack">#HomeGoals#-#AwayGoals#<BR></span>
							</cfif>
						</cfif>
						<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0 ><span class="pix10realblack">#NumberFormat(HomePointsAdjust,"+9")# pts H<BR></span></cfif>
						<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0 ><span class="pix10realblack">#NumberFormat(AwayPointsAdjust,"+9")# pts A<BR></span></cfif>
					</cfloop>
					<cfif QGetResult.RecordCount IS 0>&nbsp;</cfif>
				</cfif>
			</td>
		</cfloop>
	</tr>
	</cfoutput>
</table>

<!--- next, underneath the grid display various buttons....... 
Leading Goalscorers
Attendance Statistics
Expanded League Table
.... etc
--->
<table width="100%" border="0" cellpadding="0" cellspacing="5" >
	<tr>
		<td valign="top">
			<table>
				<cfset DivisionName = Getlong.CompetitionDescription>
				<cfinclude template="InclLeagueTabButtons.cfm">
			</table>
		</td>
		<td align="center">
			<cfinclude template="InclLeagueTabAdvertsTbl.cfm">
		</td>
	</tr>
</table>

