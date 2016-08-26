<!--- this "include" is to be found only in News.cfm.
It checks for a corrupted appearances table.
Occasionally, probably when the system is running slowly, two sets of updates get through and players appearance records are
 ADDED TWICE FOR THE SAME FIXTURE.
 This needs to be undone before carrying on any further work on a league. 
I am not happy with this.
It is run every time News.cfm is requested by someone who is fully logged in --->

<CFIF NOT IsDefined("URL.LeagueCode")>
	LeagueCode parameter missing!
	<CFABORT>
</CFIF>	
<cfinclude template="queries/qry_QDuplicateAppearances.cfm">

<!--- check for an error situation, otherwise that's it.....carry on....... --->

<CFIF QDuplicateAppearances.RecordCount GT 0>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER">
		<tr>
			<td  align="CENTER">
				<span class="pix24boldred">TEAM SHEET ERRORS<BR></span>
				<span class="pix18boldred">Please correct immediately<BR></span>
				<span class="pix13boldred">		
					1. Print the team sheet as a reference<BR>
					2. Remove all the player appearances (untick them)<BR>
					3. Enter the team sheet again</span>
			</td>
		</tr>	
		<cfoutput query="QDuplicateAppearances" group="FixtureID">
			<cfinclude template="queries/qry_QFixtureDetails.cfm">
			<tr>
				<td>
					<span class="pix18bold">#DateFormat(QFixtureDetails.FixtureDate, "DDDD, DD MMMM YYYY")#</span>
				</td>
			</tr>
			<tr>
				<td>
						<CFSET HomeTeamName = "#QFixtureDetails.HomeTeam#">
						<CFIF QFixtureDetails.HomeOrdinal IS NOT "">
							<CFSET HomeTeamName = "#HomeTeamName# #QFixtureDetails.HomeOrdinal#">
						</cfif>
						<CFSET AwayTeamName = "#QFixtureDetails.AwayTeam#">
						<CFIF QFixtureDetails.AwayOrdinal IS NOT "">
							<CFSET AwayTeamName = "#AwayTeamName# #QFixtureDetails.AwayOrdinal#">
						</cfif>
						<CFIF HomeAway IS "H">
							<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#QDuplicateAppearances.FixtureID#&HA=H"><span class="pix13">#HomeTeamName#</span></a>
						<CFELSE>
							<span class="pix13">#HomeTeamName#</span>
						</CFIF>
							 <span class="pix13">v</span> 
						<CFIF HomeAway IS "A">
							<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#QDuplicateAppearances.FixtureID#&HA=A"><span class="pix13">#AwayTeamName#</span></a>
						<CFELSE>
							<span class="pix13">#AwayTeamName#</span>
						</CFIF>
						
						<span class="pix10boldnavy"><======== click on the underlined link</span>
				</td>
			</tr>
			<CFOUTPUT>
				<cfinclude template="queries/qry_QPlayerDetails.cfm">
				<tr>
					<td>
						<span class="pix10">#cnt# times on the team sheet: 
							<strong>#QPlayerDetails.Surname#</strong> #QPlayerDetails.Forename#
						</span>
					</td>
				</tr>
			</cfoutput>
	
		</cfoutput>
	</table>
	<CFABORT>
</cfif>