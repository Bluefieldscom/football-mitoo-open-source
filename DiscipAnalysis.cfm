<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url,"cups") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif url.cups IS "Y" >
	<cfset IncludeKOGames = "Y">
<cfelseif  url.cups IS "N" >
	<cfset IncludeKOGames = "N">
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfparam name="startx" default=1>
<table align="center">
	<cfif url.cups IS "Y" >
		<tr><td align="center"><span class="pix18bold">Including Cup Matches</span></td></tr>
		<cfinclude template="queries/qry_QDiscipAnalysis.cfm">
	<cfelse>
		<tr><td align="center"><span class="pix18bold">Excluding Cup Matches</span></td></tr>
		<cfinclude template="queries/qry_QDiscipAnalysisX.cfm">
	</cfif>
	<tr>
		<td valign="TOP">
			<table border="1" cellspacing="1" cellpadding="3" align="center">
				<tr>
					<td align="center"><span class="pix10bold">Team</span></td>
					<td align="center"><span class="pix10bold">Points</span></td>
					<td align="center" bgcolor="red">   <span class="pix10white"><strong>R</strong></span></td>
					<td align="center" bgcolor="yellow"><span class="pix10black"><strong>Y</strong></span></td>
				</tr>
				<cfoutput query="QDiscipAnalysis">
					<cfset Highlight = "No">
					<cfif StructKeyExists(url, "TeamID")>
						<cfif TID IS URL.TeamID>
							<cfset Highlight = "Yes">
						</cfif>
					</cfif>
					<tr>
						<td align="left" <cfif Highlight>class="bg_highlight"</cfif> ><a href="DiscipAnalysis.cfm?LeagueCode=#LeagueCode#&TeamID=#TID#&OrdinalID=#OID#&cups=#IncludeKOGames#"><span class="pix10"><cfif Highlight><strong>#TeamName#</strong><cfelse>#TeamName#</cfif></span></a></td>
						<td align="center" <cfif Highlight>class="bg_highlight"</cfif> ><span class="pix10"><cfif Highlight><strong>#Points#</strong><cfelse>#Points#</cfif></span></td>
						<td align="center" <cfif Highlight>class="bg_highlight"</cfif> ><span class="pix10"><cfif Highlight><strong>#redcards#</strong><cfelse>#redcards#</cfif></span></td>
						<td align="center" <cfif Highlight>class="bg_highlight"</cfif> ><span class="pix10"><cfif Highlight><strong>#yellowcards#</strong><cfelse>#yellowcards#</cfif></span></td>

					</tr>
				 </cfoutput>
			</table>
		</td>
		<td valign="top">
			<cfif StructKeyExists(url, "TeamID")>
				<cfif IncludeKOGames IS "Y">
					<cfinclude template="queries/qry_QDiscipAnalysisP.cfm">
				<cfelse>
					<cfinclude template="queries/qry_QDiscipAnalysisPX.cfm">
				</cfif>
				<cfset Maxx = #QDiscipAnalysisP.RecordCount#>
				<cfset PlayerIDList = ValueList(QDiscipAnalysisP.PID)>
				<cfset GamesPlayedList = ValueList(QDiscipAnalysisP.GamesPlayed)>
				<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
					<tr>
						<td colspan="4" align="center"><span class="pix13bold"><cfoutput>#QDiscipAnalysisP.TeamName#</cfoutput></span></td>
					</tr>
				
					<tr>
						<td><span class="pix10">&nbsp;</span></td>
						<td align="center"><span class="pix10bold">Player<BR>No.</span></td>
						<td><span class="pix10"><strong>Surname</strong> Forenames</span></td>
						<td align="center"><span class="pix10bold">Games<BR>Played</span></td>
					</tr>
					<cfloop index="x" from="#startx#" to="#Maxx#" step="1" >
						<cfif IncludeKOGames IS "Y">
							<cfinclude template="queries/qry_QDiscipCardHist.cfm">
						<cfelse>
							<cfinclude template="queries/qry_QDiscipCardHistX.cfm">
						</cfif>
						
						<cfoutput query="QDiscipCardHist" group="PlayerID">		
							<tr>
								<td><a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#"><span class="pix10">See Appearances</a></span></td>
								<td align="right"><span class="pix10">#PlayerNo#</span></td>
								<td><span class="pix10"><strong>#PlayerSurname#</strong> #PlayerForename#</span></td>
								<td align="center"><span class="pix10">#ListGetAt(GamesPlayedList,x)#</span></td>
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
