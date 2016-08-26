
<cfcomponent name="webServices">

	<cffunction 
		name="_methodConvertLeagueCode" access="public" 
			hint="utility function to determine database and prefix fron concatenated leaguecode">
		<cfargument name="LeagueCode" 			type="string" 	required="true">
		<cfset variables.LeagueCode = arguments.LeagueCode>
		<cfif IsNumeric(RIGHT(variables.LeagueCode,4))>
			<cfset variables.dsn = 'fm' & RIGHT(variables.LeagueCode,4)>
			<cfset variables.filter = Left(variables.LeagueCode, (Len(TRIM(variables.LeagueCode))-4))>
   		</cfif>
	</cffunction>

	<cffunction name="_methodVerifyUser" access="public" hint="utility function for basic authentication">
		<cfargument name="username" 			type="string" 	required="true">
		<cfargument name="password" 			type="string" required="true">
		<cfset variables.userpermitted = 0>
		<cfif arguments.username EQ "terrymos" AND arguments.password EQ "Maik0poo">
			<cfset variables.userpermitted = 1>
		</cfif>
	</cffunction>	

	<cffunction name="checkClubPassword" access="public" returntype="numeric" hint="check if club password correct">
		<cfargument name="team_id" 				type="numeric" 	required="true">
		<cfargument name="password_club" 		type="string"   required="true">
		<cfargument name="leagueCode" 			type="string"   required="true">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var password_club_correct = 0>
		<cfinclude template="checkClubPassword.cfm">
		<cfreturn password_club_correct>
	</cffunction>	
	
	<cffunction name="checkLeagueAdminPassword" access="remote" returntype="numeric" hint="check if password correct">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="password" 			type="string"   required="true">
		<cfset var password_correct = 0>
		<cfinclude template="QThisPWD_query.cfm">
		<cfreturn password_correct>
	</cffunction>	
	
	<cffunction name="getLeaguesByAdminPassword" access="remote" returntype="array" hint="get leagues for password">
		<cfargument name="password" 			type="string"   required="true">
		<cfset var QLeagues = ArrayNew(1)>
		<cfinclude template="QThisLeagueAdmin_query.cfm">
		<cfreturn QLeagues>
	</cffunction>	


	<cffunction name="checkYellowAdminPassword" access="public" returntype="numeric" hint="check if password correct">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="password_3" 			type="string"   required="true">
		<cfset var password_3_correct = 0>
		<cfinclude template="QThisPWD_query.cfm">
		<cfreturn password_3_correct>
	</cffunction>	
	
	<cffunction name="getAllLeagues" access="remote" returntype="array" output="no">
		<cfset var QAllLeagues = ArrayNew(1)>
		<cfinclude template="QAllLeagues_query.cfm">
		<cfreturn QAllLeagues>
	</cffunction>	
	
	<cffunction name="getAllClubs" access="remote" returntype="array" output="no">
		<cfset var QAllClubs = ArrayNew(1)>
		<cfinclude template="QAllClubs_query.cfm">
		<cfreturn QAllClubs>
	</cffunction>

	<cffunction name="getAllFixtureInfoByIdAndLeagueCode" access="remote" returntype="array" output="no">
		<cfargument name="fixture_id" 			type="numeric" 	required="true">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		
		<cfset var QFixtureInfo		= ArrayNew(1)>
		<cfset var QFixture			= ArrayNew(1)>
		<cfset var QHomeTeamDetails = ArrayNew(1)>
		<cfset var QAwayTeamDetails = ArrayNew(1)>
		
		<cfinclude template="QFixture_query.cfm">
		<cfset arguments.HomeAway = 'H'>
		<cfinclude template="QgetMatchPlayers_query.cfm">
		<cfset QHomeTeamDetails = Duplicate(QTeamListArray)>
		<cfset temp = ArrayClear(QTeamListArray)>
		<cfset arguments.HomeAway = 'A'>
		<cfinclude template="QgetMatchPlayers_query.cfm">
		<cfset QAwayTeamDetails = Duplicate(QTeamListArray)>
		
		<cfscript>
			QFixtureInfo[1]					= StructNew();
			QFixtureInfo[1].fixture_info 	= #QFixture#;
			QFixtureInfo[1].home_team 		= #QHomeTeamDetails#;
			QFixtureInfo[1].away_team 		= #QAwayTeamDetails#;
		</cfscript>
		
		<cfreturn QFixtureInfo>
	</cffunction>
	
	<cffunction name="getAllOrdinals" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string" 	required="false" default="HLNC">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QAllOrdinals = ArrayNew(1)>
		<cfinclude template="QAllOrdinals_query.cfm">
		<cfreturn QAllOrdinals>
	</cffunction>
		
	
	<cffunction name="getAllTeams" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string" 	required="false" default="HLNC">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QAllTeams= ArrayNew(1)>
		<cfinclude template="QAllTeams_query.cfm">
		<cfreturn QAllTeams>
	</cffunction>
	
	
	<cffunction name="getAllConstitutions" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string" 	required="false" default="HLNC">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QAllConstitutions= ArrayNew(1)>
		<cfinclude template="QAllConstitutions_query.cfm">
		<cfreturn QAllConstitutions>
	</cffunction>
	
	<cffunction name="getAllPlayers" access="remote" returntype="array" output="no">
		<cfargument name="limit" 				type="string" 	required="true">
		<cfargument name="leagueCode" 			type="string" 	required="false" default="HLNC">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QAllPlayers= ArrayNew(1)>
		<cfinclude template="QAllPlayers_query.cfm">
		<cfreturn QAllPlayers>
	</cffunction>
	
	<cffunction name="getAllRegister" access="remote" returntype="array" output="no">
		<cfargument name="limit" 				type="string" 	required="true">
		<cfargument name="leagueCode" 			type="string" 	required="false" default="HLNC">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QAllRegister= ArrayNew(1)>
		<cfinclude template="QAllRegister_query.cfm">
		<cfreturn QAllRegister>
	</cffunction>
	
	<cffunction name="getAnnouncementNotes" access="remote" returntype="any" output="no">
		<cfargument name="leagueCode" 			type="string" 	required="yes">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var Notes = ''>
		<cfinclude template="QAnnouncement_query.cfm">
		<cfreturn Notes>
	</cffunction>	

	<cffunction name="getAppearancesByPlayerID" access="remote" returntype="any" output="no">
		<cfargument name="leagueCode" 			type="string" 	required="yes">
		<cfargument name="player_id" 			type="numeric" 	required="yes">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QPlayerHistory = ArrayNew(1)>
		<cfinclude template="QPlayerHistory_query.cfm">
		<cfreturn QPlayerHistory>
	</cffunction>	
	
	<cffunction name="getAttendanceStatsByLeagueAndDivisionID" access="remote" returntype="any" output="no">
		<cfargument name="leagueCode" 			type="string" 	required="yes">
		<cfargument name="division_id" 			type="numeric" 	required="yes">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QAttendanceStats = ArrayNew(1)>
		<cfinclude template="QAttendanceStats_query.cfm">
		<cfreturn QAttendanceStats>
	</cffunction>		
		
	<cffunction name="getCounties" access="remote" returntype="query" output="no">
		<cfset var QCounty = ''>
		<cfinclude template="QCounty.cfm">
		<cfreturn QCounty>
	</cffunction>	
	
	<cffunction name="getDivisionsByID" access="remote" returntype="array" output="no">
		<cfargument name="LeagueCode"   		type="string" 	required="true">
		<cfargument name="startDate"    		type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset var QDivisionsByLeagueIDArray = ArrayNew(1)>
		<cfinclude template="QDivisionsByLeagueID_query.cfm">
		<cfreturn QDivisionsByLeagueIDArray>
	</cffunction>
	
	<cffunction name="getFixtureByFixtureID" access="remote" returntype="array" output="no">
		<cfargument name="fixture_id" 			type="string" 	required="true">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset var QFixture = ArrayNew(1)>
		<cfinclude template="QFixture_query.cfm">
		<cfreturn QFixture>
	</cffunction>
	
	<cffunction name="getFixturesByDivisionIDAndDate" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_division_id" 	type="string" 	required="true">
		<cfargument name="startDate" 			type="string" 	required="true">
		<cfargument name="endDate" 				type="string" 	required="true">
		<cfargument name="leagueCode" 			type="string" 	required="true">		
		<cfargument name="limit" 				type="string"	required="true">
		<cfargument name="order" 				type="string" 	required="true">
		<cfset var QFixtures = ArrayNew(1)>
		<cfinclude template="QFixtures_query.cfm">
		<cfreturn QFixtures>
	</cffunction>
	
	<cffunction name="getFixturesByLeaguePrefixAndDate" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_division_id" 	type="string" 	required="false" default="">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="startDate" 			type="string" 	required="true">
		<cfargument name="endDate" 				type="string" 	required="true">
		<cfargument name="limit" 				type="string" 	required="true">
		<cfset var QFixtures = ArrayNew(1)>
		<cfinclude template="QFixtures_query.cfm">
		<cfreturn QFixtures>
	</cffunction>

	<cffunction name="getFixturesByTeamIdAndDate" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_team_id" 		type="string" 	required="false" default="">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="startDate" 			type="string" 	required="true">
		<cfargument name="endDate" 				type="string" 	required="true">
		<cfargument name="limit" 				type="string" 	required="true">
		<cfargument name="order" 				type="string" 	required="true">
		<cfset var QFixtures = ArrayNew(1)>
		<cfinclude template="QFixturesTeam_query.cfm">
		<cfreturn QFixtures>
	</cffunction>
	
	<cffunction name="getFixturesByConstitutionIdAndDate" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_constitution_id" type="string" 	required="false" default="">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="startDate" 			type="string" 	required="true">
		<cfargument name="endDate" 				type="string" 	required="true">
		<cfargument name="limit" 				type="string" 	required="true">
		<cfargument name="order" 				type="string" 	required="true">
		<cfset var QFixtures = ArrayNew(1)>
		<cfinclude template="QFixturesConstitution_query.cfm">
		<cfreturn QFixtures>
	</cffunction>
	
	<cffunction name="getFixturesByTeamOrdinalAndDate" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_team_id" type="string" 	required="false" default="">
		<cfargument name="mitoo_ordinal_id" type="string" 	required="false" default="">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="startDate" 			type="string" 	required="true">
		<cfargument name="endDate" 				type="string" 	required="true">
		<cfargument name="limit" 				type="string" 	required="true">
		<cfargument name="order" 				type="string" 	required="true">
		<cfset var QFixtures = ArrayNew(1)>
		<cfinclude template="QFixturesTeamOrdinal_query.cfm">
		<cfreturn QFixtures>
	</cffunction>
	
	<cffunction name="getFormByDivisionIDAndDate" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_division_id" 	type="numeric" 	required="true">
		<cfargument name="startDate" 			type="string" 	required="true">
		<cfargument name="endDate" 				type="string" 	required="true">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="limit" 				type="string"	required="true">
		<cfset var QLeagueTableComponents = ArrayNew(1)>
		<cfinclude template="QLeagueTableComponents_query.cfm">
		<cfreturn QLeagueTableComponents>
	</cffunction>
	
	
	<cffunction name="getFormByConstitutionIDAndDate" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_constitution_id" 		type="numeric" 	required="true">

		<cfargument name="startDate" 			type="string" 	required="true">
		<cfargument name="endDate" 				type="string" 	required="true">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="limit" 				type="string"	required="true">
		<cfset var QLeagueTableComponents = ArrayNew(1)>
		<cfinclude template="QLeagueTableComponentsTeam_query.cfm">
		<cfreturn QLeagueTableComponents>
	</cffunction>


	<cffunction name="getLeagueContactsByLeaguePrefix" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode"  			type="string" 	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset var QLeagueContacts = ArrayNew(1)>
		<cfinclude template="QLeagueContacts_query.cfm">
		<cfreturn QLeagueContacts>
	</cffunction>

	<cffunction name="getLeagueLeadingGoalScorersByLeaguePrefixAndDivisionID" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode"  			type="string" 	required="true">
		<cfargument name="division_id"  		type="numeric" 	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset var QLeagueLeadingGoalScorers = ArrayNew(1)>
		<cfinclude template="QgetLeagueYearFromDates.cfm">
		<cfif getLeagueYear.defaultGoalScorers IS 1>
			<!--- goalscorers MAY have been saved --->
			<cfinclude template="QGoalsScored_query.cfm">
		<cfelse>
			Sorry! No goal scorer records retained in this league
		</cfif>
		<cfreturn QLeagueLeadingGoalScorers>
	</cffunction>
	
	<cffunction name="getLeagueTableByDivisionId" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_division_id" 	type="string" 	required="true">
		<cfargument name="leaguecode" 			type="string" 	required="true">
		<cfargument name="limit" 				type="string"	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset var QLeagueTable = ArrayNew(1)>
		<!---  <cfinclude template="LeagueTab.cfm"> --->
		<cfinclude template="QLeagueTable_query.cfm">
		<cfreturn QLeagueTable>
	</cffunction>
	
	<cffunction name="getLeaguePositionByConstitutionId" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_constitution_id" 	type="string"	required="true">
		<cfargument name="mitoo_division_id" 		type="string" 	required="true">
		<cfargument name="leaguecode" 				type="string" 	required="true">
		<cfargument name="startDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"					type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset var QLeaguePosition = ArrayNew(1)>
		<cfinclude template="QLeaguePosition_query.cfm">
		<cfreturn QLeaguePosition>
	</cffunction>
	
	<cffunction name="getMessage" access="remote" returntype="string" output="no">
		<cfargument name="name" 					type="string" 	required="yes">
		<cfreturn "Hello " & arguments.name & "! " & "I've been invoked as a web service.">
	</cffunction>			

	<cffunction name="getPlayersByTeam" access="remote" returntype="array" output="no">
		<cfargument name="teamID" 				type="numeric" 	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset var QPlayersByTeamArray = ArrayNew(1)>
		<cfinclude template="QPlayersByTeam_query.cfm">
		<cfreturn QPlayersByTeamArray>
	</cffunction>	
	
	<cffunction name="getPlayersByTeamID" access="remote" returntype="array" output="no">
		<cfargument name="team_id" 				type="numeric" 	required="true">
		<cfargument name="leaguecode" 			type="string" 	required="true">		
		<cfargument name="fixture_date"			type="string"	required="true">
		<cfset var QPlayersByTeamIDArray = ArrayNew(1)>
		<cfif IsDate(arguments.fixture_date)>
			<cfset arguments.startDate = #arguments.fixture_date#>
			<cfset arguments.endDate   = #arguments.fixture_date#>				
			<cfinclude template="QPlayersByTeamID_query.cfm">
		<cfelse>
			Error
		</cfif>
		
		<cfreturn QPlayersByTeamIDArray>
	</cffunction>	
	
	<cffunction name="getRefereesByLeague" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset var QRefsByLeague = ArrayNew(1)>
		<cfinclude template="QRefsByLeague_query.cfm">
		<cfreturn QRefsByLeague>	
	</cffunction>

	<cffunction name="getResultGridByLeagueCodeAndDivisionID" access="remote" returntype="array" output="no">
		<cfargument name="division_id" 			type="numeric" 	required="true">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset resultGridArray = ArrayNew(1)>
		<cfinclude template="ResultsGrid.cfm">
		<cfreturn resultGridArray>	
	</cffunction>	
	
	<cffunction name="getSuspensionsByPlayerID" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string" 	required="true">
		<cfargument name="player_id" 			type="numeric" 	required="true">
		<cfargument name="startDate"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QSuspensionByPlayer = ArrayNew(1)>
		<cfinclude template="QPlayerSuspensions_query.cfm">
		<cfreturn QSuspensionByPlayer>
	</cffunction>	
	
	
	<cffunction name="getTeamsByDivision" access="remote" returntype="array" output="no">
		<cfargument name="divisionID" 			type="numeric" 	required="true">
		<cfargument name="leagueCode" 			type="string"  	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset var QTeamsByDivisionArray = ArrayNew(1)>
		<cfinclude template="QTeamsByDivision_query.cfm">		
		<cfreturn QTeamsByDivisionArray>
	</cffunction>
	
	<cffunction name="getTeamDetailsByTeamId" access="remote" returntype="array" output="no">
		<cfargument name="mitoo_team_id" 		type="numeric" 	required="true">
		<cfargument name="mitoo_ordinal_id" 	type="numeric" 	required="true">
		<cfargument name="leagueCode" 			type="string"  	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset var QTeamsDetailsArray = ArrayNew(1)>
		<cfinclude template="QTeamDetailsByTeamId_query.cfm">		
		<cfreturn QTeamsDetailsArray>
	</cffunction>
	
	<cffunction name="getTeamListByFixtureIdAndTeamID" access="remote" returntype="array" output="no">
		<cfargument name="fixture_id" 			type="numeric" 	required="true">
		<cfargument name="leagueCode" 			type="string"  	required="true">
		<cfargument name="fixture_date"			type="string"	required="true">
		<cfargument name="homeAway"				type="string"	required="true">
		<cfset var QTeamListArray = ArrayNew(1)>
		<cfif IsDate(arguments.fixture_date)>
			<cfset arguments.startDate = #arguments.fixture_date#>
			<cfset arguments.endDate   = #arguments.fixture_date#>				
			<cfinclude template="QgetMatchPlayers_query.cfm">
			<cfinclude template="QgetMatchNonPlayers_query.cfm">
		<cfelse>
			Error
		</cfif>
		<cfreturn QTeamListArray>
	</cffunction>
	
	<cffunction name="getAllPlayersByLeaguePrefixAndSurnameInitial" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string"  	required="true">
		<cfargument name="player_initial"		type="string"	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset var QAlphabetAllPlayerListArray = ArrayNew(1)>
		<cfinclude template="QgetAlphabetPlayersList_query.cfm">
		<cfreturn QAlphabetAllPlayerListArray>
	</cffunction>	
	
	<cffunction name="getPlayerDetailsByPlayerID" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string"  	required="true">
		<cfargument name="player_id"			type="numeric"	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset var QPlayerDetailArray = ArrayNew(1)>
		<cfinclude template="QgetPlayerDetail_query.cfm">
		<cfreturn QPlayerDetailArray>
	</cffunction>		
	
	<cffunction name="getTopGoalScorers" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string"  	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset var QTopGoalsArray = ArrayNew(1)>
		<cfinclude template="QgetTopScorerers_query.cfm">
		<cfreturn QTopGoalsArray>
	</cffunction>		
	
	<cffunction name="SeasonTopGoalScorers" access="remote" returntype="array" output="no">
		<cfargument name="leagueCode" 			type="string"  	required="true">
		<cfargument name="startDate"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">		
		<cfset var QTopGoalsArray = ArrayNew(1)>
		<cfinclude template="QseasonTopScorerers_query.cfm">
		<cfreturn QTopGoalsArray>
	</cffunction>	
	
</cfcomponent>
