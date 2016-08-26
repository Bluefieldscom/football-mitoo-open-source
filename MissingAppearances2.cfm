<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset DelayPeriod = 1>
<cfset BoundaryDate = CreateODBCDate(NOW()- DelayPeriod )>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!--- Ignore fixtures with HomeGoals IS NULL AND AwayGoals IS NULL, OR FixtureNotes LIKE '%TEAM SHEET MISSING%' --->
<cfinclude template="queries/qry_QResultHA.cfm">
<cfset ResultHAList = ValueList(QResultHA.ID)>
<cfset ResultHACount = QResultHA.RecordCount>
<cfif ResultHACount IS 0>
	<cfset ResultHAList = ListAppend(ResultHAList, 0)>
</cfif>

<cfinclude template="queries/qry_QMissingAppearances2.cfm">

<cfif QMissingAppearances2.RecordCount GT "0">
	<cfoutput>
		<span class="pix13bold"><BR><BR>Before #DateFormat( BoundaryDate , "DDDD, DD MMMM YYYY")#,
			<cfif QMissingAppearances2.RecordCount GT "1">
				there are #QMissingAppearances2.RecordCount# matches with team sheet(s) where </span><span class="pix13boldred">updating ALLOWED.<br></span>
			<cfelse>
				there's only one match with team sheet(s) where updates are </span><span class="pix13boldred">not prevented!<br></span>
			</cfif>
		<br><span class="pix13bold">Click on the <img src="lightgreen.jpg" border="0"> icon below to open the team sheet.</span>
		
	</cfoutput>
	<table border="0" cellpadding="2" cellspacing="0" class="loggedinScreen">
		<cfoutput query="QMissingAppearances2" group="FixtureDate">
			<tr><td height="40" colspan="6" valign="bottom"><hr><a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(FixtureDate,'DD-MMM-YY')#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix13boldblack">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a></td></tr>
			<cfoutput group="DivName">
				<tr>
				<td height="40" colspan="6" valign="bottom"><span class="pix13bold">#DivName#</span></td>
				</tr>
				<cfoutput>
				<cfif MType IS "Home">
					<tr>
						<td><span class="pix13boldred">#HomeTeam# #HomeOrdinal#</span></td>
						<cfif HomeTeamSheetOK IS 0><cfset ToolTipText = "Click to see the Home Team Sheet. Future updates by the club secretary ALLOWED."><cfelse><cfset ToolTipText = "Click to see the Home Team Sheet. Future updates by the club secretary PREVENTED."></cfif>
						<cfif HomeTeamSheetOK IS 0><td align="center">&nbsp;<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="lightgreen.jpg" border=0"></a>&nbsp;</td><cfelse><td align="center">&nbsp;<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="pink.jpg" border=0"></a>&nbsp;</td></cfif>
						<td align="center"><span class="pix13">#HomeGoals# v #AwayGoals#</span></td>
						<td>&nbsp;</td>
						<td><span class="pix13">#AwayTeam# #AwayOrdinal#</span><cfif TRIM(#RoundName#)IS NOT "" ><span class="pix13"> [ #RoundName# ]</span></cfif></td>
						<td><span class="pix10">#RefereeName#</span></td>
					</tr>
				<cfelseif MType IS "Away">
					<tr>
						<td align="right"><span class="pix13">#HomeTeam# #HomeOrdinal#</span></td>
						<td>&nbsp;</td>
						<td align="center"><span class="pix13">#HomeGoals# v #AwayGoals#</span></td>
						<cfif AwayTeamSheetOK IS 0><cfset ToolTipText = "Click to see the Away Team Sheet. Future updates by the club secretary ALLOWED."><cfelse><cfset ToolTipText = "Click to see the Away Team Sheet. Future updates by the club secretary PREVENTED."></cfif>
						<cfif AwayTeamSheetOK IS 0><td align="center">&nbsp;<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="lightgreen.jpg" border=0"></a>&nbsp;</td><cfelse><td align="center">&nbsp;<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="pink.jpg" border=0"></a>&nbsp;</td></cfif>
						<td><span class="pix13boldred">#AwayTeam# #AwayOrdinal#</span><cfif TRIM(#RoundName#)IS NOT "" ><span class="pix13"> [ #RoundName# ]</span></cfif></td>
						<td><span class="pix10">#RefereeName#</span></td>
					</tr>
				<cfelseif MType IS "Both">
					<tr>
						<td><span class="pix13boldred">#HomeTeam# #HomeOrdinal#</span></td>
						<cfif HomeTeamSheetOK IS 0><cfset ToolTipText = "Click to see the Home Team Sheet. Future updates by the club secretary ALLOWED."><cfelse><cfset ToolTipText = "Click to see the Home Team Sheet. Future updates by the club secretary PREVENTED."></cfif>
						<cfif HomeTeamSheetOK IS 0><td align="center">&nbsp;<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="lightgreen.jpg" border=0"></a>&nbsp;</td><cfelse><td align="center">&nbsp;<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="pink.jpg" border=0"></a>&nbsp;</td></cfif>
						<td align="center"><span class="pix13">#HomeGoals# v #AwayGoals#</span></td>
						<cfif AwayTeamSheetOK IS 0><cfset ToolTipText = "Click to see the Away Team Sheet. Future updates by the club secretary ALLOWED."><cfelse><cfset ToolTipText = "Click to see the Away Team Sheet. Future updates by the club secretary PREVENTED."></cfif>
						<cfif AwayTeamSheetOK IS 0><td align="center">&nbsp;<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="lightgreen.jpg" border=0"></a>&nbsp;</td><cfelse><td align="center">&nbsp;<a onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=180;return escape('#ToolTipText#')" href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="pink.jpg" border=0"></a>&nbsp;</td></cfif>
						<td><span class="pix13boldred">#AwayTeam# #AwayOrdinal#</span><cfif TRIM(#RoundName#)IS NOT "" ><span class="pix13"> [ #RoundName# ]</span></cfif></td>
						<td><span class="pix13">#RefereeName#</span></td>
					</tr>
				<cfelse>
					ERROR 2315 MissingAppearances.cfm
					<cfabort>
				</cfif>
				</cfoutput>
			</cfoutput>
		</cfoutput>
	</table>

<cfelse>
		<span class="pix13bold"><BR><BR>Before <cfoutput>#DateFormat( BoundaryDate , "DDDD, DD MMMM YYYY")#, there are no matches with with team sheets where updating ALLOWED.</cfoutput></span>
</cfif>	
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
