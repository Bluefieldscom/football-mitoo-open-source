<cfcomponent name="webServicesWrite" hint="All admin insert and update functions from GoalRun interface">
<!---
<cfdump var="#variables#"><cfabort>
<cfdump var="#this#"><cfabort>
--->
	<cffunction name="updatePlayerSuspensionByPlayerID" returntype="numeric" hint="change player suspension in suspension table">
		<!--- this functionality is NOT via Action.cfm --->
		<cfargument name="leagueCode" 					type="string"	required="true">
		<cfargument name="player_id" 					type="numeric"	required="true">
		<cfargument name="firstDay" 					type="string"	required="true">
		<cfargument name="lastDay" 						type="string"	required="true">
		<cfargument name="SID"							type="numeric"	required="true">
		<cfargument name="numberOfMatches" 				type="numeric"	required="false" default="0">

		<cfset var ws_success = 0>

		<cfset arguments.startdate = arguments.firstDay>
		<cfset arguments.enddate   = arguments.lastDay>

		<cfif arguments.firstDay GT arguments.lastDay>
			Error! first day of suspension is after the last day!
			<cfabort>
		</cfif>

		<!--- we need to add security checking --->
		<cfset request.securitylevel = "Skyblue">

		<cfinclude template="QPlayerSuspensionUpdate_query.cfm">

		<!--- this will ONLY work in CF8, because it uses the 'result' attribute of cfquery, missing in CF6 --->
		<cfif StructKeyExists(QPlayerSuspensionUpdate_result,"recordcount")
			  AND QPlayerSuspensionUpdate_result.recordcount EQ 1>
			<cfset ws_success = 1>
		</cfif>

		<cfreturn ws_success>

	</cffunction>


	<cffunction name="deletePlayerSuspensionBySuspensionID" returntype="numeric" hint="delete a player suspension">
		<!--- this functionality is NOT via Action.cfm --->
		<cfargument name="leagueCode" 					type="string"	required="true">
		<cfargument name="SID" 							type="numeric"	required="true">
		<cfargument name="startDate"					type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">
		<cfargument name="endDate"						type="string" 	required="false" default="#dateformat(Now(),'YYYY-mm-dd')#">

		<cfset var ws_success = 0>

		<!--- we need to add security checking --->
		<cfset request.securitylevel = "Skyblue">

		<cfinclude template="QPlayerSuspensionDelete_query.cfm">

		<!--- this will ONLY work in CF8, because it uses the 'result' attribute of cfquery, missing in CF6 --->
		<cfif StructKeyExists(QPlayerSuspensionDelete_result,"recordcount")
			  AND QPlayerSuspensionDelete_result.recordcount EQ 1>
			<cfset ws_success = 1>
		</cfif>

		<cfreturn ws_success>

	</cffunction>

	<cffunction name="addPlayerSuspensionByPlayerID" returntype="numeric" hint="add player suspension to suspension table">
		<!--- this functionality is NOT via Action.cfm --->
		<cfargument name="leagueCode" 					type="string"	required="true">
		<cfargument name="player_id" 					type="numeric"	required="true">
		<cfargument name="firstDay" 					type="string"	required="true">
		<cfargument name="lastDay" 						type="string"	required="true">
		<cfargument name="numberOfMatches" 				type="numeric"	required="false" default="0">

		<cfset var ws_success = 0>

		<cfset arguments.startdate = arguments.firstDay>
		<cfset arguments.enddate   = arguments.lastDay>

		<cfif arguments.firstDay GT arguments.lastDay>
			Error! first day of suspension is after the last day!
			<cfabort>
		</cfif>

		<!--- we need to add security checking --->
		<cfset request.securitylevel = "Skyblue">

		<cfinclude template="QPlayerSuspensionAdd_query.cfm">

		<!--- this will ONLY work in CF8, because it uses the 'result' attribute of cfquery, missing in CF6 --->
		<cfif StructKeyExists(QPlayerSuspensionAdd_result,"recordcount")
			  AND QPlayerSuspensionAdd_result.recordcount EQ 1>
			<cfset ws_success = 1>
		</cfif>

		<cfreturn ws_success>

	</cffunction>

	<cffunction name="deletePlayer" returntype="numeric" hint="remove a player from the player table">
		<cfargument name="tblName" 						type="string" 	required="false" default="Player">
		<cfargument name="operation" 					type="string" 	required="false" default="Delete">
		<cfargument name="leagueCode" 					type="string"	required="true">
		<cfargument name="player_id" 					type="numeric"	required="true">

		<cfset var ws_success = 0>
		<cfset arguments.startdate = "#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset arguments.enddate   = "#dateformat(Now(),'YYYY-mm-dd')#">

		<!--- we need to add security checking --->
		<cfset request.securitylevel = "Skyblue">

		<cfinclude template="QgetLeagueYearFromDates.cfm">

		<cfscript>
			// this handles bypass of redirect to LUList in action.cfm:292
			form.ws_insert		= 1;

			form.ID				= arguments.player_id;
			form.operation		= arguments.operation;
			tblName				= arguments.tblName;
			// from league season query
			form.leagueID		= variables.league_id;
			// if required
			session.currentDate = arguments.startdate;

			// for db handling
			request.dsn = variables.dsn;
			request.filter = arguments.leagueCode;

		</cfscript>
		<cfinclude template="../action.cfm">
		<!--- this will ONLY work in CF8, because it uses the 'result' attribute of cfquery, missing in CF6 --->
		<cfif StructKeyExists(DeleteTblName_result,"recordcount")
			  AND DeleteTblName_result.recordcount EQ 1>
			<cfset ws_success = 1>
		</cfif>

		<cfreturn ws_success>

	</cffunction>


	<cffunction name="updatePlayer" returntype="numeric" hint="update player details">
		<cfargument name="tblName" 						type="string" 	required="false" default="Player">
		<cfargument name="operation" 					type="string" 	required="false" default="Update">
		<cfargument name="player_firstname" 			type="string" 	required="true">
		<cfargument name="player_lastname" 				type="string" 	required="true">
		<cfargument name="player_date_of_birth" 		type="string" 	required="true">
		<cfargument name="player_unique_number" 		type="numeric"	required="true">
		<cfargument name="player_notes" 				type="string"	required="true">
		<cfargument name="leagueCode" 					type="string"	required="true">
		<cfargument name="player_id" 					type="numeric"	required="true">

		<cfset var ws_success = 0>
		<cfset arguments.startdate = "#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset arguments.enddate   = "#dateformat(Now(),'YYYY-mm-dd')#">

		<!--- we need to add security checking --->
		<cfset request.securitylevel = "Skyblue">

		<cfinclude template="QgetLeagueYearFromDates.cfm">

		<cfscript>
			// this handles bypass of redirect to LUList in action.cfm:292
			form.ws_insert		= 1;

			form.forename 		= arguments.player_firstname;
			form.surname 		= arguments.player_lastname;
			if (len(arguments.player_date_of_birth) > 0) {
			form.DOB_YYYY		= YEAR(arguments.player_date_of_birth);
			form.DOB_MM			= MONTH(arguments.player_date_of_birth);
			form.DOB_DD			= DAY(arguments.player_date_of_birth);
			} else {
			form.DOB_YYYY		= "";
			form.DOB_MM			= "";
			form.DOB_DD			= "";
			}
			form.shortcol		= arguments.player_unique_number;
			form.notes			= arguments.player_notes;
			form.ID				= arguments.player_id;
			form.operation		= arguments.operation;
			tblName				= arguments.tblName;
			// from league season query
			form.leagueID		= variables.league_id;
			// if required
			session.currentDate = arguments.startdate;

			// for db handling
			request.dsn = variables.dsn;
			request.filter = arguments.leagueCode;

		</cfscript>
		<cfinclude template="../action.cfm">
		<!--- this will ONLY work in CF8, because it uses the 'result' attribute of cfquery, missing in CF6 --->
		<cfif StructKeyExists(QUpdtPlayerRecord_result,"recordcount")
			  AND QUpdtPlayerRecord_result.recordcount EQ 1>
			<cfset ws_success = 1>
		</cfif>

		<cfreturn ws_success>

	</cffunction>



	<cffunction name="insertPlayer" returntype="numeric" hint="add a new player">
		<cfargument name="tblName" 						type="string" 	required="false" default="Player">
		<cfargument name="operation" 					type="string" 	required="false" default="Add">
		<cfargument name="player_firstname" 			type="string" 	required="true">
		<cfargument name="player_lastname" 				type="string" 	required="true">
		<cfargument name="player_date_of_birth" 		type="string" 	required="true">
		<cfargument name="player_unique_number" 		type="numeric"	required="true">
		<cfargument name="leagueCode" 					type="string"	required="true">
		<cfargument name="player_notes" 				type="string"	required="true">

		<cfset var ws_success = 0>
		<cfset arguments.startdate = "#dateformat(Now(),'YYYY-mm-dd')#">
		<cfset arguments.enddate   = "#dateformat(Now(),'YYYY-mm-dd')#">

		<!--- we need to add security checking --->
		<cfset request.securitylevel = "Skyblue">

		<cfinclude template="QgetLeagueYearFromDates.cfm">

		<cfscript>
			// this handles bypass of redirect to LUList in action.cfm:292
			form.ws_insert		= 1;

			form.forename 		= arguments.player_firstname;
			form.surname 		= arguments.player_lastname;
			form.DOB_YYYY		= YEAR(arguments.player_date_of_birth);
			form.DOB_MM			= MONTH(arguments.player_date_of_birth);
			form.DOB_DD			= DAY(arguments.player_date_of_birth);
			form.shortcol		= arguments.player_unique_number;
			form.notes			= arguments.player_notes;
			form.operation		= arguments.operation;
			tblName				= arguments.tblName;

			// if required
			session.currentDate = arguments.startdate;

			// for db handling
			request.dsn = variables.dsn;
			request.filter = arguments.leagueCode;

			// from date query, required by action.cfm
			form.leagueID		= variables.league_id;

		</cfscript>

		<cfinclude template="../action.cfm">

		<!--- this will ONLY work in CF8, because it uses the 'result' attribute of cfquery, missing in CF6 --->
		<cfif StructKeyExists(InsrtPlayer_result,"recordcount")
			  AND InsrtPlayer_result.recordcount EQ 1>
			<cfset ws_success = 1>
		</cfif>

		<cfreturn ws_success>

	</cffunction>

	<cffunction name="updateTeamListByFixtureID" returntype="boolean" hint="updates 'team list' by inserting to appearance table and updating same where relevant">
		<!---
		expected array structures:

		fixture_id  numeric
		homeAway    string
		player_id   numeric
		goalsScored numeric (including 0)
		cardValue	numeric (including 0)
		starPlayer  numeric (including 0)
		leaguecode  string

		from this we create an insert statement to do them all at once,
		rather than a loop setting each one separately
		--->
		<cfargument name="fixture_date" 			type="string" 	required="true">
		<cfargument name="leagueCode" 				type="string" 	required="true">
		<cfargument name="insertAppearanceArray" 	type="array" 	required="true">
		<cfargument name="updateAppearanceArray" 	type="array" 	required="true">

		<cfset var success=1>

		<cfif IsDate(arguments.fixture_date)>
			<cfset arguments.startDate = #arguments.fixture_date#>
			<cfset arguments.endDate   = #arguments.fixture_date#>
		<cfelse>
			Error
		</cfif>

		<cfif ArrayLen(arguments.insertAppearanceArray) GT 0>
			<cfinclude template="QinsertAppearances_query.cfm">
		</cfif>

		<cfif ArrayLen(arguments.updateAppearanceArray) GT 0>
			<cfinclude template="QupdateAppearances_query.cfm">
		</cfif>

		<cfreturn ws_success>
	</cffunction>

	<cffunction name="updateMitooFixture" returntype="boolean" hint="updates (usually with scores and other data) an existing scheduled fixture">

		<cfargument name="tblName" 						type="string" 	required="false" default="Matches">
		<cfargument name="operation" 					type="string" 	required="false" default="Update">

		<cfargument name="fixture_result" 				type="string" 	required="true">
		<cfargument name="mitoo_division_id" 			type="numeric" 	required="true">
		<cfargument name="mitoo_league_prefix" 			type="string" 	required="true">
		<cfargument name="fixture_id" 					type="numeric" 	required="true">
		<cfargument name="fixture_notes" 				type="string" 	required="true">
		<cfargument name="fixture_date" 				type="string" 	required="true">
		<cfargument name="fixture_home_id" 				type="numeric" 	required="true">
		<cfargument name="fixture_away_id" 				type="numeric" 	required="true">
		<cfargument name="ko_round_id" 					type="any" 	required="false" default="">
		<cfargument name="referee_id" 					type="numeric" 	required="true">
		<cfargument name="assist_referee_1_id" 			type="any" 		required="true">
		<cfargument name="assist_referee_2_id" 			type="any" 		required="true">
		<cfargument name="fourth_official_id" 			type="any" 		required="true">
		<cfargument name="home_sportsmanship_marks" 	type="numeric" 	required="true">
		<cfargument name="away_sportsmanship_marks" 	type="numeric" 	required="true">
		<cfargument name="match_official_expenses" 		type="string" 	required="true">
		<cfargument name="home_points_adjust" 			type="numeric" 	required="true">
		<cfargument name="away_points_adjust" 			type="numeric" 	required="true">
		<cfargument name="fixture_home_goals" 			type="numeric" 	required="true">
		<cfargument name="fixture_away_goals" 			type="numeric" 	required="true">
		<cfargument name="fixture_home_team_notes" 		type="string" 	required="true">
		<cfargument name="fixture_away_team_notes" 		type="string" 	required="true">
		<cfargument name="referee_home_marks" 			type="any" 		required="true">
		<cfargument name="referee_away_marks" 			type="any" 		required="true">

		<cfargument name="asstRef1Marks" 				type="any" 		required="false" default="">
		<cfargument name="asstRef2Marks" 				type="any" 		required="false" default="">

		<cfargument name="assist_referee_1_home_marks" 	type="any" 		required="true">
		<cfargument name="assist_referee_1_away_marks" 	type="any" 		required="true">
		<cfargument name="assist_referee_2_home_marks" 	type="any" 		required="true">
		<cfargument name="assist_referee_2_away_marks" 	type="any" 		required="true">
		<cfargument name="assessor_id" 					type="any" 		required="true">
		<cfargument name="assessor_marks" 				type="numeric" 	required="true">
		<cfargument name="hospitality" 					type="string" 	required="true">
		<cfargument name="hospitality_marks" 			type="numeric" 	required="true">
		<cfargument name="attendance" 					type="numeric" 	required="true">
		<cfargument name="home_club_official_benches" 	type="string" 	required="true">
		<cfargument name="away_club_official_benches" 	type="string" 	required="true">
		<cfargument name="state_of_pitch" 				type="string" 	required="true">
		<cfargument name="club_facilities" 				type="string" 	required="true">

		<cfargument name="pitchAvailableID" 			type="any" 	required="false" default="0">

		<!---
		<cfargument name="dateChange" type="string" required="false" default="Yes">
		<cfargument name="dateChangeSuppress" type="string" required="false" default="checked">
		--->

		<!--- we need to add security checking --->
		<cfset request.securitylevel = "Skyblue">
		<cfset session.LeagueType = "Normal">
		<cfset session.RefMarksOutOfHundred = 10>

		<!--- set relevant database --->
		<cfset arguments.startDate = arguments.fixture_date>
		<cfset arguments.endDate   = arguments.fixture_date>
		<cfset arguments.leaguecode = arguments.mitoo_league_prefix>
		<cfinclude template="QgetLeagueYearFromDates.cfm">

		<cfif arguments.ko_round_id IS "">
			<cfset variables.getWhere = 'IS NULL'>
		<cfelse>
			<cfset variables.getWhere = '= "#arguments.ko_round_id#"'>
		</cfif>
		<cfinclude template="QgetKORoundID_query.cfm">
		<cfset variables.koRoundID = getKORoundID.ID>

		<cfscript>
			doubleheader					= "No";
			id								= arguments.fixture_id;
			homeid							= arguments.fixture_home_id;
			awayid							= arguments.fixture_away_id;
			divisionid						= arguments.mitoo_division_id;
			form.textNotes 					= arguments.fixture_notes;
			form.operation 					= arguments.operation;

			form.radiobutton 				= arguments.fixture_result;

			form.refereeID 					= arguments.referee_id;
			form.asstRef1ID 				= arguments.assist_referee_1_id;
			form.asstRef2ID 				= arguments.assist_referee_2_id;
			form.fourthOfficialID 			= arguments.fourth_official_id;
			form.assessorID 				= arguments.assessor_id;
			form.homeSportsmanshipMarks 	= arguments.home_sportsmanship_marks;
			form.awaySportsmanshipMarks 	= arguments.away_sportsmanship_marks;
			form.matchOfficialsExpenses 	= arguments.match_official_expenses;
			form.homePointsAdjust 			= arguments.home_points_adjust;
			form.awayPointsAdjust 			= arguments.away_points_adjust;
			form.homeGoals 					= arguments.fixture_home_goals;
			form.awayGoals 					= arguments.fixture_away_goals;
			form.homeTeamNotes 				= arguments.fixture_home_team_notes;
			form.awayTeamNotes 				= arguments.fixture_away_team_notes;
			form.refereeMarksH 				= arguments.referee_home_marks;
			form.refereeMarksA 				= arguments.referee_away_marks;

			// these two variables not currently input?
			form.asstRef1Marks 				= arguments.asstRef1Marks;
			form.asstRef2Marks 				= arguments.asstRef2Marks;

			form.asstRef1MarksH 			= arguments.assist_referee_1_home_marks;
			form.asstRef1MarksA 			= arguments.assist_referee_1_away_marks;
			form.asstRef2MarksH 			= arguments.assist_referee_2_home_marks;
			form.asstRef2MarksA 			= arguments.assist_referee_2_away_marks;

			form.assessmentMarks 			= arguments.assessor_marks;
			form.attendance 				= arguments.attendance;
			form.hospitality 				= arguments.hospitality;
			form.hospitalityMarks 			= arguments.hospitality_marks;
			form.homeClubOfficialsBenches 	= arguments.home_club_official_benches;
			form.awayClubOfficialsBenches 	= arguments.away_club_official_benches;
			form.stateOfPitch 				= arguments.state_of_pitch;
			form.clubFacilities 			= arguments.club_facilities;

			form.pitchAvailableID			= arguments.pitchAvailableID;
			form.koRoundID					= variables.koRoundID;

			//form.dateChangeSuppress			= arguments.dateChangeSuppress;
			// fix for this, as we are not receiving datebox, but may in future!
			//form.datebox					= arguments.datebox;
			form.datebox					= DateFormat(arguments.fixture_date,'dddd, dd mmm yyyy');

			form.whence						= "WS";

			//session.currentDate = dateformat(form.datebox, 'YYYY-mm-dd');
			session.currentDate = arguments.fixture_date;
			request.dsn = variables.dsn;
			request.filter = arguments.leagueCode;

		</cfscript>

		<!---
		<cfdump var="#arguments#">
		<cfdump var="#variables#">
		<cfdump var="#form#">
		--->

		<cfset ws_success = 0>

		<cfinclude template="../action.cfm">
		<!--- this runs InclFixtureUpdate.cfm and inclWhence.cfm, which sets the variable ws_success to 1 if complete --->
		<!--- currently, InclWhence then aborts, which leaves us hanging --->

		<cfreturn ws_success>

	</cffunction>

<!---
	<cffunction name="insertMitooFixture" access="remote" returntype="numeric" output="no" hint="inserts a new fixture into football mitoo table">
		<cfargument name="fixture_home_id" 			type="numeric" 	required="true">
		<cfargument name="fixture_away_id" 			type="numeric" 	required="true">
		<cfargument name="fixture_match_number" 	type="numeric" 	required="true">
		<cfargument name="fixture_referee_id" 		type="any" 		required="false">
		<cfargument name="mitoo_league_prefix" 		type="string" 	required="true">
		<cfargument name="ko_round_id" 				type="string" 	required="false" default="">
		<cfargument name="assist_referee_1_id" 		type="any" 		required="false">
		<cfargument name="assist_referee_2_id" 		type="any" 		required="false">
		<cfargument name="fourth_official_id" 		type="any" 		required="false">
		<cfargument name="assessor_id" 				type="any" 		required="false">
		<!--- <cfargument name="match_officials_expenses" type="string" 	required="false"> --->
		<cfargument name="fixture_date" 			type="date" 	required="true">
		<cfargument name="fixture_notes" 			type="string" 	required="false">

		<cfset var fixture_id = 0>

		<!--- set relevant database --->
		<cfset arguments.startDate 	= arguments.fixture_date>
		<cfset arguments.endDate   	= arguments.fixture_date>
		<cfset arguments.leaguecode = arguments.mitoo_league_prefix>
		<cfinclude template="QgetLeagueYearFromDates.cfm">

		<cftry>
			<cfif arguments.ko_round_id IS "">
				<cfset variables.getWhere = 'IS NULL'>
			<cfelse>
				<cfset variables.getWhere = '= "#arguments.ko_round_id#"'>
			</cfif>

			<cfinclude template="QgetKORoundID_query.cfm">
			<cfset variables.koRoundID = getKORoundID.ID>

			<cfinclude template="QgetNoRefID_query.cfm">
			<cfset variables.defaultRefID = getNoRefID.ID>

			<cfif arguments.fixture_referee_id EQ "">
				<cfset variables.fixture_referee_id = variables.defaultRefID>
			<cfelse>
				<cfset variables.fixture_referee_id = arguments.fixture_referee_id>
			</cfif>
			<cfif arguments.assist_referee_1_id EQ "">
				<cfset variables.asstref1_id = variables.defaultRefID>
			<cfelse>
				<cfset variables.asstref1_id = arguments.assist_ref_1_id>
			</cfif>

			<cfif arguments.assist_referee_2_id EQ "">
				<cfset variables.asstref2_id = variables.defaultRefID>
			<cfelse>
				<cfset variables.asstref2_id = arguments.assist_ref_2_id>
			</cfif>

			<cfif arguments.fourth_official_id EQ "">
				<cfset variables.fourth_official_id = variables.defaultRefID>
			<cfelse>
				<cfset variables.fourth_official_id = arguments.fourth_official_id>
			</cfif>

			<cfif arguments.assessor_id EQ "">
				<cfset variables.assessor_id = variables.defaultRefID>
			<cfelse>
				<cfset variables.assessor_id = arguments.assessor_id>
			</cfif>

			<cfquery name="insertFixture" datasource="fm2008" result="insertResult">
				INSERT INTO	fixture
					  (HomeID, AwayID, MatchNumber,
					  RefereeID, LeagueCode, KORoundID, AsstRef1ID, AsstRef2ID,
					  FourthOfficialID, AssessorID, FixtureDate, FixtureNotes)
				VALUES(#arguments.fixture_home_id#,
					   #arguments.fixture_away_id#,
					   #arguments.fixture_match_number#,
				   	   #variables.fixture_referee_id#,
				   	   '#arguments.leagueCode#',
					   #variables.KORoundID#,
					   #variables.asstref1_id#,
					   #variables.asstref2_id#,
					   #variables.fourth_official_id#,
					   #variables.assessor_id#,
					   '#arguments.fixture_date#',
					   '#arguments.fixture_notes#')
			</cfquery>
			<cfset fixture_id = insertResult.generated_key>

			<cfcatch type = "Database">
			    <!--- the message to display --->
    		    <h3>You've Thrown a Database <b>Error</b></h3>
        		<cfoutput>
		            <!--- and the diagnostic message from the ColdFusion server --->
		            <p>#cfcatch.message#</p>
		            <p>Caught an exception, type = #CFCATCH.TYPE# </p>
		            <p>The contents of the tag stack are:</p>
		            <cfloop index = i from = 1
		                    to = #ArrayLen(CFCATCH.TAGCONTEXT)#>
		                <cfset sCurrent = #CFCATCH.TAGCONTEXT[i]#>
		                <br>#i# #sCurrent["ID"]#
		                    (#sCurrent["LINE"]#,#sCurrent["COLUMN"]#)
		                    #sCurrent["TEMPLATE"]#
		            </cfloop>
		        </cfoutput>
				<cfset var fixture_id = 0>
				<cfabort>
			</cfcatch>
		</cftry>
		<cfreturn fixture_id>
	</cffunction>
--->

	<cffunction name="_methodVerifyUser" access="public">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfset variables.userpermitted = 0>
	</cffunction>

</cfcomponent>
