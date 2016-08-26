<cfset BatchInput = "No">
<cfset MDate = url.ThisDate >
<cfinclude template="InclBegin.cfm">
<cfsilent>
	<cfinclude template="queries/qry_QFixtures_v2.cfm">
</cfsilent>

<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=Fixtures&Results.xls">
<cfset ThisColSpan = 6 >
<cfoutput>
	<table border="0">
	<tr> <td colspan="#ThisColSpan#" align="center">#SeasonName#</td></tr>
	<tr> <td colspan="#ThisColSpan#" align="center">#LeagueName#</td></tr>
	<tr> <td colspan="#ThisColSpan#" align="center" valign="top">#DateFormat(url.ThisDate, 'DDDD, DD MMMM YYYY')#</td></tr>
	<tr bgcolor="White">
		<td height="20" colspan="#ThisColSpan#">&nbsp;</td>
	</tr>
</cfoutput>

</table>
<cfif QFixtures.RecordCount GT 0 >
		<!--- Hide the fixtures from the public if the Event Text says so --->
		<cfinclude template="queries/qry_QEventText.cfm">
		<cfif QEventText.RecordCount IS 1>
			<cfif FindNoCase("Hide_Fixtures",QEventText.EventText)>
				<cfoutput>
				<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
					<tr>
						<cfif QFixtures.RecordCount IS 1>
							<td height="20" colspan="#ThisColSpan#" align="center" bgcolor="red"><span class="pix13boldwhite">Today's fixture has been hidden from the public</span></td>
						<cfelseif QFixtures.RecordCount GT 1>
							<td height="20" colspan="#ThisColSpan#" align="center" bgcolor="red"> <span class="pix13boldwhite">Today's fixtures have been hidden from the public</span></td>
						</cfif>
					</tr>
				<cfelse>
					<tr>
						<cfif QFixtures.RecordCount IS 1>
							<td colspan="#ThisColSpan#" align="center"><span class="pix13bold">Today's fixture has been hidden</span></td>
							<cfabort>
						<cfelseif QFixtures.RecordCount GT 1>
							<td colspan="#ThisColSpan#" align="center"> <span class="pix13bold">Today's fixtures have been hidden</span></td>
							<cfabort>
						</cfif>
					</tr>
				</cfif>
				</cfoutput>
			</cfif>
		</cfif>
			<cfoutput>
			<table width="100%" border="0" cellspacing="2" cellpadding="0" >
				<tr> 
					<td>&nbsp;</td>
					<td align="right">Home Team&nbsp;&nbsp;&nbsp;</td>
					<td colspan="2" align="center">Score</td>
					<td colspan="2">&nbsp;&nbsp;&nbsp;Away Team</td>
				</tr>
			</cfoutput>
			
			
			<cfif KickOffTimeOrder>
			<cfoutput query="QFixtures" group="DivName1"> 
				<tr> 
					<cfif ExternalComp IS 'Yes'>
						<td height="30" colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="+1"><strong><em>#DivName1#</em></strong></font></td>
					<cfelse>
						<td height="30" colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="+1"><strong>#DivName1#</strong></font></td>
					</cfif>
				</tr>
				
				<cfoutput group="KOTime">
					<tr>
						<td  colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="-1">#TimeFormat(KOTime, 'h:mm tt')#</font></td>
					</tr>
					<cfoutput>
						<cfif Result IS "H" >
							<cfset message01 = "[ Home Win was awarded ]">
						<cfelseif Result IS "A" >
							<cfset message01 = "[ Away Win was awarded ]">
						<cfelseif Result IS "U" >
							<cfset message01 = "[ Home Win on penalties ]">
						<cfelseif Result IS "V" >
							<cfset message01 = "[ Away Win on penalties ]">
						<cfelseif Result IS "D" >
							<cfset message01 = "[ Draw was awarded ]">
						<cfelseif Result IS "P" >
							<cfset message01 = "[ Postponed ]">
						<cfelseif Result IS "Q" >
							<cfset message01 = "[ Abandoned ]">
						<cfelseif Result IS "W" >
							<cfset message01 = "[ Void ]">
						<cfelseif Result IS "T" AND ListFind("Silver,Skyblue",request.SecurityLevel) >
							<cfset message01 = "hidden from the public">
						<cfelse>
							<cfset message01 = "">
						</cfif>
						<!--- suppress TEMP fixtures if not logged in --->
						<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND Result IS "T">
							<!--- do nothing --->
						<cfelse>
							<tr>
								<td>#RoundName#</td>
							<cfif UCase(HomeGuest) IS "GUEST">
									<td align="right"><em>#HomeTeam# #HomeOrdinal#</em>&nbsp;&nbsp;&nbsp;</td>
								<cfelse>
									<td align="right">#HomeTeam# #HomeOrdinal#&nbsp;&nbsp;&nbsp;</td>
							</cfif>
								<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND HomeGoals IS "" AND AwayGoals IS "" AND Result IS "" >
									<td colspan="2" align="center">&nbsp;</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
									<td colspan="2" align="center">Played</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
										<td colspan="2" align="center">Played</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
										<td colspan="2" align="center">Played</td>
								<cfelseif Result IS "P" >
									<td colspan="2" align="center" >P</td>
								<cfelseif Result IS "Q">
									<td colspan="2" align="center" >A</td>
								<cfelseif Result IS "W">
									<td colspan="2" align="center" >V</td>
								<cfelseif Result IS "T">
									<td colspan="2" align="center" >TEMP</td>
								<cfelse>
									<td align="CENTER" > 
										<cfif Result IS "H" >
										  H 
										  <cfelseif Result IS "A" >
										  - 
										  <cfelseif Result IS "D" >
										  D 
										  <cfelse>
										  #HomeGoals# 
										</cfif>
									</td>
									<td align="CENTER"> 
										<cfif Result IS "H" >
										  - 
										  <cfelseif Result IS "A" >
										  A 
										  <cfelseif Result IS "D" >
										  D 
										  <cfelse>
										  #AwayGoals# 
										</cfif>
									</td>
								</cfif>
								<cfif UCase(AwayGuest) IS "GUEST">
									<td>&nbsp;&nbsp;&nbsp;<em>#AwayTeam# #AWayOrdinal#</em></td>
								<cfelse>
									<td>&nbsp;&nbsp;&nbsp;#AwayTeam# #AWayOrdinal#</td>
								</cfif>
								<td>#message01#</td>
							</tr>
						</cfif>
		
					</cfoutput> 
			</cfoutput>
		</cfoutput>
			<cfelse> <!--- not in KickOffTimeOrder --->
			<cfoutput query="QFixtures" group="DivName1"> 
				<tr> 
					<cfif ExternalComp IS 'Yes'>
						<td height="30" colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="+1"><strong><em>#DivName1#</em></strong></font></td>
					<cfelse>
						<td height="30" colspan="#ThisColSpan#" align="left" bgcolor="white"><font size="+1"><strong>#DivName1#</strong></font></td>
					</cfif>
				</tr>
					<cfoutput>
						<cfif Result IS "H" >
							<cfset message01 = "[ Home Win was awarded ]">
						<cfelseif Result IS "A" >
							<cfset message01 = "[ Away Win was awarded ]">
						<cfelseif Result IS "U" >
							<cfset message01 = "[ Home Win on penalties ]">
						<cfelseif Result IS "V" >
							<cfset message01 = "[ Away Win on penalties ]">
						<cfelseif Result IS "D" >
							<cfset message01 = "[ Draw was awarded ]">
						<cfelseif Result IS "P" >
							<cfset message01 = "[ Postponed ]">
						<cfelseif Result IS "Q" >
							<cfset message01 = "[ Abandoned ]">
						<cfelseif Result IS "W" >
							<cfset message01 = "[ Void ]">
						<cfelseif Result IS "T" AND ListFind("Silver,Skyblue",request.SecurityLevel) >
							<cfset message01 = "hidden from the public">
						<cfelse>
							<cfset message01 = "">
						</cfif>
						<!--- suppress TEMP fixtures if not logged in --->
						<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND Result IS "T">
							<!--- do nothing --->
						<cfelse>
							<tr>
								<td>#RoundName#</td>
							<cfif UCase(HomeGuest) IS "GUEST">
									<td align="right"><em>#HomeTeam# #HomeOrdinal#</em>&nbsp;&nbsp;&nbsp;</td>
								<cfelse>
									<td align="right">#HomeTeam# #HomeOrdinal#&nbsp;&nbsp;&nbsp;</td>
							</cfif>
								<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND HomeGoals IS "" AND AwayGoals IS "" AND Result IS "" >
									<td colspan="2" align="center">&nbsp;</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
									<td colspan="2" align="center">Played</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
										<td colspan="2" align="center">Played</td>
								<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
										<td colspan="2" align="center">Played</td>
								<cfelseif Result IS "P" >
									<td colspan="2" align="center" >P</td>
								<cfelseif Result IS "Q">
									<td colspan="2" align="center" >A</td>
								<cfelseif Result IS "W">
									<td colspan="2" align="center" >V</td>
								<cfelseif Result IS "T">
									<td colspan="2" align="center" >TEMP</td>
								<cfelse>
									<td align="CENTER" > 
										<cfif Result IS "H" >
										  H 
										  <cfelseif Result IS "A" >
										  - 
										  <cfelseif Result IS "D" >
										  D 
										  <cfelse>
										  #HomeGoals# 
										</cfif>
									</td>
									<td align="CENTER"> 
										<cfif Result IS "H" >
										  - 
										  <cfelseif Result IS "A" >
										  A 
										  <cfelseif Result IS "D" >
										  D 
										  <cfelse>
										  #AwayGoals# 
										</cfif>
									</td>
								</cfif>
								<cfif UCase(AwayGuest) IS "GUEST">
									<td>&nbsp;&nbsp;&nbsp;<em>#AwayTeam# #AWayOrdinal#</em></td>
								<cfelse>
									<td>&nbsp;&nbsp;&nbsp;#AwayTeam# #AWayOrdinal#</td>
								</cfif>
								<td>#message01#</td>
							</tr>
						</cfif>
				</cfoutput>
			</cfoutput>
		</table>
		
	</cfif>
</cfif>