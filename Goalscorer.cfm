<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">

<cfinclude template="InclBegin.cfm">
<cfparam name="startx" default=1>
<cfinclude template="queries/qry_QGoalscorer.cfm">
<cfset Maxx = #QGoalscorer.RecordCount#>
<cfset PlayerIDList = ValueList(QGoalscorer.PlayerID)>
<cfset PlayerNoList = ValueList(QGoalscorer.PlayerNo)>
<cfset SurnameList = ValueList(QGoalscorer.Surname)>
<cfset ForenameList = ValueList(QGoalscorer.Forename)>
<cfset GamesPlayedList = ValueList(QGoalscorer.GamesPlayed)>
<cfset GoalsList = ValueList(QGoalscorer.Goals)>

<cflock scope="session" timeout="10" type="readonly">
	<cfset request.fmPlayerID = session.fmPlayerID >
</cflock>

<BR>
<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
<cfoutput>
	<tr>
		<td><span class="pix10">&nbsp;</span></td>
		<td><span class="pix10">&nbsp;</span></td>
		<td align="CENTER"><span class="pix10bold">Player<BR>No.</span></td>
		<td><span class="pix10"><strong>Surname</strong> Forenames</span></td>
		<td align="CENTER"><span class="pix10bold">Games<BR>Played</span></td>
		<td align="CENTER"><span class="pix10bold">Goals</span></td>
	</tr>
	<cfloop index="x" from="#startx#" to="#Maxx#" step="1" >
		<cfset Highlight = "No">
		<cfif request.fmPlayerID IS #ListGetAt(PlayerIDList,x)#>
			<cfset Highlight = "Yes">
		</cfif>
		<tr>
			<cfset Surname = ListGetAt(SurnameList,x)>
			<cfset Forename = ListGetAt(ForenameList,x)>
			<td align="right"><span class="pix10">#x#</span></td>
			<td <cfif Highlight>class="bg_highlight"</cfif>><a href="PlayersHist.cfm?PI=#ListGetAt(PlayerIDList,x)#&LeagueCode=#LeagueCode#"><span class="pix10">See Appearances</span></a></td>
			<td align="RIGHT" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10">#ListGetAt(PlayerNoList,x)#</span></td>
			<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10"><strong>#Surname#</strong> #Forename#</span></td>
			<td align="CENTER" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10">#ListGetAt(GamesPlayedList,x)#</span></td>
			<td align="CENTER" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10">#NumberFormat(ListGetAt(GoalsList,x), '999')#</span></td>
		</tr>
		<cfif x LT maxx>
			<cfif x GT (#startx# + 98) >
			
			</table>
			<table width="100%">
				<tr>
					<td align="CENTER">
						<cfset startx = x + 1>
						<a href="Goalscorer.cfm?LeagueCode=#LeagueCode#&startx=#startx#"><span class="pix13bold">More...</span></a>
						<CFBREAK>
					</td>
				</tr>
			</table>
			</cfif>
		</cfif>
	</cfloop>
</cfoutput>
</table>
