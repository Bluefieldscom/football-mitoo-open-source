<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset DelayPeriod = 1>
<cfset BoundaryDate = CreateODBCDate(NOW()- DelayPeriod )>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!--- Ignore fixtures with HomeGoals IS NULL AND AwayGoals IS NULL, OR FixtureNotes LIKE '%TEAM SHEET MISSING%' --->
<cfinclude template="queries/qry_QResultHA.cfm">
<cfset ResultHAList = ValueList(QResultHA.ID)>
<cfset ResultHACount = QResultHA.RecordCount>
<cfif ResultHACount IS 0>
	<cfset ResultHAList = ListAppend(ResultHAList, 0)>
</cfif>
<cfinclude template="queries/qry_QHomeAppearances.cfm">
<cfset HomeFIDList = ValueList(QHomeAppearances.FID)>
<cfset HomeFIDCount = QHomeAppearances.RecordCount>
<cfif HomeFIDCount IS 0>
	<cfset HomeFIDList = ListAppend(HomeFIDList, 0)>
</cfif>
<cfinclude template="queries/qry_QAwayAppearances.cfm">
<cfset AwayFIDList = ValueList(QAwayAppearances.FID)>
<cfset AwayFIDCount = QAwayAppearances.RecordCount>
<cfif AwayFIDCount IS 0>
	<cfset AwayFIDList = ListAppend(AwayFIDList, 0)>
</cfif>

<cfset IgnoreExternalCompetitions = "No">

<cfif StructKeyExists(url, "External")>
	<cfif url.External IS "N">
		<cfset IgnoreExternalCompetitions = "Yes">
	</cfif>
</cfif>

<cfif IgnoreExternalCompetitions IS "Yes">
		<cfinclude template="queries/qry_QMissingAppearancesX.cfm">
<cfelse>
		<cfinclude template="queries/qry_QMissingAppearances.cfm">
</cfif>

<cfif QMissingAppearances.RecordCount GT "0">
	<cfoutput>
		<span class="pix13bold"><BR><BR>Before #DateFormat( BoundaryDate , "DDDD, DD MMMM YYYY")#,
			<cfif QMissingAppearances.RecordCount GT "1">
				there are #QMissingAppearances.RecordCount# matches with </span><span class="pix13boldred">missing appearances.<br></span>
			<cfelse>
				there's only one match with </span><span class="pix13boldred">missing appearances!<br></span>
			</cfif>
		<span class="pix13bold"><br>Click on the <img src="WhiteTS.gif" border="0"> or <img src="lightgreen.jpg" border="0"> or <img src="pink.jpg" border="0"> icons below to update the team sheet.<br><br></span>
		
	</cfoutput>
	<table width="100%" border="0" cellpadding="2" cellspacing="2">
		<cfoutput query="QMissingAppearances" group="FixtureDate">
			<tr><td height="20" colspan="6" align="left" valign="bottom"><hr><a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(FixtureDate,'DD-MMM-YY')#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix13boldblack">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></a></td></tr>
			<cfoutput group="DivName">
				<tr>
				<td height="20" colspan="6" align="left" valign="bottom"><span class="pix13bold">#DivName#</span></td>
				</tr>
				<cfoutput>
				<cfif MType IS "Home">
					<cfinclude template="queries/qry_QAnyHomeAppearances.cfm">
					<cfif QAnyHomeAppearances.HCount IS 0><cfset HomeTeamSheetEmpty = 1><cfelse><cfset HomeTeamSheetEmpty = 0></cfif>
					<tr>
						<td align="left">
						<span class="pix13boldred">#HomeTeam# #HomeOrdinal#</span>
						<cfif HomeTeamSheetOK IS 0>
						<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#">
							<cfif HomeTeamSheetEmpty IS 1><img src="WhiteTS.gif" border="0"><cfelse><img src="lightgreen.jpg" border="0"></cfif>
						</a>
						<cfelse>
						<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="pink.jpg" border=0"></a>
						</cfif>
						<span class="pix13">#HomeGoals# v #AwayGoals# #AwayTeam# #AwayOrdinal#
							<cfif TRIM(#RoundName#)IS NOT "" >  [ #RoundName# ] </cfif>
						</span><span class="pix10">#RefereeName#</span>
						</td>
					</tr>
				<cfelseif MType IS "Away">
					<cfinclude template="queries/qry_QAnyAwayAppearances.cfm">
					<cfif QAnyAwayAppearances.ACount IS 0><cfset AwayTeamSheetEmpty = 1><cfelse><cfset AwayTeamSheetEmpty = 0></cfif>
					<tr>
						<td align="left"><span class="pix13">#HomeTeam# #HomeOrdinal#</span>
						<span class="pix13">#HomeGoals# v #AwayGoals#</span>
						<cfif AwayTeamSheetOK IS 0>
							<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#">
							<cfif AwayTeamSheetEmpty IS 1><img src="WhiteTS.gif" border="0"><cfelse><img src="lightgreen.jpg" border="0"></cfif>
							</a>
						<cfelse>
							<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="pink.jpg" border=0"></a>
						</cfif>
						<span class="pix13boldred">#AwayTeam# #AwayOrdinal#</span><cfif TRIM(#RoundName#)IS NOT "" ><span class="pix13"> [ #RoundName# ]</span></cfif>
						<span class="pix10">#RefereeName#</span>
						</td>
					</tr>
				<cfelseif MType IS "Both">
					<cfinclude template="queries/qry_QAnyHomeAppearances.cfm">
					<cfif QAnyHomeAppearances.HCount IS 0><cfset HomeTeamSheetEmpty = 1><cfelse><cfset HomeTeamSheetEmpty = 0></cfif>
					<cfinclude template="queries/qry_QAnyAwayAppearances.cfm">
					<cfif QAnyAwayAppearances.ACount IS 0><cfset AwayTeamSheetEmpty = 1><cfelse><cfset AwayTeamSheetEmpty = 0></cfif>
					<tr>
						<td align="left"><span class="pix13boldred">#HomeTeam# #HomeOrdinal#</span>
						<cfif HomeTeamSheetOK IS 0>
						<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><cfif HomeTeamSheetEmpty IS 1><img src="WhiteTS.gif" border="0"><cfelse><img src="lightgreen.jpg" border="0"></cfif></a>
						<cfelse>
						<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H&DivisionID=#DivisionID#"><img src="pink.jpg" border=0"></a>
						</cfif> 
						<span class="pix13">#HomeGoals# v #AwayGoals#</span>
						<cfif AwayTeamSheetOK IS 0>
							<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><cfif AwayTeamSheetEmpty IS 1><img src="WhiteTS.gif" border="0"><cfelse><img src="lightgreen.jpg" border="0"></cfif></a>
						<cfelse>
							<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A&DivisionID=#DivisionID#"><img src="pink.jpg" border=0"></a>
						</cfif>
						<span class="pix13boldred">#AwayTeam# #AwayOrdinal#</span><cfif TRIM(#RoundName#)IS NOT "" ><span class="pix13"> [ #RoundName# ]</span></cfif>
						<span class="pix10">#RefereeName#</span>
						</td>
					</tr>
				<cfelse>
					ERROR 2315 MissingAppearances.cfm
					<cfabort>
				</cfif>
				</cfoutput>
			</cfoutput>
		</cfoutput>
	</table>

<cfelse>
		<span class="pix13bold"><BR><BR>Before <cfoutput>#DateFormat( BoundaryDate , "DDDD, DD MMMM YYYY")#, there are no matches with missing appearances.<br><br> Excellent!</cfoutput></span>
</cfif>	
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
