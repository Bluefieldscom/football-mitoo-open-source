<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset DelayPeriod = 1>
<cfset BoundaryDate = CreateODBCDate(NOW()- DelayPeriod )>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QHomeAwayH.cfm">
<cfset HomeAwayHList = ValueList(QHomeAwayH.FixtureID)>
<cfif QHomeAwayH.RecordCount IS 0 >
	<cfset HomeAwayHList = ListAppend(HomeAwayHList, 0)>
</cfif>
<cfinclude template="queries/qry_QHomeAwayA.cfm">
<cfset HomeAwayAList = ValueList(QHomeAwayA.FixtureID)>
<cfif QHomeAwayA.RecordCount IS 0 >
	<cfset HomeAwayAList = ListAppend(HomeAwayAList, 0)>
</cfif>
<!--- Ignore fixtures with HomeGoals IS NULL AND AwayGoals IS NULL, OR FixtureNotes LIKE '%TEAM SHEET MISSING%' --->
<cfinclude template="queries/qry_QResultHA.cfm">
<cfset ResultHAList = ValueList(QResultHA.ID)>
<cfset ResultHACount = QResultHA.RecordCount>
<cfif ResultHACount IS 0>
	<cfset ResultHAList = ListAppend(ResultHAList, 0)>
</cfif>

<!--- get a list of distinct Fixture IDs where the home score disagrees with sum of the individual home goals recorded in corresponding appearance records --->
<cfinclude template="queries/qry_QHomeGoalscorers.cfm">
<cfset HomeFIDList = ValueList(QHomeGoalscorers.FID)>
<cfset HomeFIDCount = QHomeGoalscorers.RecordCount>
<cfif HomeFIDCount IS 0>
	<cfset HomeFIDList = ListAppend(HomeFIDList, 0)>
</cfif>

<!--- get a list of distinct Fixture IDs where the home score is less than the sum of the individual home goals recorded in corresponding appearance records --->
<cfinclude template="queries/qry_QHomeGoalscorers2.cfm">
<cfset HomeCheatingFIDList = ValueList(QHomeGoalscorers2.FID)>
<cfset HomeCheatingFIDCount = QHomeGoalscorers2.RecordCount>
<cfif HomeCheatingFIDCount IS 0>
	<cfset HomeCheatingFIDList = ListAppend(HomeCheatingFIDList, 0)>
</cfif>

<cfinclude template="queries/qry_QNoHomeAppearance.cfm">
<cfset NoHomeAppearanceList = ValueList(QNoHomeAppearance.ID)>
<cfset NoHomeAppearanceCount = QNoHomeAppearance.RecordCount>
<cfif NoHomeAppearanceCount GT 0>
	<cfset HomeFIDList = ListAppend(HomeFIDList,  NoHomeAppearanceList)>
</cfif>

<!--- get a list of distinct Fixture IDs where the away score disagrees with sum of the individual away goals recorded in corresponding appearance records --->
<cfinclude template="queries/qry_QAwayGoalscorers.cfm">
<cfset AwayFIDList = ValueList(QAwayGoalscorers.FID)>
<cfset AwayFIDCount = QAwayGoalscorers.RecordCount>
<cfif AwayFIDCount IS 0>
	<cfset AwayFIDList = ListAppend(AwayFIDList, 0)>
</cfif>

<!--- get a list of distinct Fixture IDs where the away score is less than the sum of the individual away goals recorded in corresponding appearance records --->
<cfinclude template="queries/qry_QAwayGoalscorers2.cfm">
<cfset AwayCheatingFIDList = ValueList(QAwayGoalscorers2.FID)>
<cfset AwayCheatingFIDCount = QAwayGoalscorers2.RecordCount>
<cfif AwayCheatingFIDCount IS 0>
	<cfset AwayCheatingFIDList = ListAppend(AwayCheatingFIDList, 0)>
</cfif>

<cfinclude template="queries/qry_QNoAwayAppearance.cfm">
<cfset NoAwayAppearanceList = ValueList(QNoAwayAppearance.ID)>
<cfset NoAwayAppearanceCount = QNoAwayAppearance.RecordCount>
<cfif NoAwayAppearanceCount GT 0>
	<cfset AwayFIDList = ListAppend(AwayFIDList,  NoAwayAppearanceList)>
</cfif>

<cfset ExcludingExternalCompetitions = "No">
<cfif StructKeyExists(url, "ExcludeExternal")>
	<cfif url.ExcludeExternal IS "Yes">
		<cfset ExcludingExternalCompetitions = "Yes">
		<cfinclude template="queries/qry_QMissingGoalscorers2.cfm">
	<cfelse>
		<cfinclude template="queries/qry_QMissingGoalscorers.cfm">
	</cfif>
<cfelse>
	<cfinclude template="queries/qry_QMissingGoalscorers.cfm">
</cfif>

<cfif QMissingGoalscorers.RecordCount GT "0">
	<cfoutput>
		<span class="pix13bold">Before #DateFormat( BoundaryDate , "DDDD, DD MMMM YYYY")#,
		<cfif QMissingGoalscorers.RecordCount GT "1">
			there are #QMissingGoalscorers.RecordCount# matches with missing or too many goalscorers.
		<cfelse>
			there's only one match with missing or too many goalscorers!
		</cfif>
		</span>
		<cfif ExcludingExternalCompetitions IS "No">
			<span class="pix13boldrealblack">Click <a href="MissingGoalscorers.cfm?Leaguecode=#LeagueCode#&ExcludeExternal=Yes"><u>here</u></a> to exclude External Competitions.</span>
		<cfelse>
			<span class="pix13boldrealblack">Click <a href="MissingGoalscorers.cfm?Leaguecode=#LeagueCode#"><u>here</u></a> to include External Competitions.</span>
		</cfif>
	
	</cfoutput>
	<cfoutput query="QMissingGoalscorers" group="FixtureDate">
		<BR><HR><BR><span class="pix13bold">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#<BR></span>
		<cfoutput group="DivName">
			<span class="pix13bold">#DivName#<br></span>
			<cfoutput>
			<cfif MType IS "Home">
				<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H"><span class="pix13bold">#HomeTeam# #HomeOrdinal#</span></a>
				<span class="pix13">&nbsp;#HomeGoals# v #AwayGoals#&nbsp; #AwayTeam# #AwayOrdinal#</span>
					<cfif TRIM(#RoundName#)IS NOT "" >			<!--- e.g. [ Round 1 ] --->
						<span class="pix13">[ #RoundName# ]</span>
					</cfif>
					<cfif CompetitionType IS "External"><span class="pix13boldrealblack">External Competition</span></cfif>
					<cfif ListFind(HomeCheatingFIDList,FID) ><span class="pix13boldred">ERROR: Sum of Goals column exceeds actual home goals</span></cfif>
					<br>
			</cfif>
			<cfif MType IS "Away">
				<span class="pix13">#HomeTeam# #HomeOrdinal# &nbsp;#HomeGoals# v #AwayGoals#&nbsp;</span>
				<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A"><span class="pix13bold">#AwayTeam# #AwayOrdinal#</span></a>
					<cfif TRIM(#RoundName#)IS NOT "" >			<!--- e.g. [ Round 1 ] --->
						<span class="pix13">[ #RoundName# ]</span>
					</cfif>
					<cfif CompetitionType IS "External"><span class="pix13boldrealblack">External Competition</span></cfif>
					<cfif ListFind(AwayCheatingFIDList,FID) ><span class="pix13boldred">ERROR: Sum of Goals column exceeds actual away goals</span></cfif>
					
					<br>
			</cfif>
			<cfif MType IS "Both">
				
				<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H"><span class="pix13bold">#HomeTeam# #HomeOrdinal#</span></a>
					<span class="pix13">&nbsp;#HomeGoals# v #AwayGoals#&nbsp;</span>
				<a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A"><span class="pix13bold">#AwayTeam# #AwayOrdinal#</span></a>
					<cfif TRIM(#RoundName#)IS NOT "" >			<!--- e.g. [ Round 1 ] --->
						<span class="pix13">[ #RoundName# ]</span>
					</cfif>
					<cfif CompetitionType IS "External"><span class="pix13boldrealblack">External Competition</span></cfif>
					<cfif ListFind(HomeCheatingFIDList,FID) ><span class="pix13boldred">ERROR: Sum of Goals column exceeds actual home goals</span></cfif>
					<cfif ListFind(AwayCheatingFIDList,FID) ><span class="pix13boldred">ERROR: Sum of Goals column exceeds actual away goals</span></cfif>
					<br>
			</cfif>
			</cfoutput>
		</cfoutput>
	</cfoutput>		
<cfelse>
	<cfoutput>
		<span class="pix13bold"><BR><BR>Before #DateFormat( BoundaryDate , "DDDD, DD MMMM YYYY")#, there are no matches with missing or too many goalscorers.<br>
		<br> Excellent!</span>
	</cfoutput>
</cfif>	
