<!--- called by LeagueTab.cfm and LeagueTabExpand.cfm --->
<cfset ButtonText = "">

<cfoutput>
	<!---
	<cfif NOT FindNoCase("ResultsGrid.cfm", CGI.Script_Name) >
		<tr>
			<td>
				<!--- Fixtures & Results Grid --->
				<cfset ButtonText = "Fixtures & Results Grid">
				<table class="buttonBrand">
					<tr>
						<td><cfset TooltipText="#DivisionName# Fixtures and Results Grid. Home teams in left hand column, Away teams in top row.">
							<a href="ResultsGrid.cfm?DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</cfif>
	--->
	<cfif NOT FindNoCase("LeagueLeadingGoalscorers.cfm", CGI.Script_Name) >
		<tr>
			<td>
				<!--- Leading Goalscorers --->
				<cfset ButtonText = "Leading Goalscorers">
				<table class="buttonBrand">
					<tr>
						<td><cfset TooltipText="#DivisionName# Leading Goalscorers">
							<a href="LeagueLeadingGoalscorers.cfm?DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</cfif>
	<cfif NOT FindNoCase("AttendanceStats.cfm", CGI.Script_Name) >
		<tr>
			<td>
				<!--- Attendance Statistics --->
				<cfset ButtonText = "Attendance Statistics">
				<table class="buttonBrand">
					<tr>
						<td><cfset TooltipText="#DivisionName# Attendance Statistics">
							<a href="AttendanceStats.cfm?DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</cfif>
	<cfif NOT FindNoCase("LeagueTab.cfm", CGI.Script_Name) >
		<tr>
			<td>
				<!---  Normal League Table --->
				<cfset ButtonText = "Normal League Table">
				<table class="buttonBrand">
					<tr>
						<td><cfset TooltipText="#DivisionName# Normal League Table showing Home and Away record combined">
							<a href="LeagueTab.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</cfif>
	<cfif NOT FindNoCase("LeagueTabExpand.cfm", CGI.Script_Name) >
		<tr>
			<td>
				<!--- Expanded League Table --->
				<cfset ButtonText = "Expanded Table">
				<table class="buttonBrand">
					<tr>
						<td><cfset TooltipText="#DivisionName# Expanded League Table showing Home and Away record separately">
							<a href="LeagueTabExpand.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</cfif>
	<tr>
		<td>
			<!--- Previous month's Form Table --->
			<cfset ButtonText = "#DateFormat(DateAdd("m",-1,Now()), 'MMMM')# Form Table">			
			<table class="buttonBrand">
				<tr>
					<td><cfset TooltipText="#DivisionName# #DateFormat(DateAdd('m',-1,Now()), 'MMMM')# Form Table">
						<a href="LeagueTabMonth.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&FormDate=#DateFormat(DateAdd('m',-1,Now()), 'YYYY-MM-DD')#&MPeriod=1" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<!--- Current month's Form Table --->
			<cfset ButtonText = "#DateFormat(DateAdd("m",-0,Now()), 'MMMM')# Form Table">			
			<table class="buttonBrand">
				<tr>
					<td><cfset TooltipText="#DivisionName# #DateFormat(DateAdd('m',-0,Now()), 'MMMM')# Form Table">
						<a href="LeagueTabMonth.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&FormDate=#DateFormat(DateAdd('m',-0,Now()), 'YYYY-MM-DD')#&MPeriod=1" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<!--- Two months combined Form Table --->
			<cfset ButtonText = "#DateFormat(DateAdd("m",-1,Now()), 'MMMM')# + #DateFormat(DateAdd("m",-0,Now()), 'MMMM')# Form Table">			
			<table class="buttonBrand">
				<tr>
					<td><cfset TooltipText="#DivisionName# #DateFormat(DateAdd('m',-1,Now()), 'MMMM')# + #DateFormat(DateAdd('m',-0,Now()), 'MMMM')# Form Table">
						<a href="LeagueTabMonth.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&FormDate=#DateFormat(DateAdd('m',-1,Now()), 'YYYY-MM-DD')#&MPeriod=2" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td>
		<!--- Normal League Table (Microsoft Excel) --->
			<cfset ButtonText = "Normal Table (Excel)">			
			<table class="buttonBrand">
				<tr>
					<td><cfset TooltipText="#DivisionName# Normal League Table output to Microsoft Excel spreadsheet. Use this for your publications.">
						<a href="LeagueTabXLS.cfm?LeagueCode=#LeagueCode#&DivisionID=#DivisionID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
		<!--- Expanded League Table (Microsoft Excel) --->
			<cfset ButtonText = "Expanded Table (Excel)">			
			<table class="buttonBrand">
				<tr>
					<td><cfset TooltipText="#DivisionName# Expanded League Table output to Microsoft Excel spreadsheet. Use this for your publications.">
						<a href="LeagueTabExpandXLS.cfm?LeagueCode=#LeagueCode#&DivisionID=#DivisionID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<!--- Results and Attendances Grids (Excel) --->
			<cfset ButtonText = "Results and Attendances Grids (Excel)">			
			<table class="buttonBrand">
				<tr>
					<td><cfset TooltipText="#DivisionName# Results and Attendances Grids output to Microsoft Excel spreadsheet. Use this for your publications.">
						<a href="ResultsGridXLS.cfm?LeagueCode=#LeagueCode#&DivisionID=#DivisionID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
		<tr>
			<td>
				<!--- Results Grid (Microsoft Excel) --->
				<cfset ButtonText = "Expenses (Excel)">			
				<table class="buttonBrand">
					<tr>
						<td><cfset TooltipText="#DivisionName# Match Officials Expenses output to Microsoft Excel spreadsheet.">
							<a href="MatchOfficialsExpensesGridXLS.cfm?LeagueCode=#LeagueCode#&DivisionID=#DivisionID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">#ButtonText#</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</cfif>
</cfoutput>