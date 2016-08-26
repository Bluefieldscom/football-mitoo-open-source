<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfparam name="startx" default=1>
<cfinclude template="queries/qry_QCardAnalysis.cfm">
<table align="center">
	<tr>
		<td valign="TOP">
			<table border="1" cellspacing="1" cellpadding="3" align="center">
				<tr>
					<td align="center"><span class="pix10bold">Club</span></td>
					<td align="center"><span class="pix10bold">Points</span></td>
					<td align="center" bgcolor="red">   <span class="pix10white"><strong>R</strong></span></td>
					<td align="center" bgcolor="yellow"><span class="pix10black"><strong>Y</strong></span></td>
				</tr>
				<cfoutput query="QCardAnalysis">
					<cfset Highlight = "No">
					<cfif StructKeyExists(url, "TeamID")>					
						<cfif TID IS URL.TeamID>
							<cfset Highlight = "Yes">
						</cfif>
					</cfif>
					<tr>
						<td align="LEFT" <cfif Highlight>class="bg_highlight"</cfif> >
						<a href="CardAnalysis.cfm?LeagueCode=#LeagueCode#&TeamID=#TID#"><cfif Highlight><span class="pix10bold">#ClubName#</span><cfelse><span class="pix10">#ClubName#</span></cfif></a></td>
						<td align="center" <cfif Highlight>class="bg_highlight"</cfif> ><cfif Highlight><span class="pix10bold">#Points#</span><cfelse><span class="pix10">#Points#</span></cfif></td>
						<td align="center" <cfif Highlight>class="bg_highlight"</cfif> ><cfif Highlight><span class="pix10bold">#redcards#</span><cfelse><span class="pix10">#redcards#</span></cfif></td>
						<td align="center" <cfif Highlight>class="bg_highlight"</cfif> ><cfif Highlight><span class="pix10bold">#yellowcards#</span><cfelse><span class="pix10">#yellowcards#</span></cfif></td>
					</tr>
				 </cfoutput>
			</table>
		</td>
		<td valign="TOP">
			<cfif StructKeyExists(url, "TeamID")>					
				<cfinclude template="queries/qry_QCardAnalysisP.cfm">
				<cfset Maxx = #QCardAnalysisP.RecordCount#>
				<cfset PlayerIDList = ValueList(QCardAnalysisP.PID)>
				<cfset GamesPlayedList = ValueList(QCardAnalysisP.GamesPlayed)>
				<table border="1" cellspacing="1" cellpadding="3" align="center">
					<cfoutput>
					<tr>
						<td><span class="pix10">&nbsp;</span></td>
						<td align="center"><span class="pix10bold">Player<BR>No.</span></td>
						<td><span class="pix10bold">Surname</span> <span class="pix10">Forenames</span></td>
						<td align="center"><span class="pix10bold">Games<BR>Played</span></td>
					</tr>
					</cfoutput>
			
					<cfloop index="x" from="#startx#" to="#Maxx#" step="1" >
						<cfinclude template="queries/qry_QCardHist.cfm">
						<cfoutput query="QCardHist" group="PlayerID">		
							<tr>
								<td><a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#"><span class="pix10">See Appearances</span></a></td>
								<td align="RIGHT"><span class="pix10">#PlayerNo#</span></td>
								<td><span class="pix10"><strong>#PlayerSurname#</strong> #PlayerForename#</span></td>
								<td align="center"><span class="pix10">#ListGetAt(GamesPlayedList,x)#</span></td>
								<cfoutput>
									<cfif CardType IS "Yellow">
										<td bgcolor="Yellow"><span class="pix10black"><strong>#RefsName#</strong></span></td>
									<cfelseif CardType IS "Red">
										<td bgcolor="Red"><span class="pix10white"><strong>#RefsName#</strong></span></td>
									<cfelseif CardType IS "Orange">
										<td bgcolor="Orange"><span class="pix10black"><strong>#RefsName#</strong></span></td>
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

		
