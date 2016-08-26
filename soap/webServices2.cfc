<cfcomponent name="webServices">

	<cffunction name="getDivisionFromMitooLookup" access="remote" returntype="array" output="no">
		<cfargument name="division_id" 			type="string" 	required="true">
		<cfargument name="start_date" 			type="string" 	required="true">
		<cfargument name="end_date" 			type="string" 	required="true">
		<cfinclude template="QDivisionLookup_query.cfm">
		<cfreturn QDivision>
	</cffunction>
	
	<cffunction name="getTeamFromMitooLookup" access="remote" returntype="array" output="no">
		<cfargument name="team_id" 				type="string" 	required="true">
		<cfargument name="start_date" 			type="string" 	required="true">
		<cfargument name="end_date" 			type="string" 	required="true">
		<cfinclude template="QTeamLookup_query.cfm">
		<cfreturn QTeam>
	</cffunction>

	<cffunction name="getTeamFromMitooTeamLeagueLookup" access="remote" returntype="array" output="no">
		<cfargument name="team_id" 				type="string" 	required="true">
		<cfargument name="league_code"			type="string" 	required="true">
		<cfargument name="start_date" 			type="string" 	required="true">
		<cfargument name="end_date" 			type="string" 	required="true">
		<cfinclude template="QTeamLeagueLookup_query.cfm">
		<cfreturn QTeam>
	</cffunction>

	<cffunction name="getDivisionFixtures" access="remote" returntype="array" output="no">
		<cfargument name="league_code" 			type="string" 	required="true">	
		<cfargument name="division_id" 			type="string" 	required="true">
		<cfargument name="start_date" 			type="string" 	required="true">
		<cfargument name="end_date" 			type="string" 	required="true">
		<cfargument name="limit" 				type="string"	required="true">
		<cfargument name="order" 				type="string" 	required="true">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript> QFixtures[1] = StructNew(); </cfscript>
			<cfreturn QFixtures>
		</cfif>	
		<cfinclude template="QFixtures_query2.cfm">
		<cfreturn QFixtures>
	</cffunction>
	
	<cffunction name="getLeagueFixtures" access="remote" returntype="array" output="no">
		<cfargument name="league_code"		    type="string"   required="true">
		<cfargument name="division_id_list" 	type="string" 	required="true">
		<cfargument name="start_date" 			type="string" 	required="true">
		<cfargument name="end_date" 			type="string" 	required="true">
		<cfargument name="limit" 				type="string"	required="true">
		<cfargument name="order" 				type="string" 	required="true">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript> QFixtures[1] = StructNew(); </cfscript>
			<cfreturn QFixtures>
		</cfif>	
		<cfinclude template="QLeagueFixtures_query2.cfm">
		<cfreturn QFixtures>
	</cffunction>	

	<cffunction name="getLeagueFixtureDates" access="remote" returntype="array" output="no">
		<cfargument name="league_code"		    type="string"   required="true">
		<cfargument name="division_id_list" 	type="string" 	required="true">
		<cfargument name="start_date" 			type="string" 	required="true">
		<cfargument name="end_date" 			type="string" 	required="true">
		<cfargument name="limit" 				type="string"	required="true">
		<cfargument name="order" 				type="string" 	required="true">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript> QFixtureDates[1] = StructNew(); </cfscript>
			<cfreturn QFixtureDates>
		</cfif>	
		<cfinclude template="QLeagueFixtureDates_query2.cfm">
		<cfreturn QFixtureDates>
	</cffunction>	
	
	<cffunction name="getDivisionTable" access="remote" returntype="array" output="no">
		<cfargument name="league_code"		    type="string"   required="true">	
		<cfargument name="division_id" 			type="string" 	required="true">
		<cfargument name="start_date" 			type="string" 	required="true">
		<cfargument name="end_date" 			type="string" 	required="true">
		<cfargument name="limit" 				type="string"	required="true">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript> QLeagueTable[1] = StructNew(); </cfscript>
			<cfreturn QLeagueTable>
		</cfif>			
		<cfinclude template="QLeagueTable_query2.cfm">
		<cfreturn QLeagueTable>
	</cffunction>	
	
	<cffunction name="getDivisionForm" access="remote" returntype="array" output="no">
		<cfargument name="league_code"	type="string"   required="true">	
		<cfargument name="division_id" 	type="string" 	required="true">
		<cfargument name="start_date" 	type="string" 	required="true">
		<cfargument name="end_date" 	type="string" 	required="true">
		<cfargument name="limit" 		type="string"	required="true">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript>QLeagueTableComponents[1] = StructNew(); </cfscript>
			<cfreturn QLeagueTableComponents>
		</cfif>			
		<cfinclude template="QLeagueTableComponents_query2.cfm">
		<cfreturn QLeagueTableComponents>
	</cffunction>
	
	<cffunction name="getDivisionTopScorers" access="remote" returntype="array" output="no">
		<cfargument name="league_code"			type="string"   required="true">		
		<cfargument name="division_id"  		type="string" 	required="false">
		<cfargument name="start_date"			type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="end_date"				type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript>QLeagueLeadingGoalScorers[1] = StructNew(); </cfscript>
			<cfreturn QLeagueLeadingGoalScorers>
		</cfif>		
		<cfinclude template="QGoalsScored_query2.cfm">
		<cfreturn QLeagueLeadingGoalScorers>
	</cffunction>
	
	<cffunction name="getDivisionSuspensions" access="remote" returntype="array" output="no">
		<cfargument name="division_id" 			type="string" 	required="true">
		<cfargument name="start_date"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="end_date"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QSuspensionByPlayer = ArrayNew(1)>
		<cfinclude template="QDivisionSuspensions_query.cfm">
		<cfreturn QSuspensionByPlayer>
	</cffunction>
	
	<cffunction name="getDivisionAttendance" access="remote" returntype="array" output="no">
		<cfargument name="division_id" 			type="string" 	required="true">
		<cfargument name="start_date"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="end_date"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QDivisionAttendance = ArrayNew(1)>
		<cfinclude template="QDivisionAttendance2_query.cfm">
		<cfreturn QDivisionAttendance>
	</cffunction>
	
	<cffunction name="getClubSuspensions" access="remote" returntype="array" output="no">
		<cfargument name="club_id" 				type="string" 	required="true">
		<cfargument name="start_date"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="end_date"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfset var QSuspensionByPlayer = ArrayNew(1)>
		<cfinclude template="QClubSuspensions_query.cfm">
		<cfreturn QSuspensionByPlayer>
	</cffunction>
	
	<cffunction name="getFixtureInfo" access="remote" returntype="array" output="no">
		<cfargument name="fixture_id" 			type="numeric" 	required="true">
		<cfargument name="league_code" 			type="string" 	required="true">
		<cfargument name="start_date"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="end_date"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfinclude template="QgetLeagueYearFromDates3.cfm">		
		<cfif inSeason IS 0>
			<cfscript> QFixtureInfo[1] = StructNew(); </cfscript>
			<cfreturn QFixtureInfo>
		</cfif>	
		<cfinclude template="QFixture_query2.cfm">
		<cfreturn QFixtureInfo>
	</cffunction>	
	
	<cffunction name="getTeamFixtures" access="remote" returntype="array" output="no">
		<cfargument name="league_code" 				type="string" 	required="true">		
		<cfargument name="team_id" 					type="string" 	required="false" default="">
		<cfargument name="start_date" 				type="string" 	required="true">
		<cfargument name="end_date" 				type="string" 	required="true">
		<cfargument name="limit" 					type="string" 	required="true">
		<cfargument name="order" 					type="string" 	required="true">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript> QFixtures[1] = StructNew(); </cfscript>
			<cfreturn QFixtures>
		</cfif>		
		<cfinclude template="QFixturesConstitution2_query.cfm">
		<cfreturn QFixtures>
	</cffunction>
	
	<cffunction name="getTeamAllConsFixtures" access="remote" returntype="array" output="no">
		<cfargument name="team_id" 					type="string" 	required="false" default="">
		<cfargument name="start_date" 				type="string" 	required="true">
		<cfargument name="end_date" 				type="string" 	required="true">
		<cfargument name="limit" 					type="string" 	required="true">
		<cfargument name="order" 					type="string" 	required="true">
		<cfargument name="league_code" 				type="string" 	required="true">
		<cfargument name="division_id_list" 		type="string" 	required="true">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript> QFixtures[1] = StructNew(); </cfscript>
			<cfreturn QFixtures>
		</cfif>
		<cfinclude template="QFixturesAllCons2_query.cfm">
		<cfreturn QFixtures>
	</cffunction>
	
	<cffunction name="getTeamAllConsFixtureDates" access="remote" returntype="array" output="no">
		<cfargument name="team_id" 					type="string" 	required="false" default="">
		<cfargument name="start_date" 				type="string" 	required="true">
		<cfargument name="end_date" 				type="string" 	required="true">
		<cfargument name="limit" 					type="string" 	required="true">
		<cfargument name="order" 					type="string" 	required="true">
		<cfargument name="league_code" 				type="string" 	required="true">
		<cfargument name="division_id_list" 		type="string" 	required="true">
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfif inSeason IS 0>
			<cfscript> QTeamFixtureDates[1] = StructNew(); </cfscript>
			<cfreturn QTeamFixtureDates>
		</cfif>
		<cfinclude template="QFixtureDatesAllCons2_query.cfm">
		<cfreturn QTeamFixtureDates>
	</cffunction>	
	
	<cffunction name="getTeamTablePosition" access="remote" returntype="array" output="no">
		<cfargument name="team_id" 		type="string"	required="true">
		<cfargument name="start_date"	type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="end_date"		type="string"	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfinclude template="QLeaguePosition_query2.cfm">
		<cfreturn QLeaguePosition>
	</cffunction>	
	
	<cffunction name="getTeamForm" access="remote" returntype="array" output="no">
		<cfargument name="team_id" 			type="string" 	required="true">
		<cfargument name="start_date" 		type="string" 	required="true">
		<cfargument name="end_date" 		type="string" 	required="true">
		<cfargument name="limit" 			type="string"	required="true">
		<cfset var QLeagueTableComponents = ArrayNew(1)>
		<cfinclude template="QLeagueTableComponentsTeam_query2.cfm">
		<cfreturn QLeagueTableComponents>
	</cffunction>
	
	<cffunction name="getPlayerAppearances" access="remote" returntype="array" output="no">
		<cfargument name="player_id" 			type="string" 	required="yes">
		<cfargument name="league_code" 			type="string" 	required="false">		
		<cfargument name="start_date"			type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="end_date"				type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">	
		<cfinclude template="QgetLeagueYearFromDates3.cfm">
		<cfscript>QPlayerHistory[1] = StructNew(); </cfscript>
		<cfif inSeason IS 0>
			<cfscript>QPlayerHistory[1] = StructNew(); </cfscript>
			<cfreturn QPlayerHistory>
		</cfif>
		<cfinclude template="QPlayerHistory2_query.cfm">
		<cfreturn QPlayerHistory>
	</cffunction>
	
</cfcomponent>