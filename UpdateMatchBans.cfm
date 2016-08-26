<!--- called by  RefreshleagueTable.cfm --->

<!--- this is basically the guts of the same process which occurs 
in LUList.cfm?Suspended=MB&TblName=Player&LeagueCode=xxxxx2010 
but without the display - it just updates the Match bans --->


<cfset Suspended = "MB"> <!--- Match bans --->
<cfinclude template="queries/qry_PlayerList_v2.cfm">
<cfoutput query="PlayerList" group="Surname"  >
	<cfoutput group="RegNo">
		<cfset UsedFixtureIDList = "" >
		<cfset OldestFixtureDate = '1900-01-01'>
		<cfoutput group="FirstDayOfRegistration">
		<cfif FirstDayOfSuspension IS NOT "">		
			<cfoutput>
				<cfset ThisSuspensionID = Playerlist.SI >
				<cfinclude template = "queries/qry_QMatchbanHeader.cfm">
					<cfif QMatchbanHeader.RecordCount GT 0  AND QMatchbanHeader.NumberOfMatches GT 0 >
						<cfinclude template="queries/qry_SatisfyFixtures.cfm">
						<cfset NCount = 0>
						<cfset YCount = 0>
						<cfset XCount = 0>
						<cfset MatchCount=1>
						<cfloop condition = "(MatchCount LE (NumberOfMatches+NCount)) AND ((NCount+YCount) LT NumberOfMatches+XCount)">
							<!--- get a fixture to satisfy this item --->
							<cfloop query="QSatisfyFixtures" startrow="#MatchCount#" endrow="#MatchCount#">
								<cfset STRING4 = "PlayerList.ID">
								<cfinclude template = "queries/qry_QAnyApps.cfm">
								<cfinclude template = "queries/qry_QAppID.cfm">
								
									<!--- 
									**********************************************************************************************
									**********************************************************************************************  
									**********************************************************************************************
									**********************************************************************************************
									1 
									a. Game must have been played to a conclusion with a proper scoreline (not Postponed or Void or Abandoned etc)
									b. Player must not already be suspended for this game
									c. games must count towards match based suspensions for their team - see constitution MatchBanFlag
									d. If a game was played to a conclusion with a proper scoreline but then later AWARDED because of, say, an ineligible player
									then the game WILL count. Such a game will have player appearances. An AWARDED game that was not played will not have player appearances.
									**********************************************************************************************
									**********************************************************************************************  
									 Result IS "H"=awarded Home Win, "A"=awarded Away Win, "D"=Draw awarded
									 Result IS "P"=Postponed, "Q"=Abandoned, "W"=Void
									 Result IS "T"=TEMP hidden from public
									**********************************************************************************************  
									**********************************************************************************************  
									--->
								
								<cfif DoesNotCountTowardsMatchBasedSuspensions 
									OR (Result IS "H" AND QAnyApps.AppearanceCount IS 0)
									OR (Result IS "A" AND QAnyApps.AppearanceCount IS 0)
									OR (Result IS "D" AND QAnyApps.AppearanceCount IS 0)
									OR Result IS "P" 
									OR Result IS "Q" 
									OR Result IS "W" 
									OR Result IS "T">
									<cfset ThisClass = "pix10silver">
								<cfelse>
									<cfset ThisClass = "pix10">
								</cfif>
																	
								<!--- check for exceptional awarded result where game was played and awarded later --->
								<cfset AwardedGameWasPlayed = "No">	
								<cfif Result IS "A" OR Result IS "H" OR Result IS "D">
									<cfif QAnyApps.AppearanceCount GT 0 >
										<cfset AwardedGameWasPlayed = "Yes">
									</cfif>
								</cfif>
								<cfif 
									((IsNumeric(HomeGoals) AND IsNumeric(AwayGoals)) OR AwardedGameWasPlayed IS "Yes" )
									AND NOT ListFind(UsedFixtureIDList,QSatisfyFixtures.FixtureID)
									AND (fixturedate GT #OldestFixtureDate#)
									AND (NOT DoesNotCountTowardsMatchBasedSuspensions) >
									<cfset UsedFixtureIDList = ListAppend(UsedFixtureIDList, QSatisfyFixtures.FixtureID)>
									<cfset YCount = YCount + 1 >
									<cfset OldestFixtureDate = #QSatisfyFixtures.fixturedate# >
								<cfelse>
									<cfset OldestFixtureDate = #QSatisfyFixtures.fixturedate# >
									<cfif ThisClass IS "pix10silver">
										<cfset NCount = NCount + 1 >
										<cfset XCount = XCount + 1 >
									<cfelse>
										<cfset NCount = NCount + 1 >
									</cfif>
								</cfif>
							</cfloop>
							<cfset MatchCount=MatchCount+1>
						</cfloop>
						<cfif YCount IS NumberOfMatches > 
							<cfset ThisLastDay = #DateFormat(OldestFixtureDate, 'YYYY-MM-DD')# >
							<cfinclude template="queries/upd_Suspension.cfm">
						<cfelse>
							<cfset ThisLastDay = '2999-12-31' >
							<cfinclude template="queries/upd_Suspension.cfm">
						</cfif>
					</cfif>
			</cfoutput>	 
		</cfif>
		</cfoutput>
	</cfoutput> 
</cfoutput> 
