<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##url.TeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfparam name="startx" default=1>
<!--- <cfinclude template="queries/qry_QTeamDiscipAnalysis.cfm"> --->
<table align="center">
	<tr>
		<td valign="top">
			<cfif StructKeyExists(url, "TeamID")>
				<cfinclude template="queries/qry_QTeamDiscipAnalysis.cfm">
				<cfset Maxx = #QTeamDiscipAnalysis.RecordCount#>
				<cfset PlayerIDList = ValueList(QTeamDiscipAnalysis.PID)>
				<cfset PointsList = ValueList(QTeamDiscipAnalysis.Points)>
				<cfset GamesAppearedList = ValueList(QTeamDiscipAnalysis.GamesAppeared)>
				<cfset TotalPoints = 0 >			
				<cfloop index = "zzz" list = "#PointsList#" > 
					<cfset TotalPoints = TotalPoints + #zzz# > 
				</cfloop>				
				<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
					<tr>
						<cfoutput>
						<td colspan="4" align="center">
						<span class="pix13bold">#QTeamDiscipAnalysis.TeamName#<br></span>
						<span class="pix10bold">Total = #TotalPoints# discip. points<br></span>
						<span class="pix9">yellow=1, red=3, orange=4</span>
						</td>
						</cfoutput>
					</tr>
				
					<tr>
						<td><span class="pix10">&nbsp;</span></td>
						<td align="center"><span class="pix10bold">Player<BR>No.</span></td>
						<td align="left"><span class="pix10"><strong>Surname</strong> Forenames</span></td>
						<td align="center"><span class="pix10bold">Appearances</span></td>
					</tr>
					<cfloop index="x" from="#startx#" to="#Maxx#" step="1" >
						<cfinclude template="queries/qry_QTeamDiscipCardHist.cfm">
						<cfoutput query="QTeamDiscipCardHist" group="PlayerID">		
							<tr>
								<td><a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#"><span class="pix10">See Appearances</a></span></td>
								<td align="right"><span class="pix10">#PlayerNo#</span></td>
								<td align="left"><span class="pix10"><strong>#PlayerSurname#</strong> #PlayerForename#</span></td>
								<td align="center"><span class="pix10">#ListGetAt(GamesAppearedList,x)#</span></td>
								<cfoutput>
									<cfif CardType IS "Yellow">
										<td bgcolor="Yellow"><span class="pix10black"><strong>Y</strong></span></td>
									<cfelseif CardType IS "Red">
										<td bgcolor="Red"><span class="pix10white"><strong>R</strong></span></td>
									<cfelseif CardType IS "Orange">
										<td bgcolor="Orange"><span class="pix10black"><strong>4</strong></span></td>
									</cfif>
								</cfoutput>
							</tr>
						</cfoutput>
					</cfloop>
				</table>
			</cfif>
		</td>
	</tr>
</table>
