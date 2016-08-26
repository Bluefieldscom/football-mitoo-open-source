<tr>
<cfoutput>		
				<!--- only for administrators who are logged in --->
				<td align="center" >
					<table class="buttonBrand">
						<tr>
							<cfif heading01 IS "Match Day - Quick View"> 
								<td>
									<!--- Match Day Quick View - MATCHES ONLY - CURRENTLY DISPLAYED --->
									<cfset TooltipText="Quick View<br>for #DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#">
									<a href="MtchDayQuick.cfm?MDate=#DateFormat(ThisDate, 'YYYY-MM-DD')#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=1;this.T_WIDTH=300;return escape('#TooltipText#')">&bull; Quick View &bull;</a>
								</td>
							<cfelse>
								<td>
									<!--- Match Day Quick View - MATCHES ONLY --->
									<cfset TooltipText="Quick View<br>for #DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#">
									<a href="MtchDayQuick.cfm?MDate=#DateFormat(ThisDate, 'YYYY-MM-DD')#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=1;this.T_WIDTH=300;return escape('#TooltipText#')">Quick View</a>
								</td>
							</cfif>
						</tr>
					</table>
				</td>
				
				<td align="center" >
					<table class="buttonBrand">
						<tr>
							<cfif heading01 IS "Match Day - Officials View"> 
								<td>
									<!--- Match Day Match Officials View  - (only for administrators who are logged in)--->
									<cfset TooltipText="Officials View<br>for #DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#">
									<a href="MtchDayOfficials.cfm?MDate=#DateFormat(ThisDate, 'YYYY-MM-DD')#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=1;this.T_WIDTH=300;return escape('#TooltipText#')">&bull; Officials View &bull;</a>
								</td>
							<cfelse>
								<td>
									<!--- Match Day Match Officials View  - (only for administrators who are logged in)--->
									<cfset TooltipText="Officials View<br>for #DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#">
									<a href="MtchDayOfficials.cfm?MDate=#DateFormat(ThisDate, 'YYYY-MM-DD')#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=1;this.T_WIDTH=300;return escape('#TooltipText#')">Officials View</a>
								</td>
							</cfif>
						</tr>
					</table>
				</td>
				
				<td align="center" >
					<table class="buttonBrand">
						<tr>
							<cfif heading01 IS "Match Day - Standard View"> 
								<td>
									<!--- Match Day Standard View - FULL INFORMATION --->
									<cfset TooltipText="Standard View<br>for #DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#<br> includes Teams Unavailable, Pitches Used Today, Pitches Unused Today, Referees Appointed Today, Referee Availability, Scores &amp;&nbsp;Attendance Batch Input, Referee Marks Batch Input">
									<a href="MtchDay.cfm?MDate=#DateFormat(ThisDate, 'YYYY-MM-DD')#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=1;this.T_WIDTH=300;return escape('#TooltipText#')">&bull; Standard View &bull;</a>
								</td>
							<cfelse>
								<td>
									<!--- Match Day Standard View - FULL INFORMATION --->
									<cfset TooltipText="Standard View<br>for #DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#<br> includes Teams Unavailable, Pitches Used Today, Pitches Unused Today, Referees Appointed Today, Referee Availability, Scores &amp;&nbsp;Attendance Batch Input, Referee Marks Batch Input">
									<a href="MtchDay.cfm?MDate=#DateFormat(ThisDate, 'YYYY-MM-DD')#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=1;this.T_WIDTH=300;return escape('#TooltipText#')">Standard View</a>
								</td>
							</cfif>
						</tr>
					</table>
				</td>
				</cfoutput>
</tr>				
