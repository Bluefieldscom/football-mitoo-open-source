
<!--- <cfcache action="optimal" port="80" timespan = "#CreateTimeSpan(0,0,10,0)#"> --->

<cflock scope="session" timeout="10" type="exclusive">
	<!--- New League, new password needed --->
	<CFSET session.LoggedIn = "No">
	<CFSET session.LeagueReports = "No">
	<!--- New League, always start off fresh --->
	<CFSET session.Hdr1 = "">
	<!--- New County, always start off fresh --->
	<CFPARAM name="County" default="LondonMiddx">
	<CFSET session.County = "#County#">
	<!--- Reset session variables for Club's fmTeamID & LeagueCode --->
	<CFSET session.fmTeamID = 0>
	<CFSET session.LeagueCode = "">
</cflock>

<cfquery name="QGetLeagues" datasource="ZMAST" cachedwithin="#cw#">	
SELECT
		NameSort,LeagueName,DefaultLeagueCode,BadgeJpeg,SeasonName
	FROM
		LeagueInfo
	WHERE
		CountiesList LIKE '%#County#%'
	ORDER BY
		NameSort, SeasonName DESC
</cfquery>
	
<cfquery name="QGetCountyName" datasource="ZMAST4"  cachedwithin="#cw#">
	SELECT
		CountyName
	FROM
		CountyInfo
	WHERE
		CountyCode = '#session.County#'
</cfquery>

<table width="100%" border="8"  >
	<tr >
		<td align="center" >
		
			<table>
				<tr>


				
					<td width="493" height="201" align="center">
					<cfoutput>
					<font face=#Font_Face# size="-2" >
					Please <A HREF="Index.cfm" ADDTOKEN="NO">click here</A>
					or click on the <em>football.mitoo</em> logo
					to see the map
					</font>
					<BR><BR>
					<font face=#Font_Face# size="+1" >
						<strong>#QGetCountyName.CountyName#</strong>
					</font>
					<BR><BR>
						<A HREF="Index.cfm" ADDTOKEN="NO"><img src="fmlogo.jpg" alt="Go back to the map" border=0></A>
						<CFSET CopyrightText = "Copyright &copy; Mitoo Interactive Ltd 2000-2003" >
						<BR><font face=#Font_Face# size="-2" >#CopyrightText#</font>
					</cfoutput>
					</td>
					
				</tr>
			</table>
		
		</td>
	</tr>
</table>

<cfflush>


<table width="100%" border="1" cellspacing="2" cellpadding="2" >
	 <tr align="CENTER" valign="TOP">
		<CFSET LeagueCount = 0>
		<cfoutput query="QGetLeagues" group="NameSort">
		
			<cfif Find("Football Association",#QGetLeagues.LeagueName#) AND NOT Find("League",#QGetLeagues.LeagueName#)>
			 	<CFSET ItsAnFA="Yes">
			<cfelse>
			 	<CFSET ItsAnFA="No">
			</cfif>
			
			<cfif #Find("Referees' Association",#QGetLeagues.LeagueName#)#>
			 	<CFSET ItsAnRA="Yes">
			<cfelse>
			 	<CFSET ItsAnRA="No">
			</cfif>
			
			
			<td bgcolor=#bg_color#>
				<table width="110" border="0" cellspacing="0" cellpadding="0" align="CENTER" >
					<tr>
						<CFSET LeagueCount = LeagueCount + 1>
						<td height="40" align="CENTER" valign="MIDDLE" <cfif ItsAnFA>bgcolor=#BG_Highlight# <cfelseif ItsAnRA>bgcolor=#BG_Highlight2#<cfelse></cfif>>
							<A HREF="News.cfm?LeagueCode=#QGetLeagues.DefaultLeagueCode#">
								<font face=#Font_Face# size="-2" >
									<B>#QGetLeagues.LeagueName#</b>
								</font>
							</A>
							
						</td>
					</tr>
					<tr>
						<td align="CENTER"  <cfif ItsAnFA>bgcolor=#BG_Highlight# <cfelseif ItsAnRA>bgcolor=#BG_Highlight2#<cfelse></cfif>>
														
							<CFIF FileExists("#request.xpath#LeagueBadges/#QGetLeagues.BadgeJpeg#.jpg")>
								<A HREF="News.cfm?LeagueCode=#UCase(QGetLeagues.DefaultLeagueCode)#"><IMG border="0" src="LeagueBadges/#QGetLeagues.BadgeJpeg#.jpg" ></A>
							</cfif>
						</td>
					</tr>
					
				<cfoutput>
						<tr>
							<td align="CENTER" valign="MIDDLE"   <cfif ItsAnFA>bgcolor=#BG_Highlight# <cfelseif ItsAnRA>bgcolor=#BG_Highlight2#<cfelse></cfif>>
								<A HREF="News.cfm?LeagueCode=#UCase(QGetLeagues.DefaultLeagueCode)#"><font face=#Font_Face# size="-2" ><B>#QGetLeagues.SeasonName#</b></font></A>
							</td>
						</tr>
				</cfoutput>
				</table>
			</td>
		
			<CFIF LeagueCount Mod 6 IS 0 >
				</tr>
				<tr align="CENTER" valign="TOP">
			</cfif>
			
		</cfoutput>
		
</table>

