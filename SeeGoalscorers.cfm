<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsilent>

<cflock scope="session" timeout="10" type="readonly">
	<cfif StructKeyExists(session, "GoalsScored") 
		AND StructKeyExists(session, "GoalsScoredLeague") 
		AND session.CurrentLeagueCode EQ session.GoalsScoredLeague>
		<cfset request.arrayExists = 1>
	<cfelse>
		<cfset StructDelete(session, "GoalsScored")>
		<cfset StructDelete(session, "GoalsScoredLeague")>
		<cfset request.arrayExists = 0>
	</cfif>
</cflock>

<cflock scope="session" timeout="10" type="readonly">
	<cfset request.fmPlayerID = session.fmPlayerID >
</cflock>
	
<cfparam name="startx" default=1>

<cfif StructKeyExists(url, "Refresh")>
	<cfset StructDelete(session, "GoalsScored")>
	<cfset StructDelete(session, "GoalsScoredLeague")>
	<cfset request.arrayExists = 0>
</cfif>

<cfif request.arrayExists EQ 1 >
	<cfset Maxx = ArrayLen(session.GoalsScored)>
<cfelse>
	<cfinclude template = "queries/qry_QSeeGoalScorers1.cfm">
	<cfset Maxx = QGoalsScored.RecordCount>
	<cflock scope="session" type="exclusive" timeout="10">
		<cfset session.GoalsScored = ArrayNew(1)>
		<cfset session.GoalsScoredLeague = LeagueCode>
		<cfloop query="QGoalsScored">
			<cfset session.GoalsScored[CurrentRow][1] = PlayerID>
			<cfif LastAppearedFor IS NOT CurrentlyRegisteredTo>
				<cfif CurrentlyRegisteredTo IS ''>
					<cfset session.GoalsScored[CurrentRow][2] = "#LastAppearedFor# (currently unregistered)" >
				<cfelse>
					<cfset session.GoalsScored[CurrentRow][2] = "#LastAppearedFor# (currently with #CurrentlyRegisteredTo#)" >
				</cfif>
			<cfelse>
				<cfset session.GoalsScored[CurrentRow][2] = "#LastAppearedFor#" >
			</cfif>
			<cfset session.GoalsScored[CurrentRow][3] = Surname>
			<cfset session.GoalsScored[CurrentRow][4] = Forename>
			<cfset session.GoalsScored[CurrentRow][5] = GamesPlayed>
			<cfset session.GoalsScored[CurrentRow][6] = Goals>
			<cfset session.GoalsScored[CurrentRow][7] = Apps1>				
			<cfset session.GoalsScored[CurrentRow][8] = Apps2>				
			<cfset session.GoalsScored[CurrentRow][9] = Apps3>				
							
		</cfloop>
	</cflock>
</cfif>

<cfset screenful = 39>
<cfif startx + screenful GT Maxx>
	<cfset endx = Maxx>
<cfelse>
	<cfset endx = startx + screenful>
</cfif>

</cfsilent>

<BR>

<table border="1" cellspacing="1" cellpadding="3" align="CENTER" class="loggedinScreen">
	<tr>
		<td><span class="pix10">&nbsp;</span></td>
		<td align="CENTER"><span class="pix10bold">Last Appeared For</span></td>
		<td><span class="pix10"><strong>Surname</strong> Forenames</span></td>
		<td align="center" bgcolor="white"><span class="pix10bold">Goals</span></td>
		<td align="CENTER"><span class="pix10bold">Games<BR>Played</span></td>
		<td align="CENTER"><span class="pix10bold">Started</span></td>
		<td align="center" bgcolor="silver"><span class="pix10bold">Sub<br>Y</span></td>
		<td align="center" bgcolor="white"><span class="pix10bold">Sub<br>N</span></td>
	</tr>
	<cflock scope="session" type="readonly" timeout="10">
	<cfoutput>
		<cfloop index="i" from="#startx#" to="#endx#">
			<cfset Highlight = "No">
			<cfif request.fmPlayerID IS #session.GoalsScored[i][1]#>
				<cfset Highlight = "Yes">
			</cfif>
			<tr>
				<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10"><a href="PlayersHistory.cfm?PI=#session.GoalsScored[i][1]#&LeagueCode=#LeagueCode#">See Appearances</a></span></td>
				<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10">#session.GoalsScored[i][2]#</span></td>
				<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10"><strong>#session.GoalsScored[i][3]#</strong> #session.GoalsScored[i][4]#</span></td>
				<td bgcolor="white" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10">#session.GoalsScored[i][6]#</span></td>
				<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10">#session.GoalsScored[i][5]#</span></td>
				<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10"><cfif session.GoalsScored[i][7] IS 0>&nbsp;<cfelse>#session.GoalsScored[i][7]#</cfif></span></td>
				<td bgcolor="silver" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10"><cfif session.GoalsScored[i][8] IS 0>&nbsp;<cfelse>#session.GoalsScored[i][8]#</cfif></span></td>
				<td bgcolor="white" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10"><cfif session.GoalsScored[i][9] IS 0>&nbsp;<cfelse>#session.GoalsScored[i][9]#</cfif></span></td>
			</tr>
			<cfset startx = startx+1>
		</cfloop>
	</cfoutput>
	</cflock>
	<cfif startx LT Maxx>
		<tr>
			<td height="30" colspan="8">
				<cfoutput>
				<a href="SeeGoalscorers.cfm?LeagueCode=#LeagueCode#&startx=#startx#"><span class="pix13bold">More...</span></a>
				</cfoutput>
			</td>
		</tr>
	</cfif>
	<tr>
			<td height="30" colspan="8" align="right">
			<cfoutput>
			<a href="SeeGoalscorers.cfm?LeagueCode=#LeagueCode#&Refresh=Y"><span class="pix13bold">Refresh Table</span></a>
			</cfoutput>
		</td>
	</tr>
</table>
