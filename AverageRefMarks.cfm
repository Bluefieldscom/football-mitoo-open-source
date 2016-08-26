<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif StructKeyExists(url, "TID") AND StructKeyExists(url, "OID")>
	<cfinclude template="queries/qry_HRefsMarks.cfm">
	<cfinclude template="queries/qry_ARefsMarks.cfm">
</cfif>
<cfinclude template="queries/qry_QAveRefMarksH.cfm">
<cfinclude template="queries/qry_QAveRefMarksA.cfm">
<cfinclude template="queries/qry_QAverageRefMarks.cfm">
<table>
	<tr>
		<td>
			<table align="CENTER">
				<tr>
					<td valign="TOP">
						<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
							<tr>
								<td align="Left"><span class="pix10">Team</span></td>
								<td align="Center"><span class="pix10">Home Games<BR>(Marks)</span><span class="pix10bold"><BR>Average</span></td>
								<td align="Center"><span class="pix10">Away Games<BR>(Marks)</span><span class="pix10bold"><BR>Average</span></td>
								<td align="Center"><span class="pix10">All Games<BR>(Marks)</span><span class="pix10bold"><BR>Average</span></td>
								
							</tr>
							<cfoutput query="QAverageRefMarks">
							<tr>
								<cfif StructKeyExists(url, "TID") AND StructKeyExists(url, "OID")>
									<cfif URL.TID IS QAverageRefMarks.TID AND URL.OID IS QAverageRefMarks.OID>
										<cfset ThisTeam = "#TName# #OName#">
										<td align="left" class="bg_highlight"><span class="pix10bold">#ThisTeam#</span></td>
									<cfelse>
										<td align="left"><span class="pix10">#TName# #OName#</span></td>
									</cfif>
								<cfelse>
									<td align="left"><span class="pix10">#TName# #OName#</span></td>
								</cfif>
								<td align="Right"><span class="pix10">#HGames# (#HMarks#)</span><span class="pix10bold">#NumberFormat(Evaluate(HMarks/HGames),'999.9')#</span></td>
								<td align="Right"><span class="pix10">#AGames# (#AMarks#)</span><span class="pix10bold">#NumberFormat(Evaluate(AMarks/AGames),'999.9')#</span></td>
								<td align="Right"><span class="pix10">#Evaluate(HGames+AGames)# (#Evaluate(HMarks+AMarks)#)</span><span class="pix10bold">#NumberFormat(Evaluate((HMarks+AMarks)/(HGames+AGames)),'999.9')#</span></td>
								<td align="Left"><span class="pix10"><a href="AverageRefMarks.cfm?LeagueCode=#LeagueCode#&TID=#TID#&OID=#OID#">see</a></span></td>
							</tr>
							</cfoutput>			
						</table>
					</td>
				</tr>
			</table>
		</td>
		<cfif StructKeyExists(url, "TID") AND StructKeyExists(url, "OID")>
		<td valign="top">
			<table border="0" align="center" cellpadding="2" cellspacing="2">
				<tr>
					<td colspan="4" align="center"><cfoutput><span class="pix13bold">#ThisTeam#</span></cfoutput></td>
				</tr>
				<tr>
					<td valign="top">
						<table border="1" cellpadding="3" cellspacing="1">
							<tr>
								<td align="center" colspan="5"><span class="pix10bold">Home Games</span></td>
							</tr>
							<cfoutput query="HRefsMarks">
								<tr>
									<td align="right"><span class="pix10">#RefereeMarksH#</span></td>
									<td><span class="pix10">#RName#</span></td>
									<cfif Result IS "H" >
										<td align="center"><span class="pix9">Home<br />Win</span></td>
									<cfelseif Result IS "A" >
										<td align="center"><span class="pix9">Away<br />Win</span></td>
									<cfelseif Result IS "D" >
										<td align="center"><span class="pix9">Drawn</span></td>
									<cfelseif Result IS "P" >
										<td align="center"><span class="pix9">Postponed</span></td>
									<cfelseif Result IS "Q" >
										<td align="center"><span class="pix9">Abandoned</span></td>
									<cfelseif Result IS "W" >
										<td align="center"><span class="pix9">Void</span></td>
									<cfelseif Result IS "T" >
										<td align="center"><span class="pix9">TEMP</span></td>
									<cfelse>
										<td align="center"><span class="pix10">#IIF(HRefsMarks.Result IS "U",DE("(Pens)"),DE(""))##HomeGoals#-#AwayGoals##IIF(HRefsMarks.Result IS "V",DE("(Pens)"),DE(""))#</span></td>
									</cfif>
									<td><span class="pix10">#OpponentsTeam# #OpponentsOrdinal#</span></td>
									<td align="right"><span class="pix10">#DateFormat(FixtureDate, 'D MMM')#</span></td>
								</tr>
							</cfoutput>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table border="1" cellpadding="3" cellspacing="1">
							<tr>
								<td align="center" colspan="5"><span class="pix10bold">Away Games</span></td>
							</tr>
							<cfoutput query="ARefsMarks">
								<tr>
									<td align="right"><span class="pix10">#RefereeMarksA#</span></td>
									<td><span class="pix10">#RName#</span></td>
									<cfif Result IS "H" >
										<td align="center"><span class="pix9">Home<br />Win</span></td>
									<cfelseif Result IS "A" >
										<td align="center"><span class="pix9">Away<br />Win</span></td>
									<cfelseif Result IS "D" >
										<td align="center"><span class="pix9">Drawn</span></td>
									<cfelseif Result IS "P" >
										<td align="center"><span class="pix9">Postponed</span></td>
									<cfelseif Result IS "Q" >
										<td align="center"><span class="pix9">Abandoned</span></td>
									<cfelseif Result IS "W" >
										<td align="center"><span class="pix9">Void</span></td>
									<cfelseif Result IS "T" >
										<td align="center"><span class="pix9">TEMP</span></td>
									<cfelse>
										<td align="center"><span class="pix10">#IIF(ARefsMarks.Result IS "U",DE("(Pens)"),DE(""))##HomeGoals#-#AwayGoals##IIF(ARefsMarks.Result IS "V",DE("(Pens)"),DE(""))#</span></td>
									</cfif>
									<td><span class="pix10">#OpponentsTeam# #OpponentsOrdinal#</span></td>
									<td align="right"><span class="pix10">#DateFormat(FixtureDate, 'D MMM')#</span></td>
								</tr>
							</cfoutput>
						</table>
					</td>
				</tr>
			</table>
		</td>
		</cfif>
	</tr>
</table>