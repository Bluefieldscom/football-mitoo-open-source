<cfparam name="county" default="LondonMiddx">
<cfset CopyrightYear = "2010">	   

<html>
<head>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<!---
<style type="text/css">
<!--
.table
{ border-collapse: collapse;
border-width: 1px;
background-color: #D8FEF5;
border-color: #6699cc;
}
//-->
</style>
--->
<title>football.mitoo in <cfoutput>#County#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<!---
<body style="text-align:center;">
--->
<cfsilent>

<cfset request.SecurityLevel = "White">

<cflock scope="session" timeout="10" type="exclusive">
	<!--- New League, new password needed --->
	<cfset session.SecurityLevel = request.SecurityLevel >
	<!--- New League, always start off fresh --->
	<!--- New County, always start off fresh --->
	<cfset session.County = "#County#">
	<!--- Reset session variables for Club's fmTeamID --->
	<cfset session.fmTeamID = 0>
	<cfset request.County = session.County >
</cflock>

<cfinclude template="queries\qry_QGetLeagues.cfm">

<cfinclude template="queries\qry_QGetCountyName.cfm">	

</cfsilent>
<!---
		***************************************************************
		* football.mitoo logo and Leaderboard (728 x 90 pixel)        *
		***************************************************************
--->
<table width="100%" border="0"  align="center" cellpadding="0" cellspacing="0" >
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<cfoutput>
						<cfset ToolTipText = "Click on logo to go back to the map" >									
						<td align="center" valign="middle"><a href="NewMap1.htm" onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#ToolTipText#')"><img src="mitoo_logo1.png" alt="Go back to the map" border="0" ></a></td>
						<!--- was  src="fmsmall.gif" alt="Go back to #request.County#" width="140" height="57" border=0 --->
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
				<!--- OpenX iFrame Tag v2.6.2  leaderboard non-adult --->
				<iframe id='ace17ed8' name='ace17ed8' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?refresh=0&amp;n=ace17ed8&amp;zoneid=2&amp;target=_blank&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' framespacing='0' frameborder='no' scrolling='no' width='728' height='90'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=afef6c4c&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=2&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=afef6c4c&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a>
				</iframe>
				<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
			</div>
		</td>
	</tr>
<!---
		***********
		* spacer  *
		***********
--->
	
	<tr><td height="5"><img src="trans.gif" height="1" width="1" /></td></tr>
</table>

<!---
							****************
							* County Name  *
							****************
 --->
<table width="100%"  class="mainMenu">
	<tr>
		<td align="left" ><span class="pix18boldwhite"><cfoutput>#QGetCountyName.CountyName#</cfoutput></span></td>
	</tr>
</table>

<!---
							****************************************
							* Number of leagues across the screen  *
							*****************************************
 --->
<cfset no_of_leagues_across = 6 >
<table width="100%" >
	<tr>
		<td valign="top" >
<!---
	****************************************
	* Left Hand Side                      *
	****************************************
 --->
			<table border="0" cellpadding="0" cellspacing="0" bgcolor="white">
				<tr>
					<td>
						<table border="0" cellspacing="2" cellpadding="2"  bgcolor="white">
							 <tr valign="top" bgcolor="white">
								<cfset LeagueCount=0>
								<cfoutput query="QGetLeagues" group="NameSort">
									<!--- LeagueBrand: 0=Normal,1=NationalLeagueSystem,2=WomensFootballPyramid, 4=FootballAssociation,5=RefereesAssociation --->
									<td>
										<table class="leagueCounty">
											<!--- LeagueBrand: 0=Normal,1=NationalLeagueSystem,2=WomensFootballPyramid, 4=FootballAssociation,5=RefereesAssociation --->
											<CFSWITCH expression="#QGetLeagues.LeagueBrand#">
												<CFCASE VALUE="0">
													<cfset ThisClass = "bg_highlight0"> <!--- Normal --->
												</CFCASE>
												<CFCASE VALUE="1">
													<cfset ThisClass = "bg_yellow"> <!--- National League System --->
												</CFCASE>
												<CFCASE VALUE="2">
													<cfset ThisClass = "bg_lightgreen"> <!--- Womens Football Pyramid --->
												</CFCASE>
												<CFCASE VALUE="3">
													<cfset ThisClass = "bg_highlight0"> <!--- Normal --->
												</CFCASE>
												<CFCASE VALUE="4">
													<cfset ThisClass = "bg_highlight"> <!--- Football Association --->
												</CFCASE>
												<CFCASE VALUE="5">
													<cfset ThisClass = "bg_highlight2"> <!--- Referees Association --->
												</CFCASE>
											</CFSWITCH>
											<cfset LeagueCount = LeagueCount + 1>								
											<tr>
												<td valign="top"><img class="#ThisClass#" src="trans.gif" width="100%" height="1" border="0" /></td>
											</tr>
											<tr>
												<td width="120"  height="50" align="center" valign="middle" ><span class="pix10"><strong>#QGetLeagues.NameSort#</strong></span></td>
											</tr>
											<tr>
												<td valign="top"><img class="#ThisClass#" src="trans.gif" width="100%" height="1" border="0" /></td>
											</tr>
											<tr>
												<td align="center" valign="top">							
													<select style="font-family:#font_face#; font-size:10px;" onchange="location=this.options[this.selectedIndex].value;">
													<option value="">Select Season</option>
													<cfoutput><option value="News.cfm?LeagueCode=#UCase(QGetLeagues.DefaultLeagueCode)#">#Replace(QGetLeagues.SeasonName, 'Season', '', 'ALL')#</option></cfoutput>
													</select>
												</td>
											</tr>
										</table>
									</td>
									<cfif LeagueCount Mod no_of_leagues_across IS 0 >
										<tr valign="top" bgcolor="white">
									<cfelse>
									</tr></cfif>
								</cfoutput>
									
						</table>
					</td>
				</tr>
			</table>
		</td>
<!---
	****************************************
	* Right Hand Side                      *
	****************************************
 --->
		 
		<td align="right" valign="top">
			<table border="0" cellpadding="0" cellspacing="0"  bgcolor="white">
<!---
			****************************************
			* Right Hand Side  - MPU               *
			****************************************
 --->
				<tr>
					<td align="right">
						<table  border="0" cellspacing="0" cellpadding="0" >
							<tr>
								<td>
									<div id="right_mru" style="height:250px; width:300px; border:0px;">
										<!--/* OpenX iFrame Tag v2.6.2 */-->
										<iframe id='af6880bf' name='af6880bf' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?refresh=0&amp;n=af6880bf&amp;zoneid=1&amp;target=_blank&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' framespacing='0' frameborder='no' scrolling='no' width='300' height='250'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=a9ab5791&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=1&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a9ab5791&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a>
										</iframe>
										<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div><img src="trans.gif" height="10" width="1" /></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
<!---
			****************************************
			* Right Hand Side  - Google Ad         *
			****************************************
 --->
				<tr>
					<td align="right">
						<table  border="0" cellspacing="0" cellpadding="0" bgcolor="white">
							<tr>
								<td>
									<div id="small_ad_right" align="center" style="height:90px; width:300px; border:0px">
										<!--/* OpenX iFrame Tag v2.6.2 */-->
										<iframe id='a1e26594' name='a1e26594' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?refresh=0&amp;n=a1e26594&amp;zoneid=3&amp;target=_top&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' framespacing='0' frameborder='no' scrolling='no' width='234' height='60'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=a0ad2ef2&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_top'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=3&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a0ad2ef2&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a>
										</iframe>
										<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div><img src="trans.gif" height="10" width="1" /></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>


				<tr>
					<!--- NEED A PLAYER? A NEW MANAGER? A NEW CLUB? ADVERTISE HERE �1 PER WEEK --->
					<td align="right">
						<cfoutput><a href="Noticeboard.cfm?countieslist=#request.County#" target="Noticeboard"><img src="need_a_player.jpg" border="0"></a></cfoutput>
					</td>
				</tr>

				
			</table>
			
		</td>
	</tr>
</table>
<table>
<!---
							***********************************
							* 486 x 60 advert at the bottom   *
							***********************************
 --->
	<tr>
		<td>
			<div><img src="trans.gif" height="10" width="1" /></div>
		</td>
	</tr>
 
	<tr>
		<td align="center">
			<div id="top_ad" align="center" style="width:468px; height:60px; border:0px;">
				<!--/* OpenX iFrame Tag v2.6.2 */-->
				<iframe id='a568e654' name='a568e654' src='http://adserver.goalrun.com/openx/www/delivery/afr.php?refresh=0&amp;n=a568e654&amp;zoneid=4&amp;target=_blank&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;ct0=INSERT_CLICKURL_HERE' framespacing='0' frameborder='no' scrolling='no' width='468' height='60'><a href='http://adserver.goalrun.com/openx/www/delivery/ck.php?n=a294150a&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://adserver.goalrun.com/openx/www/delivery/avw.php?zoneid=4&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a294150a&amp;ct0=INSERT_CLICKURL_HERE' border='0' alt='' /></a>
				</iframe>
				<script type='text/javascript' src='http://adserver.goalrun.com/openx/www/delivery/ag.php'></script>
			</div>
		</td>
	</tr>	
	<tr>
		<td>
			<div><img src="trans.gif" height="10" width="1" /></div>
		</td>
	</tr>
<!---
							*******************************************
							*  brand blue grey border at the bottom   *
							*******************************************
 --->
	<tr>
		<td bgcolor="#6A7289">
			<div><img src="trans.gif" height="1" width="1" /></div>
		</td>
	</tr>
	<tr>
		<td>
			<div><img src="trans.gif" height="2" width="1" /></div>
		</td>
	</tr>
	<tr>
		<td>
			<table border="0" cellspacing="2" cellpadding="2" >
			<tr>
				<td><img src="mitoo_logo_2.png" alt="football.mitoo" border="0" align="absmiddle"></td>
				<td>
					<span class="pix10"><em>football.mitoo</em> is a free, internet based, football league management system. 
						Very popular and now in its 11th season, it spans all 
						levels up to the Ryman Isthmian. All leagues are welcome and can choose to use all or just a few of its many 
						features. Reports, tables and grids are automatically produced from the data that you 
						enter.<br>For more information please email 
						<a href="mailto:INSERT_EMAIL_HERE?subject=football.mitoo information"><strong>INSERT_EMAIL_HERE</strong></a>
					</span>
				</td>
			</tr>
					
					</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table  border="0" cellspacing="0" cellpadding="0" bgcolor="white">
				<tr>
					<td><span class="pix10">Copyright &copy; Goalrun Ltd 2000-<cfoutput>#CopyrightYear#</cfoutput></span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>

