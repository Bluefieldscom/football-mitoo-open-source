<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset ErrorText = "">
<cfset UpdtCount = 0>
<cfset DltdCount = 0>
<cfset RefMarksUpdtCount = 0>
<cfset ThisDivisionID = 0 >
<cfoutput>
	
	<CFLOOP index="I" from="1" to="500" step="1">
		<!--- PerfectLine is a flag ... Posit the line is good.... --->
		<cfset PerfectLine = "Yes" >
		
		<cfset LineString = #Trim(GetToken(Form.BatchInput, I, CHR(10) )) #>
		<!--- e.g.	{MDX01,1,42,08Sep2001} Technicolor CAV  [  ]  [  ]  Harefield United Reserves --->
		
		
		<!--- Check the opening delimiter either a curly brace "{" or a less-than "<"   
		The first delimiter will determine what type of batch it is. You can mix "Scores" and "RefMarks" batches!!! --->

		<cfif PerfectLine IS "Yes">
			<cfif Left(LineString,1) IS "{" >
				<cfset BatchType = "Scores">
				<cfset ErrorText = "#ErrorText##LineString#<BR>">
			<cfelseif Left(LineString,1) IS "<" >
				<cfset BatchType = "RefMarks">
				<cfset ErrorText = "#ErrorText##LineString#<BR>">
			<cfelse>
				<cfset PerfectLine = "No" >
			</cfif>
		</cfif>
		
		<!--- Check the DivisionID --->
		<cfif PerfectLine IS "Yes">
			<cfset BDivisionID = #GetToken(Linestring, 1, "," )#>
			<cfif BatchType IS "Scores">
				<cfif Left(LineString,1) IS "<" >
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Delimiter error=< <BR><BR></span>'>
				<cfelse>
					<cfset BDivisionID = #Replace(BDivisionID, "{", "", "ALL")#>
				</cfif>
			</cfif>
			<cfif BatchType IS "RefMarks">
				<cfif Left(LineString,1) IS "{" >
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Delimiter error={ <BR><BR></span>'>
				<cfelse>
					<cfset BDivisionID = #Replace(BDivisionID, "<", "", "ALL")#>
				</cfif>
			</cfif>
						
			<cfif IsNumeric(BDivisionID) IS "No" >
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Division ID error: #BDivisionID# <BR><BR></span>'>
			</cfif>
		</cfif>
		
		<!--- Check the FixtureID --->
		<cfif PerfectLine IS "Yes">
			<cfset BFixtureID = #GetToken(Linestring, 2, "," )#>
			<cfif IsNumeric(BFixtureID) IS "No" >
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">FixtureID error: #BFixtureID# <BR><BR></span>'>				
			</cfif>
		</cfif>

		<!--- Check the HomeID --->
		<cfif PerfectLine IS "Yes">
			<cfset BHomeID = #GetToken(Linestring, 3, "," )#>
			<cfif IsNumeric(BHomeID) IS "No" >
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">HomeID error: #BHomeID# <BR><BR></span>'>				
			</cfif>
		</cfif>

		<!--- Check the AwayID --->
		<cfif PerfectLine IS "Yes">
			<cfset BAwayID = #GetToken(Linestring, 4, "," )#>
			<cfif IsNumeric(BAwayID) IS "No" >
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '<span class="pix10boldred">AwayID error: #BAwayID# <BR><BR></span>'>
			</cfif>
		</cfif>

		
		<!--- Check the Date String --->
		<cfif PerfectLine IS "Yes">
			<cfif BatchType IS "Scores">
				<cfset BDateString = #GetToken(Linestring, 1, "}" )#>
			</cfif>
			<cfif BatchType IS "RefMarks">
				<cfset BDateString = #GetToken(Linestring, 1, ">" )#>
			</cfif>
			<cfset BDateString = #Right(BDateString, 11 )#>		
			<cfif IsDate(BDateString) IS "No" >
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Date String error: #BDateString# <BR><BR></span>'>
			<cfelse>
				<cfset BFixtureDate = #ParseDateTime(BDateString)#>
			</cfif>
		</cfif>
		<!--- Check the Home Goals --->
		<cfif PerfectLine IS "Yes">
			<cfif BatchType IS "Scores">
				<cfset HomeGoals = #GetToken(Linestring, 1, "]")#>
				<cfset HomeGoals = #Reverse(HomeGoals)#>
				<cfset HomeGoals = #GetToken(HomeGoals, 1, "[")#>
				<cfset HomeGoals = #Trim(Reverse(HomeGoals))#>
				<cfif UCASE(LTRIM(RTRIM(HomeGoals))) IS "P" >
					<cfset HomeGoals = "P">
				<cfelseif UCASE(LTRIM(RTRIM(HomeGoals))) IS "H" >
					<cfset HomeGoals = "H">
				<cfelseif UCASE(LTRIM(RTRIM(HomeGoals))) IS "A" >
					<cfset HomeGoals = "A">
				<cfelseif IsNumeric(HomeGoals) IS "No" >
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText#  <span class="pix10boldred">HomeGoals error: #HomeGoals#  <BR><BR></span>'>
				<cfelseif HomeGoals GT 99>
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText#  <span class="pix10boldred">HomeGoals error: #HomeGoals#  <BR><BR></span>'>
				</cfif>
			</cfif>
		</cfif>
		
		<!--- Check the Home Team's Referee Marks --->
		<cfif PerfectLine IS "Yes">
			<cfif BatchType IS "RefMarks">
				<cfset RefereeMarksH = #GetToken(Linestring, 1, "]")#>
				<cfset RefereeMarksH = #Reverse(RefereeMarksH)#>
				<cfset RefereeMarksH = #GetToken(RefereeMarksH, 1, "[")#>
				<cfset RefereeMarksH = #Trim(Reverse(RefereeMarksH))#>
				<cfif IsNumeric(RefereeMarksH) IS "No" >
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText#  <span class="pix10boldred">RefereeMarksH error: #RefereeMarksH#  <BR><BR></span>'>
				<cfelseif RefereeMarksH GT 100>
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText#  <span class="pix10boldred">RefereeMarksH error: #RefereeMarksH#  <BR><BR></span>'>
				</cfif>
			</cfif>
		</cfif>
		
		<!--- Check the Away Goals --->
		<cfif PerfectLine IS "Yes">
			<cfif BatchType IS "Scores">
				<cfset AwayGoals = #GetToken(Linestring, 2, "]")#>
				<cfset AwayGoals = #Reverse(AwayGoals)#>
				<cfset AwayGoals = #GetToken(AwayGoals, 1, "[")#>
				<cfset AwayGoals = #Trim(Reverse(AwayGoals))#>
				<cfif HomeGoals IS "P">
					<cfif UCASE(LTRIM(RTRIM(AwayGoals))) IS "P">
						<cfset AwayGoals = "P">
					<cfelse>
						<cfset PerfectLine = "No" >
						<cfset ErrorText = '#ErrorText# <span class="pix10boldred">AwayGoals error: #AwayGoals# <BR><BR></span>'>
					</cfif> 
				<cfelseif HomeGoals IS "H">
					<cfif UCASE(LTRIM(RTRIM(AwayGoals))) IS "H">
						<cfset AwayGoals = "H">
					<cfelse>
						<cfset PerfectLine = "No" >
						<cfset ErrorText = '#ErrorText# <span class="pix10boldred">AwayGoals error: #AwayGoals# <BR><BR></span>'>
					</cfif> 
				<cfelseif HomeGoals IS "A">
					<cfif UCASE(LTRIM(RTRIM(AwayGoals))) IS "A">
						<cfset AwayGoals = "A">
					<cfelse>
						<cfset PerfectLine = "No" >
						<cfset ErrorText = '#ErrorText# <span class="pix10boldred">AwayGoals error: #AwayGoals# <BR><BR></span>'>
					</cfif> 
				<cfelseif IsNumeric(AwayGoals) IS "No" >
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">AwayGoals error: #AwayGoals# <BR><BR></span>'>
				<cfelseif AwayGoals GT 99>
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText#  <span class="pix10boldred">AwayGoals error: #AwayGoals#  <BR><BR></span>'>
				</cfif>
			</cfif>
		</cfif>

		<!--- Check the Away Team's Referee Marks --->
		<cfif PerfectLine IS "Yes">
			<cfif BatchType IS "RefMarks">
				<cfset RefereeMarksA = #GetToken(Linestring, 2, "]")#>
				<cfset RefereeMarksA = #Reverse(RefereeMarksA)#>
				<cfset RefereeMarksA = #GetToken(RefereeMarksA, 1, "[")#>
				<cfset RefereeMarksA = #Trim(Reverse(RefereeMarksA))#>
				<cfif IsNumeric(RefereeMarksA) IS "No" >
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText#  <span class="pix10boldred">RefereeMarksA error: #RefereeMarksA#  <BR><BR></span>'>
				<cfelseif RefereeMarksA GT 100>
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText#  <span class="pix10boldred">RefereeMarksA error: #RefereeMarksA#  <BR><BR></span>'>
				</cfif>
			</cfif>
		</cfif>

		<!--- Check the Attendance --->
		<cfif PerfectLine IS "Yes">
			<cfif BatchType IS "Scores">
				<cfset Attendance = #GetToken(Linestring, 3, "]")#>
				<cfset Attendance = #Reverse(Attendance)#>
				<cfset Attendance = #GetToken(Attendance, 1, "[")#>
				<cfset Attendance = #Reverse(Attendance)#>
				<cfif Len(Trim(Attendance)) GT 0>
					<cfif IsNumeric(Attendance) IS "No" >
						<cfset PerfectLine = "No" >
						<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Attendance error: #Attendance# <BR><BR></span>'>
					<cfelseif Attendance GT 99999>
						<cfset PerfectLine = "No" >
						<cfset ErrorText = '#ErrorText#  <span class="pix10boldred">Attendance error: #Attendance# <BR><BR></span>'>
					</cfif>
				</cfif>
			</cfif>
		</cfif>


		<!---
		This is a batch process which is intended to allow users to enter the results quickly.
		Entry of scores will only be allowed if they are currently empty.
		--->
		<cfif PerfectLine IS "Yes">
			<cfinclude template="queries/qry_QThisFixture.cfm">		
			<cfif QThisFixture.RecordCount IS NOT 1>
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">FixtureCount = #QThisFixture.RecordCount#<BR><BR></span>'>
			</cfif>
		</cfif>

		<!--- Check that Goals and Attendance OR RefereeMarks are empty and also not a TEMP fixture --->
		<cfif PerfectLine IS "Yes">
			<cfif BatchType IS "Scores">
				<cfif #QThisFixture.HomeGoals# IS "" AND #QThisFixture.AwayGoals# IS "" AND #QThisFixture.Result# IS "" AND #QThisFixture.Attendance# IS "">
				<cfelse>
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Result or Attendance previously entered or it is a TEMP hidden fixture<BR><BR></span>'>				
				</cfif>
			</cfif>
			<cfif BatchType IS "RefMarks">
				<cfif #QThisFixture.RefereeMarksH# IS "" AND  #QThisFixture.RefereeMarksA#  IS "" >
				<cfelse>
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Referee Marks previously entered <BR><BR></span>'>				
				</cfif>
			</cfif>
		</cfif>

		<!--- Doublecheck all other key fields are the same --->
		<cfif PerfectLine IS "Yes">
			<cfif QThisFixture.HomeID IS #BHomeID# AND QThisFixture.AwayID IS #BAwayID# AND QThisFixture.FixtureDate IS #BFixtureDate#>
			<cfelse>
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Mismatched keys <BR><BR></span>'>								
			</cfif>
		</cfif>
		
		<cfif PerfectLine IS "Yes">
		
			<cfif BatchType IS "Scores">
				<cfset DivisionID = #BDivisionID#>
				<!--- Delete the rows in LeagueTable table once only for each competition involved --->
				<cfif ThisDivisionID IS DivisionID>
				<cfelse>
					<cfset ThisDivisionID = DivisionID >
				</cfif>
				<cfset HomeID = #QThisFixture.HomeID#>
				<cfset AwayID = #QThisFixture.AwayID#>
				<!--- Do not allow scores for "Winners of Match nnn" team  --->
				<cfinclude template="queries/qry_Q00001.cfm">		
				<cfinclude template="queries/qry_Q00002.cfm">		
				<cfif Q00001.HomeNoScore IS "NoScore" OR Q00002.AwayNoScore IS "NoScore">
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Winners of...Ignored <BR><BR></span>'>								
				<cfelse>
					<cfset Form.HomeGoals = #HomeGoals#>										
					<cfset Form.AwayGoals = #AwayGoals#>
					<cfset Form.Attendance = #Attendance#>
					<cfset id = #QThisFixture.ID#>
					<cfif Form.HomeGoals IS "P" AND Form.AwayGoals IS "P">
						<cfinclude template="queries/upd_PostponedFixt.cfm">
						<cfset ErrorText = '#ErrorText# <span class="pix10boldnavy">Fixture Postponed<BR><BR></span>'>
						<cfset DltdCount = DltdCount + 1>
					<cfelseif Form.HomeGoals IS "H" AND Form.AwayGoals IS "H">
						<cfset Form.Result = "H">
						<cfinclude template="InclUpdtAwardedGame.cfm">
						<cfset ErrorText = '#ErrorText# <span class="pix10boldgreen">Home Win Updated OK <BR><BR></span>'>
						<cfset UpdtCount = UpdtCount + 1>
					<cfelseif Form.HomeGoals IS "A" AND Form.AwayGoals IS "A">
						<cfset Form.Result = "A">
						<cfinclude template="InclUpdtAwardedGame.cfm">
						<cfset ErrorText = '#ErrorText# <span class="pix10boldgreen">Away Win Updated OK <BR><BR></span>'>
						<cfset UpdtCount = UpdtCount + 1>
					<cfelse>
						<cfinclude template="InclUpdtGoals.cfm">
						<cfset ErrorText = '#ErrorText# <span class="pix10boldgreen">Score Updated OK <BR><BR></span>'>
						<cfset UpdtCount = UpdtCount + 1>
					</cfif>															
					<cfinclude template="RefreshLeagueTable.cfm">
				</cfif>
			</cfif>
			
			
			<cfif BatchType IS "RefMarks">
				<cfset HomeID = #QThisFixture.HomeID#>
				<cfset AwayID = #QThisFixture.AwayID#>
				<!--- Do not allow scores for "Winners of Match nnn" team  --->
				<cfinclude template="queries/qry_Q00001.cfm">		
				<cfinclude template="queries/qry_Q00002.cfm">		
				<cfif Q00001.HomeNoScore IS "NoScore" OR Q00002.AwayNoScore IS "NoScore">
					<cfset PerfectLine = "No" >
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Winners of...Ignored <BR><BR></span>'>								
				<cfelse>
					<cfset Form.RefereeMarksH = #RefereeMarksH#>										
					<cfset Form.RefereeMarksA = #RefereeMarksA#>										
					<cfset id = #QThisFixture.ID#>
					<cfinclude template="InclUpdtRefMarks.cfm">
					<cfset ErrorText = '#ErrorText# <span class="pix10boldgreen">Referee Marks Updated OK <BR><BR></span>'>
					<cfset RefMarksUpdtCount = RefMarksUpdtCount + 1>
				</cfif>
			</cfif>
								
		<cfelse>
			<!--- ignore line --->
		</cfif>
	</cfloop>
</cfoutput>	
<cfif PerfectLine IS "Yes">
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.CurrentDate = #BFixtureDate#>
	</cflock>
</cfif>
<!--- added by Terry for push to Goalrun --->
<cfif UpdtCount GT 0>
	<cfif BatchType IS "Scores" AND RIGHT(request.dsn,4) GE 2008> <!--- applies to season 2008 onwards only --->
		<!--- push result to GR for SMS push to users --->
		<cfinclude template="InclPushResultToGR.cfm">
	</cfif>
</cfif>



<cfoutput>
	<span class="pix18bold">Batch Update Report<BR><BR></span>
	<cfif Trim(ErrorText) IS "">
		<span class="pix13">Nothing to report.<BR><BR></span>
	<cfelse>
		<span class="pix13">#ErrorText#<BR><BR></span>
		<cfif BatchType IS "Scores">
			<span class="pix18boldgreen">Update Total #UpdtCount#<BR><BR></span>
			<span class="pix18boldgreen">Deleted Total #DltdCount#<BR><BR></span>
			<span class="pix24boldblue">
			Postpone fixtures with [ P ] [ P ]<BR>
			Award Home Win with [ H ] [ H ]<BR>
			Award Away Win with [ A ] [ A ]<BR>
			<BR></span>
		</cfif>
		<cfif BatchType IS "RefMarks">
			<span class="pix18boldgreen">Update Total #RefMarksUpdtCount#<BR><BR></span>
		</cfif>
		
	</cfif>
	<span class="pix18bold">Please press the "Back" button on your browser to continue.....</span>
</cfoutput>
