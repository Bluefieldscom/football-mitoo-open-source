<cfsilent>
<CFPARAM NAME="LeagueCode" DEFAULT="#DefaultLeagueCode#" >
<CFPARAM NAME="TblName" DEFAULT="#DefaultTblName#" >
<!--- I've fixed it so that the default Division is shown --->
<CFPARAM NAME="DivisionID" DEFAULT="#DefaultDivisionID#" >
<CFPARAM NAME="TeamID" DEFAULT=0 >
<CFPARAM NAME="HomeID" DEFAULT=0 >
<CFPARAM NAME="AwayID" DEFAULT=0 >
<CFPARAM NAME="OrdinalID" DEFAULT=0 >
<CFPARAM NAME="ThisMatchNoID" DEFAULT=0 >
<CFPARAM NAME="NextMatchNoID" DEFAULT=0 >
<CFPARAM NAME="MDate" DEFAULT=0 >
<CFPARAM NAME="CI" DEFAULT=0 >
</cfsilent>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" <cfif left(CGI.HTTP_REFERER,21) IS "http://localhost:8501">bgcolor="aqua"</cfif>>
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<cfoutput>
						<cfset ToolTipText = "Click on logo to go back to #request.County#" >				
						<td align="center" valign="middle"><a href="Counties.cfm?County=#request.County#" onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#ToolTipText#')"><img src="mitoo_logo1.png" alt="Go back to #request.County#" border="0"></a></td>
						<!--- facebook --->
						<td>&nbsp;</td>
						<td>
						<iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.facebook.com%2Fpages%2FFootball-Mitoo%2F143160752389963&amp;layout=standard&amp;show_faces=false&amp;width=240&amp;action=like&amp;font=verdana&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:250px; height:35px;" allowTransparency="true"></iframe>
						</td>
						<!--- <td><g:plusone size="medium"></g:plusone></td> --->
						
					</cfoutput>
				</tr>
				
			</table>
		</td>
		
<!---
		*********************************
		* Leaderboard (728 x 90 pixel)  *
		*********************************
--->
		<td align="right">
			<div id="t1_top" style="width:728px; height:90px; border:0px;">
				<!--- do not display leaderboard if logged in as administrator --->
				<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel)>
					<!--- Long term pagegrabber introduced 14th May 2013 --->
					<div id="ut_piggyback"><script type="text/javascript" src="http://cdn.undertone.com/js/piggyback.js?zoneid=53223"></script></div>
					<!---
					<cfif DefaultYouthLeague IS 0> <!--- adult --->
						<cfinclude template=" ">
					<cfelse>       <!--- youth --->
						<cfinclude template=" ">
					</cfif>
					--->
					<cfinclude template="adverts/incl728x90TOP.cfm">
				<cfelse>
					<span class="pix10silver">Advertising suppressed<br>for administrators</span>
					<cfif HideThisSeason IS "1">
						<table border="1" cellpadding="5" cellspacing="0" bgcolor="yellow">
							<tr>
								<td height="30">
									<span class="pix13bold"><cfoutput>#SeasonName#</cfoutput> is hidden from the public.<br>Please email <a href="mailto:INSERT_EMAIL_HERE">INSERT_EMAIL_HERE</a> when you are ready to publish.</span>
								</td>
							</tr>
						</table>
					</cfif>				
				</cfif>
			</div>
		</td>
	</tr>
	<tr><td height="5"><img src="trans.gif" height="1" width="1" /></td></tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="mainMenu">
	<tr>
		<!---
		********************************************************************************
		* This produces the Top darker blue menu bar that is always present at the top *
		********************************************************************************
		 --->
		<!--- Get a list of all the Fixture Dates from Fixture to spread across the top menu bar --->
		<cfsilent>
		<cfinclude template="queries/qry_GetFixtureDates.cfm">
		<cfset ListOfDistinctDates=ValueList(GetFixtureDates.FixtureDate)>
		<cfinclude template="queries/qry_GetFixtureMonths.cfm">
		<cfset ListOfDistinctMonths=ValueList(GetFixtureMonths.CalMonth)>
		<!--- Get a list of all the Divisions (short description) 
		to spread across the top menu bar, note that it's sorted by Medium field --->
		<cfinclude template="queries/qry_GetDivision_v1.cfm">
		<CFPARAM name="KO" default="No">
		<cfinclude template="queries/qry_QKnockOut.cfm">
		<cfif Left(QKnockOut.Notes,2) IS "KO" >
			<cfset KO = "Yes">
		</cfif>
		</cfsilent>
		
	
		<!--- This produces the first part with 5 columns:
		 Fixtures & Results | Unscheduled Matches | Table  | Grid | Latest | Video
		--->
		<cfoutput>
		
		<td>
		<!--- Make the Link bold if it is what is currently being viewed (apart from Latest and Video which are in "_blank" target --->

			<cfif FindNoCase("FixtResMonth.cfm", CGI.Script_Name)>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# Fixtures and Results for #MonthAsString(Month(Now()))#">
					<a href="FixtResMonth.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&MonthNo=#Month(Now())#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Fixtures&nbsp;&amp;&nbsp;Results</strong></a> 
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Fixtures&nbsp;&amp;&nbsp;Results</strong></a> 
				</cfif>
			<cfelse>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# Fixtures and Results for #MonthAsString(Month(Now()))#">
          			<a href="FixtResMonth.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&MonthNo=#Month(Now())#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Fixtures&nbsp;&amp;&nbsp;Results</a> 
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Fixtures&nbsp;&amp;&nbsp;Results</a> 
				</cfif>
			</cfif>
			|
			<cfif FindNoCase("Unsched.cfm", CGI.Script_Name)>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# Unscheduled Matches plus games Postponed, Abandoned, Void or Awaiting confirmation of dates">
					<a href="Unsched.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Unscheduled&nbsp;Matches</strong></a>
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Unscheduled&nbsp;Matches</strong></a> 
				</cfif>
			<cfelse>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# Unscheduled Matches plus games Postponed, Abandoned, Void or Awaiting confirmation of dates">
					<a href="Unsched.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Unscheduled&nbsp;Matches</a>
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Unscheduled&nbsp;Matches</a> 
				</cfif>
			</cfif>
			| 
		<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition --->
		<cfif KO IS "No">
			<cfif FindNoCase("LeagueTab.cfm", CGI.Script_Name)>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# League Table. There are buttons for Leading Goalscorers, Attendance Statistics, and more options under the table.">
					<a href="LeagueTab.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Table</strong></a>&nbsp;
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Table</strong></a> 
				</cfif>
			<cfelse>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# League Table. There are buttons for Leading Goalscorers, Attendance Statistics, and more options under the table.">
					<a href="LeagueTab.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Table</a>&nbsp;
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Table</a> 
				</cfif>
			</cfif>
			|
			<cfif FindNoCase("ResultsGrid.cfm", CGI.Script_Name)>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# Fixtures &amp;&nbsp;Results Grid">
					<a href="ResultsGrid.cfm?DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Grid</strong></a>&nbsp;
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Grid</strong></a> 
				</cfif>
			<cfelse>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# Fixtures &amp;&nbsp;Results Grid">
					<a href="ResultsGrid.cfm?DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Grid</a>&nbsp;
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Grid</a> 
				</cfif>
			</cfif>
		<cfelse> <!--- KO IS "Yes" --->
			<cfif FindNoCase("KOHist.cfm", CGI.Script_Name)>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# Knock Out History">
					<a href="KOHist.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Knock&nbsp;Out&nbsp;History</strong></a>&nbsp;
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Knock&nbsp;Out&nbsp;History</strong></a> 
				</cfif>
			<cfelse>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<cfset TooltipText="#QKnockOut.CompetitionDescription# Knock Out History">
					<a href="KOHist.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Knock&nbsp;Out&nbsp;History</a>&nbsp;
				<cfelse>
					<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
					<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Knock&nbsp;Out&nbsp;History</a> 
				</cfif>
			</cfif>
		</cfif>
			|
			<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
				<cfset TooltipText="Latest Fixtures &amp;&nbsp;Results<br>All Competitions">
				<a href="Latest.cfm?LeagueCode=#LeagueCode#" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Latest</a>
			<cfelse>
				<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
				<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Latest</a> 
			</cfif>
			|
			<a href="http://mitoo.co/download-app" target="_blank" >Download app</a>

		</td>
		</cfoutput>
		
		<cfif StructKeyExists(session, "fmEmail")>
			<cflock scope="session" timeout="10" type="readonly">
				<cfset request.fmEmail = session.fmEmail >
			</cflock>
		<cfelse>
			<cfset request.fmEmail = "Desktop">
		</cfif>


		<cfif StructKeyExists(session, "fmView")>
			<cflock scope="session" timeout="10" type="readonly">
				<cfset request.fmView = session.fmView >
			</cflock>
		<cfelse>
			<cfset request.fmView = "DropDown">
			<!---
			<cfif GetDivision.RecordCount GT 35 >
				<cfset request.fmView = "DropDown">
			<cfelse>
				<cfset request.fmView = "Classic">
			</cfif>
			--->
		</cfif>
		<cfif request.fmView IS "Classic">
		<!--- This produces all the possible Divisions - short description e.g.
					SCup ICup JCup Div1 Div2 Div3 Div4 Div5 Div6 Div7 Vets 
					note that the sort sequence on Medium ensures correct order...
		--->
		<td width="50%" align="justify" >

			<cfoutput query="GetDivision">
				<!--- TooltipText fix for Classic viewing when mouse over competition code, e.g. Div1C displays "The Jim Rogers President's Division One Cup" 
				repairs anomalies for ampersand and apostrophe --->
				<cfset TooltipText = #Replace(GetDivision.CompetitionDescription, "'", "\'", "ALL")#>
				<cfset TooltipText = #Replace(TooltipText, "&", "& ", "ALL")#>
				<!--- If the user happens to be currently looking at, say, League Tables
				then if he changes from one Div to another Div he will continue to see League Tables...
				similarly for Fixtures & Results or Unscheduled Matches --->
				
				<cfif FindNoCase("Unsched.cfm", CGI.Script_Name)>
					<cfinclude template="InclToolbar1Unsched.cfm">
				<cfelseif FindNoCase("FixtResMonth.cfm", CGI.Script_Name)>
					<cfinclude template="InclToolbar1FixtResMonth.cfm">
				<cfelseif FindNoCase("LeagueTab.cfm", CGI.Script_Name)>
					<cfinclude template="InclToolbar1LeagueTab.cfm">
				<cfelseif FindNoCase("LeagueTabExpand.cfm", CGI.Script_Name)>
					<cfinclude template="InclToolbar1LeagueTabExpand.cfm">
				<cfelseif FindNoCase("ResultsGrid.cfm", CGI.Script_Name)>
					<cfinclude template="InclToolbar1ResultsGrid.cfm">
				<cfelseif FindNoCase("KOHist.cfm", CGI.Script_Name)>
					<cfinclude template="InclToolbar1KOHist.cfm">
				<cfelse>
					<!--- Default to Fixtures & Results --->
					<cfinclude template="InclToolbar1FixtResMonth.cfm">
				</cfif>

			</cfoutput>
		</td>
		<cfelseif request.fmView IS "DropDown">
		<td width="50%" align="left"><span class="pix10boldwhite">Competition</span>
				<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
					<select size="1" style="font-family:#font_face#; font-size:11px;" onchange="location=this.options[this.selectedIndex].value;">
						<cfoutput query="GetDivision"> 
							<cfif FindNoCase("Unsched.cfm", CGI.Script_Name)>
								<option value="Unsched.cfm?TblName=Matches&DivisionID=#GetDivision.CompetitionID#&LeagueCode=#LeagueCode#" <cfif GetDivision.CompetitionID IS DivisionID>selected</cfif> >#CompetitionDescription#</option>
							<cfelseif FindNoCase("FixtResMonth.cfm", CGI.Script_Name)>
								<option value="FixtResMonth.cfm?TblName=Matches&DivisionID=#GetDivision.CompetitionID#&LeagueCode=#LeagueCode#&MonthNo=#Month(Now())#" <cfif GetDivision.CompetitionID IS DivisionID>selected</cfif> >#CompetitionDescription#</option>
							<cfelseif FindNoCase("LeagueTab.cfm", CGI.Script_Name)>
								<option value="LeagueTab.cfm?TblName=Matches&DivisionID=#GetDivision.CompetitionID#&LeagueCode=#LeagueCode#" <cfif GetDivision.CompetitionID IS DivisionID>selected</cfif> >#CompetitionDescription#</option>
							<cfelseif FindNoCase("LeagueTabExpand.cfm", CGI.Script_Name)>
								<option value="LeagueTabExpand.cfm?TblName=Matches&DivisionID=#GetDivision.CompetitionID#&LeagueCode=#LeagueCode#" <cfif GetDivision.CompetitionID IS DivisionID>selected</cfif> >#CompetitionDescription#</option>
							<cfelseif FindNoCase("ResultsGrid.cfm", CGI.Script_Name)>
								<option value="ResultsGrid.cfm?TblName=Matches&DivisionID=#GetDivision.CompetitionID#&LeagueCode=#LeagueCode#" <cfif GetDivision.CompetitionID IS DivisionID>selected</cfif> >#CompetitionDescription#</option>
							<cfelseif FindNoCase("KOHist.cfm", CGI.Script_Name)>
								<option value="KOHist.cfm?TblName=Matches&DivisionID=#GetDivision.CompetitionID#&LeagueCode=#LeagueCode#" <cfif GetDivision.CompetitionID IS DivisionID>selected</cfif> >#CompetitionDescription#</option>
							<cfelse>
								<!--- Default to Fixtures & Results --->
								<option value="FixtResMonth.cfm?TblName=Matches&DivisionID=#GetDivision.CompetitionID#&LeagueCode=#LeagueCode#&MonthNo=#Month(Now())#" <cfif GetDivision.CompetitionID IS DivisionID>selected</cfif> >#CompetitionDescription#</option>
							</cfif>
						</cfoutput>
						<option value="x" disabled="disabled">--------------------------------------------------</option>
						<cfoutput><option value="ViewChange.cfm?LeagueCode=#LeagueCode#">Change the mode in which you view screens</option></cfoutput>
					</select>
				<cfelse>
					<select size="1" style="font-family:#font_face#; font-size:11px;" onchange="window.open(location=this.options[this.selectedIndex].value,'_blank');"> 
						<cfoutput query="GetDivision"> 
								<option value="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1"   <cfif GetDivision.CompetitionID IS DivisionID>selected</cfif> >#CompetitionDescription#</option>
						</cfoutput>
					</select>
				</cfif>
		</td>
		<cfelse>
			request.fmView error in Toolbar1.cfm - aborting
			<cfabort>
		</cfif>
		<cfoutput>
		<td align="RIGHT" >
		
			<table border="0" cellpadding="2" cellspacing="2">
				<tr>
					<cfset LoginBGColor = "#request.SecurityLevel#">
					<td valign="top" bgcolor="#LoginBGColor#">
						<!---
							......... Login
						--->
						<cfif ListFind("Silver,Skyblue,Orange,Yellow",request.SecurityLevel) >
							<a href="LogInOut.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix10navy">LogOut</span></a>
						<cfelse>
							<cfif FindNoCase("SecurityCheck.cfm", CGI.Script_Name)>			
								<a href="LogInOut.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix10boldnavy">LogIn</span></a>
							<cfelse>
								<a href="LogInOut.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix10navy">LogIn</span></a>
							</cfif>
						</cfif>
					</td>
					<td valign="top">
						<!---
							......... Home (News)
						--->
							<cfif FindNoCase("News.cfm", CGI.Script_Name)>
								<cfset TooltipText="Home Page, Noticeboard, News and Diary">
								<a href="News.cfm?LeagueCode=#LeagueCode#&NB=0" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Home</strong></a>
							<cfelse>
								<cfset TooltipText="Home Page, Noticeboard, News and Diary">
								<a href="News.cfm?LeagueCode=#LeagueCode#&NB=0" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Home</a>
							</cfif>
					</td>
					<td valign="top">
						<!---
							.........  Clubs
						--->
						<cfif FindNoCase("ClubList.cfm", CGI.Script_Name)>
							<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
								<cfset TooltipText="Club Information and Club Search">
								<a href="ClubList.cfm?LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Clubs</strong></a>
							<cfelse>
								<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
								<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><strong>Clubs</strong></a> 
							</cfif>
						<cfelse>
							<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
								<cfset TooltipText="Club Information and Club Search">
								<a href="ClubList.cfm?LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Clubs</a>
							<cfelse>
								<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
								<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')">Clubs</a> 
							</cfif>
						</cfif>
					</td>
				</tr>
			</table>
		</td>
				
		</cfoutput>
		
	</tr>

	<!--- ********** END OF THE TOP MENU BAR ************ --->
	
	<cfinclude template="queries\qry_QNameSort.cfm">


	<tr>
		<td valign="top" colspan="4" align="left" >
			<table valign="top" align="left" border="0" cellspacing="2" cellpadding="2">
				<tr>  
			<!--- Drop Down of Seasons --->																	   			
			<cfif QNameSort.RecordCount GT 1 >
					<td align="center">	
			<span class="pix10boldwhite">Season<br />
				<select size="1" style="font-family:#font_face#; font-size:11px;" onchange="location=this.options[this.selectedIndex].value;">
					<cfoutput query="QNameSort">
						<option value="News.cfm?LeagueCode=#DefaultLeagueCode#&NB=0"  <cfif QNameSort.DefaultLeagueCode IS LeagueCode>selected</cfif>  >#Replace(SeasonName, " Season", "", "ALL")#</option>
					</cfoutput>
				</select>
			 </span>
		</td>
	</cfif>

				
	<!--- Calendar of Match Dates  --->
				<cfoutput query="GetFixtureDates" group="CalMonth">
					<td align="center" valign="top">
						<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel)>
							<cfset TooltipText="#QKnockOut.CompetitionDescription# Fixtures and Results for #MonthAsString(GetFixtureDates.CalMonth)#.<br><br>Select a date from the drop down for all the games on the chosen Match Day.">
							<a href="FixtResMonth.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&MonthNo=#CalMonth#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#MonthAsString(CalMonth)#</span></a> <BR>
						<cfelse>
							<cfset TooltipText="Because you are not logged in you are being redirected to mitoo.com">
							<a href="http://www.mitoo.com/beta?league&leaguecode=#LeagueCodePrefix#&nonko=1" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('#TooltipText#')"><span class="pix10">#MonthAsString(CalMonth)#</span></a> <BR>
						</cfif>
									<select name="fred" size="1" style="font-family:#font_face#; font-size:12px;" onchange="location=this.options[this.selectedIndex].value;">
									<option value="">Select</option>
									<cfoutput><option value="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(FixtureDate,'YYYY-MM-DD')#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">#DateFormat(FixtureDate, 'DD DDD')#</option></cfoutput>
									</select>
					
					
					
					</td>
					</cfoutput>
					<cfoutput>
			  		</cfoutput>
				</tr>
			</table>
		</td>
		
	</tr>
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
		<!---
		*********************************************************************************
		* This produces the second darker blue menu bar that is only present at the top *
		* if the user has logged in correctly                                           *
		*********************************************************************************
		 --->
		<cfsilent>
		<cfinclude template="queries/qry_LookUpList.cfm">
		</cfsilent>
		<tr>
			<td colspan="4" align="center" >
				<table border="0" cellpadding="2" cellspacing="2" >
					<tr>
					<!--- second darker blue menu bar
							This produces all the possible LookUp tables - short description e.g.
							Division Ordinal Referee Team etc
							note that the sort sequence is alphabetical on TableName field...
					--->	
					<cfoutput query="LookUpList">
						<td align="center" ><span class="pix10"><a href="LUList.cfm?TblName=#TableName#&LeagueCode=#LeagueCode#" >#TableName#</a> | </span></td>
					</cfoutput>
					<cfoutput>
						<!---  Constitution	--->
						<td align="center" ><span class="pix10"><a href="ListChoose.cfm?TblName=Constitution&TeamID=0&LeagueCode=#LeagueCode#&DivisionID=0">Constitution</a> | </span></td>
	
						<!---  Fines and Payments
						<cfif DefaultRulesAndFines IS "Yes">
							<a href="ListChoose.cfm?TblName=FinesAndPayments&TeamID=0&LeagueCode=#LeagueCode#"><span class="pix10">Fines and Payments</span></a>&nbsp;
						</cfif>
						--->
	
						<!---  Batch Input --->
						<td align="center" ><span class="pix10"><a href="BatchInput.cfm?LeagueCode=#LeagueCode#" >Batch Input</a></span></td>
	
						<!---  Venue and PitchAvailable	--->
						<cfif VenueAndPitchAvailable IS "Yes">
							<td>
								<table border="0" cellpadding="2" cellspacing="0" >
									<tr>
										<td colspan="2" align="center"><span class="pix10boldwhite">Pitch Availability by</span></td>
									</tr>
									<tr>
										<cfif QVenue.RecordCount GT 0 >
											<td align="center"><span class="pix10"><a href="ListChoose.cfm?TblName=PitchAvailable&LeagueCode=#LeagueCode#&PA=Venue">Venue</a> | </span></td>
										</cfif>
										<cfif QTeamOrdinal.RecordCount GT 0 >
											<td align="center"><span class="pix10"><a href="ListChoose.cfm?TblName=PitchAvailable&LeagueCode=#LeagueCode#&PA=Team">Team</a></span></td>
										</cfif>
									</tr>
								</table>
							</td>
						</cfif>
					</cfoutput>
					</tr>
				</table>
				<table border="0" cellpadding="2" cellspacing="2" >
					<tr>
					<cfoutput>
						<!---  Batch Input --->
						<cfset ToolTipText = "Probably the best place to start!">
						<td align="center" ><span class="pix10"><a href="RegisteredPlayers.cfm?LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=200;return escape('#TooltipText#')">Registered Players Analysis</a> | </span></td>
						<td align="center" ><span class="pix10"><a href="LUList.cfm?Transfer=Y&TblName=Player&LeagueCode=#LeagueCode#">Transfers</a> | </span></td>
						<td align="center" ><span class="pix10"><a href="LUList.cfm?Suspended=Y&TblName=Player&LeagueCode=#LeagueCode#">Suspensions</a> | </span></td>
						<cfset ToolTipText = "Please click to get the latest Match Ban information.<br><br>Please read <u>Match Bans</u> (in the Administration Reports menu)">
						<cfinclude template="queries/qry_QMatchBanHeaderCount.cfm">
						<cfif QMatchBanHeaderCount.cnt GT 0 AND MatchBanReminder IS 1 AND NOT (FindNoCase("LUList.cfm", CGI.Script_Name) AND StructKeyExists(url,"Suspended") AND url.Suspended IS "MB")>
							<td height="30" align="center" bgcolor="red" ><span class="pix10"><a href="LUList.cfm?Suspended=MB&TblName=Player&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">Match Bans</a> | </span></td>
						<cfelse>
							<td align="center" ><span class="pix10"><a href="LUList.cfm?Suspended=MB&TblName=Player&LeagueCode=#LeagueCode#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">Match Bans</a> | </span></td>
						</cfif>
						<td align="center" ><span class="pix10"><a href="LUList.cfm?Unregistered=Y&TblName=Player&LeagueCode=#LeagueCode#">Unregistered</a> | </span></td>
					</cfoutput>
					</tr>
				</table>
			</td>
		</tr>
	</cfif>
</table>
