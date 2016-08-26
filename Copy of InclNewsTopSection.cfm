<cfset SimpleLeagueName = #Replace(LeagueName, "<br />", " ", "ALL")#>


<div class="subMenu1">

<!---
<cfoutput>
<!--- News --->
<cfset ToolTipText = "Latest news and information from the <em>#SimpleLeagueName#</em>">
<a href="ShowNews.cfm?LeagueCode=#LeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank" 
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
News</a>&nbsp; | &nbsp;
</cfoutput>
--->

<cfoutput>
<!--- Download Documents --->
<cfset ToolTipText = "Download official <em>#SimpleLeagueName#</em> forms and documents">
<a href="DownloadDocuments.cfm?LeagueCode=#LeagueCode#&LeagueCodePrefix=#LeagueCodePrefix#" target="#LeagueCode#Docs" 
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
Download</a>&nbsp; | &nbsp;
</cfoutput>
<cfoutput>
<!--- Contacts --->
<cfset ToolTipText = "Do you want to get in touch with the <em>#SimpleLeagueName#</em>? Here are the names and contact details of people on their management committee">
<a href="ShowContacts.cfm?LeagueCode=#LeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="#LeagueCode#Contacts" 
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
Contacts</a>&nbsp; | &nbsp;
</cfoutput>
<cfoutput>
<!--- Mode --->
<cfset ToolTipText = "Change the mode in which you view <em>football.mitoo</em> screens">
<a href="ViewChange.cfm?LeagueCode=#LeagueCode#" 
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
Mode</a>&nbsp; | &nbsp;
</cfoutput>
<cfoutput>
<!--- Top Twenty Goalscorers and Star Players--->
<cfset ToolTipText = "The top twenty goalscorers and top twenty star players in all competitions">
<a href="TopTwenty.cfm?LeagueCode=#LeagueCode#" 
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
Top 20</a>&nbsp; | &nbsp;
</cfoutput>
<cfoutput>
<!--- Register your interest --->
<cfset ToolTipText = "Register your interest in <em>football.mitoo</em> and the <em>#SimpleLeagueName#</em>">
<a href="Register.cfm?LeagueCode=#LeagueCode#" 
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
Register</a>&nbsp; | &nbsp;
</cfoutput>
<cfoutput>
<!--- About football.mitoo --->
<cfset ToolTipText = "More information about <em>football.mitoo</em>">
<a href="about.htm" target="_blank"
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
About</a>&nbsp; | &nbsp;
</cfoutput>
<cfoutput>
<!--- Photos --->
<cfset ToolTipText = "See photographs">
<a href="DownloadPictures.cfm?LeagueCode=#LeagueCode#&LeagueCodePrefix=#LeagueCodePrefix#" target="#LeagueCode#Photos"
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
Photos</a>&nbsp; | &nbsp;
</cfoutput>
</div>

<table width="100%" border="0"  cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">
			<table border="0" cellpadding="2" cellspacing="0">
				<!--- 
				*********************
				* Noticeboard Group *
				*********************
				--->
				<cfinclude template="queries/qry_QNoticeboard.cfm">
				<cfset AdvertCount = 0 >
				<cfset MaxAdvertCount = 3 >
				<cfoutput>
					<!--- Noticeboard heading line --->
					<cfset ToolTipText = "<center>Click to see the Noticeboard<br /><br /></center>This is a great place to advertise for new players to join your club or for a new manager.<br /><br /><center>Our noticeboard reaches thousands of people<br />Minimum ten weeks for £10</center><br />Please email me the names of the counties in which you want your advert to appear, the starting date, your headline and the wording, and a photograph or logo.">
					<tr>
						<td height="10">&nbsp;</td>	
					</tr>
					<tr>
						<td align="left" class="subMenu2"><a href="Noticeboard.cfm?countieslist=#countieslist#" target="Noticeboard" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=200;return escape('#TooltipText#')"><span class="pix13bold">Noticeboard</span></a></td>	
					</tr>
				</cfoutput>
				<cfoutput query="QNoticeboard">
					<!--- Noticeboard headlines --->
					<cfif AdvertCount GE MaxAdvertCount > <!--- restrict number of Noticeboard Advert Titles displayed  --->
						<cfset AdvertCount = AdvertCount + 1 >
					<cfelseif ShowEverywhere>
						<cfset AdvertCount = AdvertCount + 1 >
						<tr><td><span class="pix13">#DateFormat(StartDate,'dd mmm')#: #AdvertTitle#</span></td></tr>
					<cfelseif ShowForTheseCounties IS NOT "">
						<cfset ShowAdvert = "No">
						<cfloop index="I" from="1" to="#ListLen(QNoticeboard.ShowForTheseCounties)#" step="1">
							<cfif ListFindNoCase( CountiesList, ListGetAt(QNoticeboard.ShowForTheseCounties, I) )>
								<cfset ShowAdvert = "Yes">
							</cfif>
						</cfloop>
						<cfif ShowAdvert IS "Yes">
							<cfset AdvertCount = AdvertCount + 1 >
							<tr><td><span class="pix13">#DateFormat(StartDate,'dd mmm')#: #AdvertTitle#</span></td></tr>
						</cfif>
					</cfif>
				</cfoutput>
				<cfif AdvertCount LE MaxAdvertCount>
				<cfelse>
					<cfoutput>
						<tr><td><a href="Noticeboard.cfm?countieslist=#countieslist#" target="Noticeboard" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=200;return escape('#TooltipText#')"><span class="pix10bold">#AdvertCount-MaxAdvertCount# more ...</span></a></td></tr>
					</cfoutput>
				</cfif>  
				<!--- 
				******************
				* Newsitem Group *
				******************
				--->
				<cfinclude template="queries/qry_QNews_v2.cfm">
				<cfset NewsitemCount = 0 >
				<cfset MaxNewsitemCount = 3 >
				<cfoutput>
					<!--- Newsitem heading line --->
					<cfset ToolTipText = "Latest news and information from the <em>#SimpleLeagueName#</em>">
					<tr>
						<td height="10">&nbsp;</td>	
					</tr>
					<tr>
						<td align="left" class="subMenu2"><a href="ShowNews.cfm?LeagueCode=#LeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="Newsitems" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')"><span class="pix13bold">News</span></a></td>
					</tr>
				</cfoutput>
				<cfoutput query="QNews">
					<!--- Noticeboard headlines --->
					<cfif NewsitemCount GE MaxNewsitemCount > <!--- restrict number of Newsitem Titles displayed  --->
						<cfset NewsitemCount = NewsitemCount + 1 >
					<cfelseif Longcol IS "NOTICE">
					<cfelse>
						<cfset NewsitemCount = NewsitemCount + 1 >
						<tr><td><span class="pix13">#Longcol#</span></td></tr>
					</cfif>
				</cfoutput>
				<cfif NewsitemCount LE MaxNewsitemCount>
				<cfelse>
					<cfoutput>
						<tr><td><a href="ShowNews.cfm?LeagueCode=#LeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="Newsitems" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')"><span class="pix10bold">#NewsitemCount-MaxNewsitemCount# more ...</span></a></td></tr>
					</cfoutput>
				</cfif>  
				<!--- 
				******************
				* Event Calendar *
				******************
				--->
				<tr>
					<cfoutput>
					<tr>
						<td height="10">&nbsp;</td>	
					</tr>
					
						<td>

							<iframe src="EventCalendar.cfm?LeagueCode=#LeagueCode#" name="EventCalendar" width="100%" marginwidth="5" marginheight="5" align="left" scrolling="auto" frameborder="0" id="EventCalendar">
								<!--- info for non-compliant browsers here --->
								If you are seeing this text, your browser is unable to accept iframes.<br />
								We suggest downloading and installing a browser which will accept them <br />
								 if you wish to use the Calendar facility.
							</iframe>
						</td>
					</cfoutput>
				</tr>





			<!---
			<cfif ShowRefereeAvailability IS "No"  and FindNoCase("News.cfm", CGI.Script_Name) >
				<iframe src="EventCalendar.cfm?LeagueCode=#LeagueCode#" name="EventCalendar" marginwidth="5" marginheight="5" scrolling="auto" frameborder="0" id="EventCalendar">
					<!--- info for non-compliant browsers here --->
					If you are seeing this text, your browser is unable to accept iframes.<br />
					We suggest downloading and installing a browser which will accept them <br />
					 if you wish to use the Calendar facility.
				</iframe>
			</cfif>
			--->
















			</table>
		</td>
		<!--- GOALRUN MPU --->
		<td align="right" valign="top" bgcolor="white">
			<table border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<!--- NEED A PLAYER? A NEW MANAGER? A NEW CLUB? ADVERTISE HERE £1 PER WEEK --->
					<td align="right" valign="top" >
						<br><cfoutput><a href="Noticeboard.cfm?countieslist=#countieslist#" target="Noticeboard"><img src="need_a_player.jpg" border="0"></a></cfoutput>
					</td>
				</tr>
				<tr>
					<td height="10">&nbsp;</td>	
				</tr>
				<tr>
					<td>
						<!--/* OpenX iFrame Tag v2.6.2 */-->
						<iframe id='a2e95fda' name='a2e95fda' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?zoneid=24&amp;cb=INSERT_RANDOM_NUMBER_HERE' framespacing='0' frameborder='no' scrolling='no' width='300' height='250'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=a612f69b&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=24&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a612f69b' border='0' alt='' /></a>
						</iframe>
						<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>