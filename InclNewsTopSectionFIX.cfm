<cfset SimpleLeagueName = #Replace(LeagueName, "<br />", " ", "ALL")#>
<div class="bigbuttonBrand">
<cfoutput>
<!--- Widget --->
<cfset ToolTipText = "Get iframe code for your own website.<br>Fixtures, results and tables.">
<a href="http://www.mitoo.com/beta?gen_iframe" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='pink';this.T_FONTSIZE='18px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
NEW: Code Generator</a></div>
</cfoutput>
<div align="left" class="subMenu1">
<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cfoutput>
	<!--- Email Options --->
	<cfset ToolTipText = "Select <u>Web Based</u> (e.g. Gmail, Hotmail) or <u>Desktop Based</u> (e.g. Outlook, Thunderbird). When you click on the envelope icon the program needs to know so it can format your email correctly.">
	<a href="EmailChange.cfm?LeagueCode=#LeagueCode#"
	onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
	Email</a>&nbsp; | &nbsp;
	</cfoutput>
</cfif>



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
<!--- Club Secretary's Instructions --->
<cfset ToolTipText = "You can now update your team colours and contact details, your teamsheet appearances, goalscorers, red/yellow cards, star player, referee marks and more.">
<a href="ClubSecretaryInstructions.htm" target="_blank"
onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
Club Secretary's Instructions</a>&nbsp; | &nbsp;
</cfoutput>
<cfset theItem="Development History for Administrators Only">
<!--- Development History for Administrators Only --->
<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cfoutput>
	<cfset ToolTipText = "Development History. Administrators only can view this.">
    <a href="News.cfm?LeagueCode=#LeagueCode#&DHist=Y&NB=0" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#TooltipText#')">
		 Development History </a>&nbsp; | &nbsp;
	</cfoutput>
</cfif>
</div>

<table width="100%" border="0"  cellpadding="0" cellspacing="0">
	<!---
	<cfif ListFind("White",request.SecurityLevel) >
		<tr>
			<td><cfwindow center="true" title="Noticeboard" headerstyle="background-color:##4C5464 ; font-family: Verdana, Arial, Helvetica, sans-serif; font-size:16pt; font-style:normal; font-weight:bold; color:##ffffff;"   width="1000" height="700" name="NoticeboardWindow"
					minHeight="400" minWidth="750" initshow="true" source="Noticeboard.cfm?countieslist=#countieslist#" />
			</td>
		</tr>
	</cfif>
	--->
	<tr>
		<td valign="top" align="left">
			<table border="0"  cellpadding="2" cellspacing="0">
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
					<cfset ToolTipText = "<center>Click to see the Noticeboard<br /><br /></center>This is a great place to advertise for new players to join your club or for a new manager.<br /><br /><center>Our noticeboard reaches thousands of people<br />Minimum ten weeks for 10</center><br />Please email me the names of the counties in which you want your advert to appear, the starting date, your headline and the wording, and a photograph or logo.">
					<tr>
						<td height="10">&nbsp;</td>
					</tr>
					<tr>
						<td align="left" class="subMenu2"><a href="Noticeboard.cfm?countieslist=#countieslist#&LeagueCode=#LeagueCode#" target="Noticeboard" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=200;return escape('#TooltipText#')"><span class="pix13bold">Noticeboard</span></a></td>
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
						<tr><td><a href="Noticeboard.cfm?countieslist=#countieslist#&LeagueCode=#LeagueCode#" target="Noticeboard" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='10px';this.T_PADDING=2;this.T_WIDTH=200;return escape('#TooltipText#')"><span class="pix10bold">#AdvertCount-MaxAdvertCount# more ...</span></a></td></tr>
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
						<td height="10">&nbsp;</td>
					</tr>
					<cfoutput>
					<tr>
						<td bgcolor="black">
							<iframe src="EventCalendar.cfm?LeagueCode=#LeagueCode#" name="EventCalendar" width="400" marginwidth="0" height="170" marginheight="0" align="left" scrolling="auto" frameborder="0" id="EventCalendar">
								<!--- info for non-compliant browsers here --->
								If you are seeing this text, your browser is unable to accept iframes.<br />
								We suggest downloading and installing a browser which will accept them <br />
								 if you wish to use the Calendar facility.
							</iframe>
						</td>
					</tr>
					</cfoutput>
			</table>
		</td>
		<td align="right" valign="top" bgcolor="white">
			<table border="0" cellpadding="2" cellspacing="0" >
			<!--- FedEx advert
				<cfif ListFind("White",request.SecurityLevel) > <!--- suppress annoying video FedEx advert for anyone logged in as yellow, orange, etc  --->
					<tr>
						<td align="right" valign="top" >
							<div>
								<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="300" height="250" align="centre" id="vyoo-1335541300237"><param name="allowScriptAccess" value="always" /><param name="allowFullScreen" value="true" /><param name="movie" value="http://78.136.57.208/vyoo/flashpublisher/skins/vyoo.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#FFFFFF" /><param name="flashvars" value="&skinid=592&playlistId=2164&volume=0&paused_opt=play" /><embed name="vyoo-1335541300237" flashvars="&skinid=592&playlistId=2164&volume=0&paused_opt=play" src="http://78.136.57.208/vyoo/flashpublisher/skins/vyoo.swf" width="300" height="250" align="centre" quality="high" bgcolor="#FFFFFF" allowscriptaccess="always" allowFullScreen="true" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></object>
							</div>
						</td>
					</tr>
					<tr>
						<td height="10">&nbsp;</td>
					</tr>
				
				</cfif>
				
				----------  Alfredo's TV   
				<cfif ListFind("White",request.SecurityLevel) >  
					<tr>
						<td align="right" valign="top" >
							<script src="http://www.google.com/jsapi"></script>
							<script src="http://ajax.googleapis.com/ajax/libs/swfobject/2.1/swfobject.js"></script>
							<div id="ytapiplayer">You need Flash player 8+ and JavaScript enabled to view this video.</div>
							<script type="text/javascript">
								google.load("swfobject", "2.1");
								function onYouTubePlayerReady(playerId) {
									ytplayer = document.getElementById("myytplayer");
									ytplayer.playVideo();
									ytplayer.loadPlaylist({'listType': 'playlist', 'list': 'PLD5FF9940D7CAA736','index': '0','startSeconds': '0','suggestedQuality': 'default'});
									ytplayer.mute();
								}
								var params = { allowScriptAccess: "always" };
								var atts = { id: "myytplayer" };
								swfobject.embedSWF("http://www.youtube.com/v/H_OAJ-Ai0Zo?enablejsapi=1&playerapiid=ytplayer&allowFullScreen=false&version=3",
								"ytapiplayer", "300", "168.75", "8", null, null, params, atts);
							</script>						
						</td>
					</tr>
					--->
				<cfif ListFind("White",request.SecurityLevel) >  
					<tr>
						<td align="right" valign="top" >
							<cfif DefaultYouthLeague IS 0> <!--- adult --->
									<cfif TimeFormat(Now(),'s') GE 20>
										<cfinclude template="adverts/inclVIDEOperformgroup300x360.cfm">
									<cfelse>
										<cfinclude template="adverts/inclAdult300x250.cfm">
									</cfif>
							<cfelse>
									<cfif TimeFormat(Now(),'s') GE 20> <!--- youth --->
										<cfinclude template="adverts/inclVIDEOperformgroup300x360.cfm">
									<cfelse>
										<cfinclude template="adverts/inclYouth300x250.cfm">
									</cfif>
							</cfif>
						</td>
					</tr>
				
					<tr>
						<td align="right" valign="top" >
							<!--- Alfredo's ISSUU magazine  --->
							<div><object style="width:300px;height:194px" ><param name="movie" value="http://static.issuu.com/webembed/viewers/style1/v1/IssuuViewer.swf?mode=embed&amp;layout=http%3A%2F%2Fskin.issuu.com%2Fv%2Flight%2Flayout.xml&amp;showFlipBtn=true&amp;autoFlip=true&amp;autoFlipTime=6000&amp;documentId=130419145523-0dfa99d8ebd944bda5f13b6b014da17e&amp;docName=mfr_magazine_07&amp;username=footballrevolution&amp;loadingInfoText=MITOO%20FOOTBALL%20REVOLUTION%2007&amp;et=1366626636785&amp;er=5" /><param name="allowfullscreen" value="true"/><param name="menu" value="false"/><param name="allowscriptaccess" value="always"/><embed src="http://static.issuu.com/webembed/viewers/style1/v1/IssuuViewer.swf" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" menu="false" style="width:300px;height:194px" flashvars="mode=embed&amp;layout=http%3A%2F%2Fskin.issuu.com%2Fv%2Flight%2Flayout.xml&amp;showFlipBtn=true&amp;autoFlip=true&amp;autoFlipTime=6000&amp;documentId=130419145523-0dfa99d8ebd944bda5f13b6b014da17e&amp;docName=mfr_magazine_07&amp;username=footballrevolution&amp;loadingInfoText=MITOO%20FOOTBALL%20REVOLUTION%2007&amp;et=1366626636785&amp;er=5" /></object></div>
						</td>
					</tr>
					<!---
						<br><cfoutput><a href="Noticeboard.cfm?countieslist=#countieslist#" target="Noticeboard"><img src="need_a_player.jpg" border="0"></a></cfoutput>
					--->
				</cfif>
				<cfif ListFind("White",request.SecurityLevel) >  
					
<!---
			*************************************************
			* Right Hand Side  -         MPU  300 x 250     *
			*************************************************
 --->
					<tr>
						<td>
						<!---
							<cfif DefaultYouthLeague IS 0> <!--- Adult League --->
								<iframe id='a1a1766b' name='a1a1766b' src='http://d1.openx.org/afr.php?zoneid=124271&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' frameborder='0' scrolling='no' width='300' height='250' allowtransparency='true'><a href='http://d1.openx.org/ck.php?n=a60279a1&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://d1.openx.org/avw.php?zoneid=124271&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a60279a1&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a></iframe>
							<cfelse> <!--- Youth League --->
								<iframe id='a1a1766b' name='a1a1766b' src='http://d1.openx.org/afr.php?zoneid=124271&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' frameborder='0' scrolling='no' width='300' height='250' allowtransparency='true'><a href='http://d1.openx.org/ck.php?n=a60279a1&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://d1.openx.org/avw.php?zoneid=124271&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a60279a1&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a></iframe>
							</cfif>
						--->
						</td>
					</tr>

				</cfif>
				
			</table>
		</td>
	</tr>
</table>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
