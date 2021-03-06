<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif NOT StructKeyExists(url, "TeamID") >
	<cfinclude template="queries/qry_QClubAnalysis.cfm">
<cfelse>
	<cfinclude template="queries/qry_QClubName.cfm">
</cfif>
<table align="CENTER">
	<tr>
		<td valign="TOP">
			<cfif NOT StructKeyExists(url, "TeamID") >
				<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
					<tr>
						<td align="CENTER"><span class="pix10bold">Club</span></td>
						<td align="CENTER"><span class="pix10bold">Player<BR>Appearances</span></td>
					</tr>
					<cfoutput query="QClubAnalysis">
						<tr>
							<td align="LEFT"><span class="pix10"><a href="AppearanceAnalysis.cfm?LeagueCode=#LeagueCode#&TeamID=#TID#">#ClubName#</a></span></td>
							<td align="CENTER"><span class="pix10">#Appearances#</span></td>
						</tr>
					 </cfoutput>
				</table>
			</cfif>
		</td>
		<td valign="TOP">
			<cfif StructKeyExists(url, "TeamID") >
				<cfinclude template="queries/qry_QAppAnalysis.cfm">
				<cfset Maxx = #QAppAnalysis.RecordCount#>
				<cfset ConstitIDList = ValueList(QAppAnalysis.ConstitID)>
				<cfset CompetitionCodeList = ValueList(QAppAnalysis.CompetitionCode)>
				<cfset OrdinalNameList = QuotedValueList(QAppAnalysis.OrdinalName)>
				<cfinclude template="queries/qry_QAppearances.cfm">
				<cfset Maxy = #QAppearances.RecordCount#>
				<cfset PlayerIDList = ValueList(QAppearances.PlayerID)>
				<cfset PlayerNameList = ValueList(QAppearances.PlayerName)>
				<cfset PlayerSurnameList = ValueList(QAppearances.PlayerSurname)>
				<cfset PlayerForenameList = ValueList(QAppearances.PlayerForename)> <!--- qry_QAppearances.cfm puts dash in place of blank forename --->
				<cfset PlayerNoList = ValueList(QAppearances.PlayerNo)>			
				<cfset AppsList = ValueList(QAppearances.Apps)>
				<cfset GoalsList = ValueList(QAppearances.Goals)>
				<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
					<cfoutput>
					<cfset colspan = Maxx + 5>
					<tr>
						<td colspan="#colspan#" align="CENTER">
							<span class="pix16bold">#QClubName.ClubName#</span>
						</td>
					</tr>
					<tr>
						<td align="CENTER"><span class="pix10bold">Player<BR>No.</span></td>
						<td><span class="pix10bold">Surname</span><span class="pix10"> Forenames</span></td>
						<td align="CENTER"><span class="pix10">&nbsp;</span></td>						
						<td align="CENTER"><span class="pix10bold">Goals</span></td>
						<td align="CENTER"><span class="pix10bold">Games</span></td>
						<cfloop index="x" from="1" to="#Maxx#" step="1" >
							<cfif #ListGetAt(OrdinalNameList,x)# IS "''">
								<cfset TeamName = "1st Team">
							<cfelse>
								<cfset TeamName = ListGetAt(OrdinalNameList,x)>
								<cfset TeamName = Replace(TeamName, "'", "", "ALL")>
							</cfif>
							<td align="CENTER"><span class="pix10bold">#TeamName#<BR>#ListGetAt(CompetitionCodeList,x)#</span></td>
						</cfloop>
					</tr>
					<cfloop index="y" from="1" to="#Maxy#" step="1" >
						<tr>
							<td align="RIGHT"><span class="pix10">#ListGetAt(PlayerNoList,y)#</span></td>
							<cfset PlayerSurname = #ListGetAt(PlayerSurnameList,y)#>
							<cfset PlayerForename = #ListGetAt(PlayerForenameList,y)#>
							<td><span class="pix10bold">#PlayerSurname#</span> <span class="pix10">#PlayerForename#</span></td>
							<td align="CENTER"><span class="pix10"><a href="PlayersHist.cfm?PI=#ListGetAt(PlayerIDList,y)#&LeagueCode=#LeagueCode#">see</a></span></td>
							<td align="CENTER"><span class="pix10"><cfif ListGetAt(GoalsList,y) GT 0>#NumberFormat(ListGetAt(GoalsList,y))#<cfelse>&nbsp;</cfif></span></td>
							<td align="CENTER"><span class="pix10">#ListGetAt(AppsList,y)#</span></td>
							<cfloop index="x" from="1" to="#Maxx#" step="1" >
								<cfinclude template="queries/qry_QApps.cfm">
								<td align="CENTER"><span class="pix10"><cfif QApps.AppCount GT 0>#QApps.AppCount#<cfelse>&nbsp;</cfif></span></td>
							</cfloop>
							<cfinclude template="queries/qry_QTransf.cfm">
							<cfif QTransf.RecordCount GT 0>
								<cfif #ListGetAt(PlayerNoList,y)# GT 0>
									<td align="CENTER" bgcolor="Silver"><span class="pix10">#QTransf.RecordCount# for another club or competition</span></td>
								</cfif>
							</cfif>
							<cfinclude template="queries/qry_QTeamID.cfm">
							<cfif QTeamID.TName IS "">
								<cfif #ListGetAt(PlayerNoList,y)# GT 0>
									<td align="CENTER"><span class="pix10bold">NOT REGISTERED</span></td>
								</cfif>
							</cfif>
						</tr>
					</cfloop>
					</cfoutput>
				</table>
			</cfif>
		</td>
	</tr>
</table>
