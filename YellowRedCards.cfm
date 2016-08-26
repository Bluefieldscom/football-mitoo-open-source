<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfparam name="startx" default="1">
<cfinclude template = "queries/qry_QYellowRedCards.cfm">
	
<cfset Maxx = #QYellowRedCards.RecordCount#>
<cfset PlayerIDList = ValueList(QYellowRedCards.PlayerID)>
<cfset GamesPlayedList = ValueList(QYellowRedCards.GamesPlayed)>
	<!---
	<cfoutput query="QYellowRedCards">
	<span class="pix13">#PlayerID# #PlayerName# Points=#Points# GamesPlayed=#GamesPlayed#   <BR>    </span>
	 </cfoutput>
	<HR>
	--->
	<BR>
	<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
		
	<cfoutput>
		<tr>
			<td><span class="pix10">&nbsp;</span></td>
			<td align="CENTER"><span class="pix10bold">Player<BR>No.</span></td>
			<td><span class="pix10bold">Surname</span> <span class="pix10">Forenames</span></td>
			<td align="CENTER"><span class="pix10bold">Games<BR>Played</span></td>
		</tr>
	</cfoutput>

		<CFLOOP index="x" from="#startx#" to="#Maxx#" step="1" >

			<cfinclude template = "queries/qry_QCardHist_v2.cfm">

			<cfoutput query="QCardHist" group="PlayerID">
			<cfset Highlight = "No">
			<cflock scope="session" timeout="10" type="readonly">
				<cfif session.fmPlayerID IS PlayerID>
					<cfset Highlight = "Yes">
				</cfif>
			</cflock>
					<tr>
					<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10"><a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#">See Appearances</a></span></td>
					<td align="RIGHT" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10">#PlayerNo#</span></td>
					<td <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10bold">#Surname#</span> <span class="pix10">#Forename#</span></td>
					<td align="CENTER" <cfif Highlight>class="bg_highlight"</cfif>><span class="pix10">#ListGetAt(GamesPlayedList,x)#</span></td>
					<cfoutput >
						<cfif CardType IS "Red">
							<td bgcolor="Red"><span class="pix10boldwhite">R</span></td>
						</cfif>
						<cfif CardType IS "Yellow">
							<td bgcolor="Yellow"><span class="pix10boldblack">Y</span></td>
						</cfif>
						<cfif CardType IS "Orange">
							<td bgcolor="Orange"><span class="pix10boldblack">4</span></td>
						</cfif>
					</cfoutput>
				</tr>
			</cfoutput>
			<cfif x LT maxx>
			<cfif x GT (#startx# + 18) >
			
			</table>
			<table width="100%">
				<tr>
					<td align="CENTER">
					<cfoutput>
						<span class="pix13bold">
						<cfset startx = x + 1>
						<a href="YellowRedCards.cfm?LeagueCode=#LeagueCode#&startx=#startx#">
						More...</a>&nbsp;&nbsp;
						</span>
					</cfoutput>
					<CFBREAK>
					</td>
				</tr>
			</table>
			</cfif>
		</cfif>
			
		</cfloop>
	</table>
