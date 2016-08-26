<!--- New February 2003. At the request of Brian King from the Hellenic League. Send an email of the fixtures and results by email --->

<cfset FixturesAndResultsText = "">
<cfset SubjectString ="Fixtures and Results for #QTeam.Name#" & " " & "#QTeam.Ord#">

<cfoutput query="QFixtures">
<cfif Result IS "T" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
<!--- ignore TEMP fixture --->
<cfelse>


<cfset FixturesAndResultsText = "#FixturesAndResultsText##CHR(10)#">
<cfset DateStr = DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")>
<cfset DateStr = LJustify(DateStr, 30)>
<cfset FixturesAndResultsText = "#FixturesAndResultsText##DateStr#">
<cfset CompRound = "#CompetitionName# #RoundName#">
<cfset CompRound = LJustify(CompRound, 60)>
<cfset FixturesAndResultsText = "#FixturesAndResultsText##CHR(9)##CompRound##CHR(9)#">

<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
	<cfset FixturesAndResultsText = "#FixturesAndResultsText# ">
<cfelse>

		<cfif ListFind( #ChosenConstits#, HomeID ) GT "0" >
			<cfif IsNumeric(#HomeGoals#) >
				<cfif IsNumeric(#AwayGoals#) >
					<cfif HomeGoals GT AwayGoals >
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#W">
					<cfelseif AwayGoals GT HomeGoals >
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#L">
					<cfelse>
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#D">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfif ListFind( #ChosenConstits#, AwayID ) GT "0" >
			<cfif IsNumeric(#HomeGoals#) >
				<cfif IsNumeric(#AwayGoals#) >
					<cfif HomeGoals GT AwayGoals >
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#L">
					<cfelseif AwayGoals GT HomeGoals >
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#W">
					<cfelse>
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#D">
					</cfif>
				</cfif>
			</cfif>
		</cfif>

		<cfif ListFind( #ChosenConstits#, HomeID ) GT "0" >
			<cfif NOT IsNumeric(#HomeGoals#) >
				<cfif NOT IsNumeric(#AwayGoals#) >
					<CFSWITCH expression="#Result#">
						<CFCASE VALUE="H">
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#W">
						</CFCASE>
						<CFCASE VALUE="A">
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#L">
						</CFCASE>
						<CFCASE VALUE="D">
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#D">
						</CFCASE>
						<CFDEFAULTCASE>
						<cfset FixturesAndResultsText = "#FixturesAndResultsText# ">
						</CFDEFAULTCASE>
					</CFSWITCH>
				</cfif>
			</cfif>
		</cfif>
		<cfif ListFind( #ChosenConstits#, AwayID ) GT "0" >
			<cfif NOT IsNumeric(#HomeGoals#) >
				<cfif NOT IsNumeric(#AwayGoals#) >
					<CFSWITCH expression="#Result#">
						<CFCASE VALUE="H">
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#L">
						</CFCASE>
						<CFCASE VALUE="A">
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#W">
						</CFCASE>
						<CFCASE VALUE="D">
						<cfset FixturesAndResultsText = "#FixturesAndResultsText#D">
						</CFCASE>
						<CFDEFAULTCASE>
						<cfset FixturesAndResultsText = "#FixturesAndResultsText# ">
						</CFDEFAULTCASE>
					</CFSWITCH>
				</cfif>
			</cfif>
		</cfif>
</cfif>


<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
<cfelse>
		<cfset FixturesAndResultsText = "#FixturesAndResultsText##CHR(9)#">
		
			<cfif HomeGoals IS "">
				<cfset HGoals = " ">
			<cfelse>
				<cfset HGoals = #HomeGoals#>
			</cfif>
			<cfif AwayGoals IS "">
				<cfset AGoals = " ">
			<cfelse>
				<cfset AGoals = #AwayGoals#>
			</cfif>

		<cfset FixturesAndResultsText = "#FixturesAndResultsText##HGoals# - #AGoals##CHR(9)#">
</cfif>

		<cfset FixturesAndResultsText = "#FixturesAndResultsText##HomeTeam# #HomeOrdinal#">
			<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0>
				<cfset FixturesAndResultsText = "#FixturesAndResultsText#(#NumberFormat(HomePointsAdjust,"+9")#">
			
				<cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>
					<cfset eee = "point">
				<cfelse>
					<cfset eee = "points">
				</cfif>
			
				<cfset FixturesAndResultsText = "#FixturesAndResultsText# #eee#)">
			
			</cfif>						
		<cfset FixturesAndResultsText = "#FixturesAndResultsText# v #AwayTeam# #AwayOrdinal#">
			<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0>
				<cfset FixturesAndResultsText = "#FixturesAndResultsText#(#NumberFormat(AwayPointsAdjust,"+9")#">
			
				<cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>
					<cfset eee = "point">
				<cfelse>
					<cfset eee = "points">
				</cfif>
			
				<cfset FixturesAndResultsText = "#FixturesAndResultsText# #eee#)">
			
			</cfif>						

			<cfif Result IS "H" AND HideScore IS "No">    <cfset FixturesAndResultsText = "#FixturesAndResultsText# [ Home Win was awarded ]">
			<cfelseif Result IS "A" AND HideScore IS "No"><cfset FixturesAndResultsText = "#FixturesAndResultsText# [ Away Win was awarded ]">
			<cfelseif Result IS "U" AND HideScore IS "No"><cfset FixturesAndResultsText = "#FixturesAndResultsText# [ Home Win on penalties ]">
			<cfelseif Result IS "V" AND HideScore IS "No"><cfset FixturesAndResultsText = "#FixturesAndResultsText# [ Away Win on penalties ]">						
			<cfelseif Result IS "D" AND HideScore IS "No"><cfset FixturesAndResultsText = "#FixturesAndResultsText# [ Draw was awarded ]">
			<cfelseif Result IS "P" ><cfset FixturesAndResultsText = "#FixturesAndResultsText# [ Postponed ]">		
			<cfelseif Result IS "Q" ><cfset FixturesAndResultsText = "#FixturesAndResultsText# [ Abandoned ]">		
			<cfelseif Result IS "W" ><cfset FixturesAndResultsText = "#FixturesAndResultsText# [ Void ]">
			<cfelseif Result IS "T" ><cfset FixturesAndResultsText = "#FixturesAndResultsText# [ TEMP ]">		
			<cfelse>
			</cfif> 
			<cfset ThisDate = DateFormat(QFixtures.FixtureDate, 'YYYY-MM-DD') >
			
			
			
			<!--- Hide the fixture if the Event Text says so --->
			<cfinclude template="queries/qry_QEventText.cfm">
			<cfif QEventText.RecordCount IS 1>
				<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
					<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
						<cfset FixturesAndResultsText = "#FixturesAndResultsText# [HIDDEN FROM PUBLIC]">
					<cfelse>
						<cfset FixturesAndResultsText = "#DateStr# - fixture hidden">
					</cfif>
				</cfif>
			</cfif>
</cfif>			
</cfoutput>

	<table width="100%">
		<tr>
			<td colspan="7" align="CENTER" bgcolor="Aqua">
				<cfoutput>
					<cfif Len(Trim(request.EmailAddr)) IS 0 >
						<span class="pix10">
						Please click 
						<a href="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#"><strong>here</strong></a> 
						to receive an email of these Fixtures and Results.
						</span>
					<cfelse>
						<span class="pix10">
						An email of these Fixtures and Results has been sent to <strong>#request.EmailAddr#</strong><BR>
						Please click <a href="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#"><strong>here</strong></a> 
						to change the email address or to turn off automatic emails.
						</span>
					</cfif>
				</cfoutput>
				

				<cfif StructKeyExists(request, "EmailAddr") AND Len(request.EmailAddr) GT 0 >
					<cfinclude template="inclInsrtEmailAddr.cfm">
					<cfmail to="#request.EmailAddr#" from="#request.EmailAddr#" subject="#SubjectString#" type="text">#FixturesAndResultsText#
						
						
						
						
						#CHR(10)#*** Please Note ***#CHR(10)#For the columns to line up properly you must view this table in a FIXED WIDTH FONT e.g. Courier New
					</cfmail>
				</cfif>

				
			</td>
		</tr>
	</table>