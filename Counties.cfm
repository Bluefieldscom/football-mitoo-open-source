<cfparam name="county" default="LondonMiddx">
<html>
<head>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>football.mitoo in <cfoutput>#County#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">




<!---<cfinclude template="adverts/inclCounties001.cfm">--->
<script type="text/javascript">var p="http",d="static";if(document.location.protocol=="https:"){p+="s";d="engine";}var z=document.createElement("script");z.type="text/javascript";z.async=true;z.src=p+"://"+d+".adzerk.net/ados.js";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(z,s);</script>
<script type="text/javascript">
var ados = ados || {};
ados.run = ados.run || [];
ados.run.push(function() {
/* load placement for account: Mitoo, site: football.mitoo, size: 234x60 - Half Banner, zone: 234x60 Zone1*/
ados_add_placement(4936, 21743, "azk54565", 12).setZone(17372);
/* load placement for account: Mitoo, site: football.mitoo, size: 234x60 - Half Banner, zone: 234x60 Zone2*/
ados_add_placement(4936, 21743, "azk55194", 12).setZone(17379);
ados_load();
});</script>


</head>
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
		***************************************
		* football.mitoo logo and Leaderboard *
		***************************************
--->
<table width="100%" border="0"  align="center" cellpadding="0" cellspacing="0" >
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<cfoutput>
						<cfset ToolTipText = "Click on logo to go back to the map" >									
						<td align="center" valign="middle" ><a href="fmMap.cfm" onMouseOver="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=50;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=400;return escape('#ToolTipText#')"><img src="mitoo_logo1.png" alt="Go back to the map" border="0" ></a></td>
						<!--- was  src="fmsmall.gif" alt="Go back to #request.County#" width="140" height="57" border=0 --->
					</cfoutput>
				</tr>
			</table>
		</td>
		<!---
				****************************************
				* Leaderboard  Youth (728 x 90 pixel)  *
				****************************************
		--->
		<td align="right">
				<cfinclude template="adverts/incl728x90TOP.cfm">
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
				<!--- LeagueBrand: 0=Normal,1=NationalLeagueSystem,2=WomensFootballPyramid,4=FootballAssociation,5=RefereesAssociation,6=Girls --->
									<td>
										<table class="leagueCounty">
											<CFSWITCH expression="#QGetLeagues.LeagueBrand#">
												<CFCASE VALUE="0">
													<cfset ThisClass = "white"> <!--- Normal --->
												</CFCASE>
												<CFCASE VALUE="1">
													<cfset ThisClass = "bg_yellow"> <!--- National League System --->
												</CFCASE>
												<CFCASE VALUE="2">
													<cfset ThisClass = "bg_lightgreen"> <!--- Womens Football Pyramid --->
												</CFCASE>
												<CFCASE VALUE="3">
													<cfset ThisClass = "white"> <!--- Normal --->
												</CFCASE>
												<CFCASE VALUE="4">
													<cfset ThisClass = "bg_highlight"> <!--- Football Association --->
												</CFCASE>
												<CFCASE VALUE="5">
													<cfset ThisClass = "bg_highlight2"> <!--- Referees Association --->
												</CFCASE>
												<CFCASE VALUE="6">
													<cfset ThisClass = "bg_plum"> <!--- Girls --->
												</CFCASE>
												
											</CFSWITCH>
											<cfset LeagueCount = LeagueCount + 1>								
											<tr>
												<td valign="top"><img class="#ThisClass#" src="trans.gif" width="100%" height="4" border="0" /></td>
											</tr>
											<tr>
												<td width="120"  height="50" align="center" valign="middle" ><span class="pix10"><strong>#QGetLeagues.NameSort#</strong></span></td>
											</tr>
											<tr>
												<td valign="top"><img class="#ThisClass#" src="trans.gif" width="100%" height="4" border="0" /></td>
											</tr>
											<tr>
												<td align="center" valign="top">							
													<select  style="font-family:#font_face#; font-size:10px;" onchange="location=this.options[this.selectedIndex].value;">
													<option value="">Select Season</option>
													<option value="http://www.mitoo.co/download-app">Download app</option>
													<cfoutput><option value="News.cfm?LeagueCode=#UCase(QGetLeagues.DefaultLeagueCode)#">#Replace(QGetLeagues.SeasonName, 'Season', '', 'ALL')#</option></cfoutput>
													</select>
												</td>
											</tr>
										</table>
									</td>
									<cfif LeagueCount Mod no_of_leagues_across IS 0 >
										<tr valign="top" bgcolor="white">
									</cfif>
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
			******************************************
			* Right Hand Side - MPU YOUTH 300 x 250  *
			******************************************
 --->
				<tr>
					<td align="right">
						<table  border="0" cellspacing="0" cellpadding="0" >
							<tr>
								<td>
									<div id="right_mru" style="height:250px; width:300px; border:0px;">
										<cfinclude template="adverts/inclYouth300x250.cfm">
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
			* Right Hand Side  - 234x60 advert     *
			****************************************
 --->
				<tr>
					<td align="right">
					
						<table  border="0" cellspacing="0" cellpadding="0" bgcolor="white">
							<tr>
								<td align="right">
									<!---
									<div id="small_ad_right" align="center" style="height:90px; width:300px; border:0px">
										<cfinclude template="adverts/inclCountiesOpenX234x60.cfm">      
									</div>   
									
									<cfinclude template="adverts/inclCountiesAdzerk234x60.cfm"> 
									--->
									<cfif TimeFormat(Now(),'SS') MOD 2><div id="azk54565"></div><cfelse><div id="azk55194"></div></cfif>
									
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
					<!--- NEED A PLAYER? A NEW MANAGER? A NEW CLUB? ADVERTISE HERE 1 PER WEEK --->
					<td align="right">
						<cfoutput><a href="Noticeboard.cfm?countieslist=#request.County#&LeagueCode=MDX2012" target="Noticeboard"><img src="need_a_player.jpg" border="0"></a></cfoutput>
					</td>
				</tr>
			</table>
			
		</td>
	</tr>
</table>
<table>
	<tr>
		<td>
			<div><img src="trans.gif" height="10" width="1" /></div>
		</td>
	</tr>
	<tr>
		<td align="center">
			<!---
										****************************************
										* 468x 60   advert at the bottom       *
										****************************************
			 
			<div id="top_ad" align="center" style="width:468px; height:60px; border:0px;">
				<cfinclude template="adverts/inclBanner468x60.cfm">
			</div>
			--->
			<cfinclude template="adverts/incl728x90BOTTOM.cfm">
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
							Very popular and now in its 15th season, it spans all 
							levels. All leagues are welcome and can choose to use all or just a few of its many 
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
			<table border="0" cellspacing="0" cellpadding="0" bgcolor="white">
				<tr>
					<td><span class="pix10">Copyright &copy; Bluefields Inc. 2000-<cfoutput>#CopyrightYear#</cfoutput></span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>

