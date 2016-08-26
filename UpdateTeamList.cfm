<cfoutput>
<cfset ZeroOwnGoalSelected = "No">
<cfset NonPlayingSubstituteHasScored = "No">
<cfset NonPlayingSubstituteStarPlayer = "No">
<cfset PassedValidation = "Yes">
<cfset TotalGoalsScored = 0 >
<cfset StartedCount = 0 >
<cfset SubPlayedCount = 0 >
<cfset SubNotPlayedCount = 0 >
<cfset StarPlayerCount = 0 >
<cfloop index="I" from="1" to="#PlayersWhoPlayedCount#" step="1" >
	<cfif StructKeyExists(form, "pp#I#")> <!--- Players Who Played Selected  --->
		<cfif ListGetAt(UpperRegNoList, I) IS 0> <!--- Own Goal --->
			<cfif Evaluate("gg#I#") IS 0 OR Evaluate("gg#I#") IS "" >
				<cfset ZeroOwnGoalSelected = "Yes">
			</cfif>
		<cfelse>
			<cfset ThisActv = Evaluate("activ#I#")>
			<cfif ThisActv IS 1>
				<cfset StartedCount = StartedCount + 1 >
				<cfif StructKeyExists(form, "ss#I#") >
					<cfset StarPlayerCount = StarPlayerCount + 1 >
				</cfif>
			<cfelseif ThisActv IS 2>
				<cfset SubPlayedCount = SubPlayedCount + 1 >
				<cfif StructKeyExists(form, "ss#I#") >
					<cfset StarPlayerCount = StarPlayerCount + 1 >
				</cfif>
			<cfelseif ThisActv IS 3>
				<cfset SubNotPlayedCount = SubNotPlayedCount + 1 >
				<cfif Evaluate("gg#I#") GT 0 >
					<cfset NonPlayingSubstituteHasScored = "Yes">
				</cfif>
				<cfif StructKeyExists(form, "ss#I#") >
					<cfset NonPlayingSubstituteStarPlayer = "Yes">
				</cfif>
			<cfelse>
				ERROR 39 in UpdateTeamList.cfm
				<cfabort>
			</cfif>
		</cfif>
		<!--- Goals --->
		<cfset GoalsScored = Evaluate("gg#I#")>
		<cfif GoalsScored IS "">
			<cfset GoalsScored = "0">
		</cfif>
		<cfset TotalGoalsScored = TotalGoalsScored + GoalsScored >
	</cfif>
</cfloop>

<cfloop index="I" from="1" to="#PlayersWhoDidNotPlayCount#" step="1" >
	<cfif StructKeyExists(form, "P#I#")> <!--- Players Who Did Not Play Selected  --->
		<cfif ListGetAt(LowerRegNoList, I) IS 0> <!--- Own Goal --->
			<cfif Evaluate("G#I#") IS 0 OR Evaluate("G#I#") IS "" >
				<cfset ZeroOwnGoalSelected = "Yes">
			</cfif>
		<cfelse>
			<cfset ThisActv = Evaluate("actv#I#")>
			<cfif ThisActv IS 1>
				<cfset StartedCount = StartedCount + 1 >
				<cfif StructKeyExists(form, "S#I#") >
					<cfset StarPlayerCount = StarPlayerCount + 1 >
				</cfif>
			<cfelseif ThisActv IS 2>
				<cfset SubPlayedCount = SubPlayedCount + 1 >
				<cfif StructKeyExists(form, "S#I#") >
					<cfset StarPlayerCount = StarPlayerCount + 1 >
				</cfif>
			<cfelseif ThisActv IS 3>
				<cfset SubNotPlayedCount = SubNotPlayedCount + 1 >
				<cfif Evaluate("G#I#") GT 0 >
					<cfset NonPlayingSubstituteHasScored = "Yes">
				</cfif>
				<cfif StructKeyExists(form, "S#I#") >
					<cfset NonPlayingSubstituteStarPlayer = "Yes">
				</cfif>
			<cfelse>
				ERROR 339 in UpdateTeamList.cfm
				<cfabort>
			</cfif>
		</cfif>
		<!--- Goals --->
		<cfset GoalsScored = Evaluate("G#I#")>
		<cfif GoalsScored IS "">
			<cfset GoalsScored = "0">
		</cfif>
		<cfset TotalGoalsScored = TotalGoalsScored + GoalsScored >
	</cfif>
</cfloop>

<!---
*********************
* Validation Checks *
*********************
--->

<!--- Referee Mark Must Be Entered ? --->
<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfif HA IS "H">
		<cfif request.RefereeMarkMustBeEntered IS 1 AND Trim(Form.RefereeMarksH) IS "">
			<cfset PassedValidation = "No">
			<span class="pix18boldred">ERROR: You must enter the marks for the referee. 
			<br>Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
		</cfif>
	<cfelseif HA IS "A">
		<cfif request.RefereeMarkMustBeEntered IS 1 AND Trim(Form.RefereeMarksA) IS "">
			<cfset PassedValidation = "No">
			<span class="pix18boldred">ERROR: You must enter the marks for the referee. 
			<br>Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
		</cfif>
	<cfelse>
		ERROR 452 in UpdateTeamList.cfm <cfabort>
	</cfif>
</cfif>

<!--- Too many players started? --->
<cfif (StartedCount GT StartingPlayerCount) AND PassedValidation IS "Yes">
	<cfset PassedValidation = "No">
	<span class="pix18boldred">ERROR: You attempted to put #NumberFormat(StartedCount,'99')# starting players on the team sheet. 
	The maximum allowed is #NumberFormat(StartingPlayerCount,'99')#.<br>Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
</cfif>

<!--- Too many substitutes played? --->
<cfif (SubPlayedCount GT SubsUsedPlayerCount) AND PassedValidation IS "Yes">
	<cfset PassedValidation = "No">
	<span class="pix18boldred">ERROR: You attempted to put #NumberFormat(SubPlayedCount,'99')# playing subs on the team sheet. 
	The maximum allowed is #NumberFormat(SubsUsedPlayerCount,'99')#.<br>Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
</cfif>
<!--- Too many players on team sheet --->
<cfif ((StartedCount + SubPlayedCount + SubNotPlayedCount) GT MaxAllowedOnTeamSheet) AND PassedValidation IS "Yes">
	<cfset PassedValidation = "No">
	<span class="pix18boldred">ERROR: You attempted to put #NumberFormat((StartedCount + SubPlayedCount + SubNotPlayedCount),'99')# players on the team sheet. 
	The maximum allowed is #MaxAllowedOnTeamSheet# (#NumberFormat(StartingPlayerCount,'99')# starting + #NumberFormat(SubsUsedPlayerCount,'99')# substitutes who can play from #NumberFormat(SubsNotUsedPlayerCount+SubsUsedPlayerCount,'99')# named substitutes).
	<br>Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
</cfif>
<!--- Too many goals --->
<cfif (HA IS "H") AND (PassedValidation IS "Yes") >
	<cfif StructKeyExists(form, "HGoals") AND TotalGoalsScored GT HGoals  >
		<cfset PassedValidation = "No">
		<span class="pix18boldred">ERROR: You attempted to put #NumberFormat(TotalGoalsScored,'99')# goals on the team sheet. 
		The maximum allowed is #NumberFormat(HGoals,'99')#.<br>Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
	</cfif>
</cfif>
<cfif (HA IS "A") AND (PassedValidation IS "Yes") >
	<cfif StructKeyExists(form, "AGoals") AND TotalGoalsScored GT AGoals  >
		<cfset PassedValidation = "No">
		<span class="pix18boldred">ERROR: You attempted to put #NumberFormat(TotalGoalsScored,'99')# goals on the team sheet. 
		The maximum allowed is #NumberFormat(AGoals,'99')#.<br>Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
	</cfif>
</cfif>
<!--- Non Playing Substitute has scored --->
<cfif (NonPlayingSubstituteHasScored IS "Yes") AND (PassedValidation IS "Yes") >
	<cfset PassedValidation = "No">
	<span class="pix18boldred">ERROR: You attempted to enter goal(s) for a non playing substitute.<br> 
	Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
</cfif>
<!--- Too many Star Players --->
<cfif (StarPlayerCount GT 1) AND (PassedValidation IS "Yes") >
	<cfset PassedValidation = "No">
	<span class="pix18boldred">ERROR: You attempted to put #NumberFormat(StarPlayerCount,'99')# Star Players on the team sheet.
	The maximum allowed is 1.<br>Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
</cfif>
<!--- Non Playing Substitute is the Star Player --->
<cfif (NonPlayingSubstituteStarPlayer IS "Yes") AND (PassedValidation IS "Yes") >
	<cfset PassedValidation = "No">
	<span class="pix18boldred">ERROR: You attempted to enter a non playing substitute as the Star Player.<br> 
	Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
</cfif>
<!--- Own Goal selected with zero goals specified --->
<cfif (ZeroOwnGoalSelected IS "Yes") AND (PassedValidation IS "Yes") >
	<cfset PassedValidation = "No">
	<span class="pix18boldred">ERROR: You attempted to enter zero Own Goals.<br> 
	Nothing was changed on the team sheet this time. Please click on the Back button of your browser and try again after correcting the errors.</span>
</cfif>
	
<!---
														*******************
														* Do the Updating *	
														*******************
--->	
	
<cfif PassedValidation IS "Yes">
	<cfloop index="I" from="1" to="#PlayersWhoDidNotPlayCount#" step="1" >
		<cfif StructKeyExists(form, "P#I#")>
			<cfset ActivityVal = "actv#I#">
			<cfset ActivityVal = Evaluate(ActivityVal)>
			
			<cfset GoalsScored = "G#I#">
			<cfset GoalsScored = Evaluate(GoalsScored)>
			<cfif GoalsScored IS "">
				<cfset GoalsScored = "0">
			</cfif>

			<cfif NOT StructKeyExists(form, "yc#I#") AND NOT StructKeyExists(form, "rc#I#") >
				<cfset CardValue = 0 >
			<cfelseif StructKeyExists(form, "yc#I#") AND NOT StructKeyExists(form, "rc#I#") >
				<cfset CardValue = 1 >
			<cfelseif NOT StructKeyExists(form, "yc#I#") AND StructKeyExists(form, "rc#I#") >
				<cfset CardValue = 3 >
			<cfelse>
				<cfset CardValue = 4 >
			</cfif>

			<cfset PID = "PID#I#">
			<cfset PID = Evaluate(PID)>

			<!--- Star Player --->
			<cfif StructKeyExists(form, "S#I#")>
				<cfset StarPlayer = 1 >
			<cfelse>
				<cfset StarPlayer = 0 >
			</cfif>
			<cfinclude template = "queries/ins_TeamList.cfm">
		</cfif>
	</cfloop>
	<cfloop index="J" from="1" to="#PlayersWhoPlayedCount#" step="1" >
		<cfif NOT StructKeyExists(form, "pp#J#")>
			<cfset PID = "ppid#J#">
			<cfset PID = Evaluate(PID)>
			<cfinclude template = "queries/del_DelAppFromTeamList.cfm">
		<cfelse>

			<cfset ActivityValue = "activ#J#">
			<cfset ActivityValue = Evaluate(ActivityValue)>

			<cfset GoalsScored = "gg#J#">
			<cfset GoalsScored = Evaluate(GoalsScored)>
			<cfif GoalsScored IS "">
				<cfset GoalsScored = "0">
			</cfif>
			<!--- no yellow card and no red card --->
			<cfif NOT StructKeyExists(form, "yy#J#") AND NOT StructKeyExists(form, "rr#J#") >
				<cfset CardValue = 0 >
			<!--- yellow card only --->
			<cfelseif StructKeyExists(form, "yy#J#")  AND NOT StructKeyExists(form, "rr#J#") >
				<cfset CardValue = 1 >
			<!--- red card only --->
			<cfelseif NOT StructKeyExists(form, "yy#J#")  AND StructKeyExists(form, "rr#J#") >
				<cfset CardValue = 3 >
			<!--- yellow card plus a red card --->
			<cfelse>
				<cfset CardValue = 4 >
			</cfif>
			<cfset PID = "ppid#J#">
			<cfset PID = Evaluate(PID)>
			<!--- Star Player --->
			<cfif StructKeyExists(form, "ss#J#")>
				<cfset StarPlayer = 1 >
			<cfelse>
				<cfset StarPlayer = 0 >
			</cfif>
			<cfinclude template = "queries/upd_UpdtAppFromTeamList.cfm">
		</cfif>
	</cfloop>
</cfif>	

</cfoutput>
