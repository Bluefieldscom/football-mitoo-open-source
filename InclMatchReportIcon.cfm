<cfoutput>
	<cfif #MatchReportID# IS "" >
		<cfset HomeTeamTxt = TRIM("#HomeTeam# #HomeOrdinal#") >
		<cfset AwayTeamTxt = TRIM("#AwayTeam# #AwayOrdinal#") >
		<cfif TRIM(#RoundName#)IS NOT "" >
			<cfset MatchReportHeading = "#MatchReportHeading#<BR>#CHR(10)##RoundName#">
		</cfif>
		<cfset MatchReportHeading = "#MatchReportHeading#<BR>#CHR(10)#<BR>#CHR(10)#<U>#HomeTeamTxt#</U>&nbsp;&nbsp;#HomeGoals#&nbsp;&nbsp;&nbsp;&nbsp;" >
		<cfset MatchReportHeading = "#MatchReportHeading#<U>#AwayTeamTxt#</U>&nbsp;&nbsp;#AwayGoals#" >
		<cfset MatchReportHeading = "<B>#MatchReportHeading#<BR>#CHR(10)#<BR>#CHR(10)##MatchReportDate#</B><BR>#CHR(10)#<BR>#CHR(10)#<BR>#CHR(10)#">
		<!--- add match report button  --->
		<cfset TooltipText="add a match report">
		<a class="buttonReporticon" href="UpdateForm.cfm?TblName=MatchReport&LeagueCode=#LeagueCode#&MatchReportHeading=#URLEncodedFormat(MatchReportHeading)#&MatchReportNo=#FID#" onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">R</a>
	<cfelse>
		<cfset TooltipText="update/delete match report">
		<a class="buttonReporticon" href="UpdateForm.cfm?TblName=MatchReport&id=#MatchReportID#&LeagueCode=#LeagueCode#" onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">R</a>
	</cfif>
</cfoutput>



