<!---

<cfoutput>
<a href="FixtResMonth.cfm?TblName=Matches&DivisionID=#GetDivision.CompetitionID#&LeagueCode=#LeagueCode#&MonthNo=#Month(Now())#" onmouseover="this.T_BORDERWIDTH=0;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='brown';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><cfif Left(GetDivision.CompetitionNotes,2) IS "KO" ><cfif GetDivision.CompetitionID IS DivisionID><span class="pix10bolditalic">#CompetitionCode#</span><cfelse><span class="pix10italic">#CompetitionCode#</span></cfif><cfelse><cfif GetDivision.CompetitionID IS DivisionID><span class="pix10bold">#CompetitionCode#</span><cfelse><span class="pix10">#CompetitionCode#</span></cfif></cfif></a>
</cfoutput>

--->




