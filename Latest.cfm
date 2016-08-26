<cfif ListFind("Silver,Skyblue,Yellow,White",request.SecurityLevel) >
<cfelse>
	<cfoutput>
		<cflocation url="http://www.mitoo.com/beta?league&leaguecode=#request.CurrentLeagueCodePrefix#&nonko=1" addtoken="no">
	</cfoutput>
	<cfabort>
</cfif>


<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>football.mitoo latest</title>
<cfset BatchInput = "No">

<cfinclude template="InclLeagueInfo.cfm">

<!--- Get a list of all distinct Fixture Dates from Fixture  --->
<cfinclude template="queries/qry_GetFixtureDates.cfm">
<!--- save them in a list  --->
<cfset ListOfDistinctDates=ValueList(GetFixtureDates.FixtureDate)>

<!---
<cfloop index="I" from="1" to="#ListLen(ListOfDistinctDates)#" step="1" >
	<cfset OldDateValue = ListGetAt(ListOfDistinctDates, I)>
	<cfset NewDateValue = DateFormat(OldDateValue)>
	<cfset ListOfDistinctDates = ListSetAt(ListOfDistinctDates, I, NewDateValue)>
</cfloop>
--->

<!--- We are trying to find the latest information, that is the fixtures and results of the two dates either side of, or equal to, today. --->
<cfset InRange = "No">
<cfloop index="I" from="2" to="#ListLen(ListOfDistinctDates)#" step="1" >
	<cfif (ListGetAt(ListOfDistinctDates, I-1) LE DateFormat(Now(),'YYYY-MM-DD')) AND (ListGetAt(ListOfDistinctDates, I) GE DateFormat(Now(),'YYYY-MM-DD'))   >
		<cfset InRange = "Yes">
		<cfbreak>
	</cfif>
</cfloop>
<cfif InRange IS "No">
	<center><span class="pix13boldred">Nothing to report</span></center>
	<cfabort>
</cfif>


<!---                      
*******************************        
* Previous Date with Fixtures *
*******************************
--->
<cfif ListLen(ListOfDistinctDates) LE 1>
	<center><span class="pix13boldred">Nothing to report</span></center>
	<cfabort>
</cfif>

<cfset MDate = DateFormat(ListGetAt(ListOfDistinctDates, I-1))>
<cfinclude template="queries/qry_QFixtures_v2.cfm">

<!---
<cfinclude template="queries/qry_QLeagueCode.cfm">
<cfset LeagueName = QLeagueCode.LeagueName >
<cfset SeasonStartDate = QLeagueCode.SeasonStartDate >
<cfset SeasonEndDate = QLeagueCode.SeasonEndDate >
<cfset SeasonName = QLeagueCode.SeasonName >
--->



<cfoutput>
<table width="100%" border="0" align="center" bgcolor="white">
<tr> 
	<td colspan="6" align="center"><a href="Counties.cfm?County=#request.County#"><img src="mitoo_logo1.png" alt="fmlogo" border="0"></a></td></tr>
	<tr> <td colspan="6" align="center"><span class="pix13bold">#SeasonName#</span></td></tr>
	<tr> <td colspan="6" align="center"><span class="pix13bold">#LeagueName#</span></td></tr>
	<tr> <td colspan="6" align="center"><span class="pix13bold">#DateFormat(MDate, 'DDDD, DD MMMM YYYY')#</span></td></tr>
</table>
</cfoutput>

<cfif QFixtures.RecordCount GT 0 >
	<table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="white">
		<cfif KickOffTimeOrder>
		<cfoutput query="QFixtures" group="DivName1">
			<tr> 
				<cfif ExternalComp IS 'Yes'>
					<td colspan="6" height="30" valign="bottom"><span class="pix13bolditalic">#DivName1#</span></td>
				<cfelse>
					<td colspan="6" height="30" valign="bottom"><span class="pix13bold">#DivName1#</span></td>
				</cfif>
			</tr>
				<cfoutput group="KOTime">
				<tr>
					<td height="10" colspan="2" align="left"></td>
					<td height="10" colspan="3" align="center"><span class="pix10bold">#TimeFormat(KOTime, 'h:mm tt')#</span></td>
					<td height="10" colspan="1" align="left"></td>
				</tr>
				<cfoutput>
				<cfif Result IS "T" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
					<!--- if it is a TEMP fixture then suppress output for the public --->
				<cfelse>	
					<cfif Result IS "H" AND HideScore IS "No" >
						<cfset message01 = "[ Home Win was awarded ]">
					<cfelseif Result IS "A" AND HideScore IS "No" >
						<cfset message01 = "[ Away Win was awarded ]">
					<cfelseif Result IS "U" AND HideScore IS "No" >
						<cfset message01 = "[ Home Win on penalties ]">
					<cfelseif Result IS "V" AND HideScore IS "No" >
						<cfset message01 = "[ Away Win on penalties ]">
					<cfelseif Result IS "D" AND HideScore IS "No" >
						<cfset message01 = "[ Draw was awarded ]">
					<cfelseif Result IS "P" >
						<cfset message01 = "[ Postponed ]">
					<cfelseif Result IS "Q" >
						<cfset message01 = "[ Abandoned ]">
					<cfelseif Result IS "W" >
						<cfset message01 = "[ Void ]">
					<cfelseif Result IS "T" >
						<cfset message01 = " hidden from the public ">
					<cfelse>
						<cfset message01 = "">
					</cfif>
					<tr>
						<cfif ExternalComp IS 'Yes'>
							<td width="20%"><span class="pix13italic">#IIF(Len(Trim(RoundName)) GT 0, DE( "[#RoundName#]"), DE(""))#</span></td>
						<cfelse>
							<td width="20%"><span class="pix13">#IIF(Len(Trim(RoundName)) GT 0, DE( "[#RoundName#]"), DE(""))#</span></td>
						</cfif>
						<cfif UCase(HomeGuest) IS "GUEST">
							<td width="30%" align="right"><span class="pix13italic">#HomeTeam# #HomeOrdinal#</span></td>
						<cfelse>
							<td width="30%" align="right"><span class="pix13">#HomeTeam# #HomeOrdinal#</span></td>
						</cfif>
						<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (HomeGoals IS "" AND AwayGoals IS "" AND Result IS "") >
									<td colspan="3" align="center"><span class="pix10grey">&nbsp;</span></td>
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
						<cfelseif Result IS "P">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">P</span></td>
						<cfelseif Result IS "Q">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">A</span></td>
						<cfelseif Result IS "W">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">V</span></td>
						<cfelseif Result IS "T">
							<td colspan="3" bgcolor="aqua" align="center" ><span class="pix13">TEMP</span></td>
						<cfelse>
							<td bgcolor="silver" width="2%" align="right"><span class="pix13"> 
								<cfif Result IS "H" >
								  H 
								  <cfelseif Result IS "A" >
								  - 
								  <cfelseif Result IS "D" >
								  D 
								  <cfelse>
								  #HomeGoals# 
								</cfif>
								</span>
							</td>

							<td width="1%" bgcolor="silver"  align="center"><span class="pix13">v</span>
							</td>
							<td width="2%" align="left" bgcolor="silver"> <span class="pix13">
								<cfif Result IS "H" >
								  - 
								  <cfelseif Result IS "A" >
								  A 
								  <cfelseif Result IS "D" >
								  D 
								  <cfelse>
								  #AwayGoals# 
								</cfif>
								</span>
							</td>
						</cfif>	
						<cfif UCase(AwayGuest) IS "GUEST">
							<td  align="left" width="30%" ><span class="pix13italic">#AwayTeam# #AWayOrdinal#</span><span class="pix10"> #message01#</span></td>
						<cfelse>
							<td  align="left" width="30%" ><span class="pix13">#AwayTeam# #AWayOrdinal#</span><span class="pix10"> #message01#</span></td>
						</cfif>
					</tr>
				</cfif>
				</cfoutput>
			</cfoutput>
		</cfoutput>
					
					
		<cfelse>
		<cfoutput query="QFixtures" group="DivName1"> 
			<tr> 
				<cfif ExternalComp IS 'Yes'>
					<td colspan="6" height="30" valign="bottom"><span class="pix13bolditalic">#DivName1#</span></td>
				<cfelse>
					<td colspan="6" height="30" valign="bottom"><span class="pix13bold">#DivName1#</span></td>
				</cfif>
			</tr>
			<cfset LineText = "#DivName1#: "><!--- \\\\\\ Press \\\\\\ --->
			<cfoutput>
				<cfif Result IS "T" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
					<!--- if it is a TEMP fixture then suppress output for the public --->
				<cfelse>	
					<cfif Result IS "H" AND HideScore IS "No" >
						<cfset message01 = "[ Home Win was awarded ]">
					<cfelseif Result IS "A" AND HideScore IS "No" >
						<cfset message01 = "[ Away Win was awarded ]">
					<cfelseif Result IS "U" AND HideScore IS "No" >
						<cfset message01 = "[ Home Win on penalties ]">
					<cfelseif Result IS "V" AND HideScore IS "No" >
						<cfset message01 = "[ Away Win on penalties ]">
					<cfelseif Result IS "D" AND HideScore IS "No" >
						<cfset message01 = "[ Draw was awarded ]">
					<cfelseif Result IS "P" >
						<cfset message01 = "[ Postponed ]">
					<cfelseif Result IS "Q" >
						<cfset message01 = "[ Abandoned ]">
					<cfelseif Result IS "W" >
						<cfset message01 = "[ Void ]">
					<cfelseif Result IS "T" >
						<cfset message01 = " hidden from the public ">
					<cfelse>
						<cfset message01 = "">
					</cfif>
					<tr>
						<cfif ExternalComp IS 'Yes'>
							<td width="20%"><span class="pix13italic">#IIF(Len(Trim(RoundName)) GT 0, DE( "[#RoundName#]"), DE(""))#</span></td>
						<cfelse>
							<td width="20%"><span class="pix13">#IIF(Len(Trim(RoundName)) GT 0, DE( "[#RoundName#]"), DE(""))#</span></td>
						</cfif>
						<cfset GameText = ""><!--- \\\\\\ Press \\\\\\ --->
						<cfif UCase(HomeGuest) IS "GUEST">
							<td width="30%" align="right"><span class="pix13italic">#HomeTeam# #HomeOrdinal#</span></td>
						<cfelse>
							<td width="30%" align="right"><span class="pix13">#HomeTeam# #HomeOrdinal#</span></td>
						</cfif>
						<cfset GameText = "#GameText##HomeTeam# #HomeOrdinal#"><!--- \\\\\\ Press \\\\\\ --->
						<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (HomeGoals IS "" AND AwayGoals IS "" AND Result IS "") >
									<td colspan="3" align="center"><span class="pix10grey">&nbsp;</span></td>
									<cfset GameText = "#GameText# "><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
									<cfset GameText = "#GameText# Played"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
									<cfset GameText = "#GameText# Played"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
									<cfset GameText = "#GameText# Played"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif Result IS "P">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">P</span></td>
							<cfset GameText = "#GameText# P"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif Result IS "Q">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">A</span></td>
							<cfset GameText = "#GameText# A"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif Result IS "W">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">V</span></td>
							<cfset GameText = "#GameText# V"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif Result IS "T">
							<td colspan="3" bgcolor="aqua" align="center" ><span class="pix13">TEMP</span></td>
							<cfset GameText = "#GameText# TEMP"><!--- \\\\\\ Press \\\\\\ --->
						<cfelse>
							<td bgcolor="silver" width="2%" align="right"><span class="pix13"> 
								<cfif Result IS "H" >
								  H 
								  <cfelseif Result IS "A" >
								  - 
								  <cfelseif Result IS "D" >
								  D 
								  <cfelse>
								  #HomeGoals# 
								</cfif>
								<cfif Result IS "H" >
									<cfset GameText = "#GameText# H"><!--- \\\\\\ Press \\\\\\ ---> 
								<cfelseif Result IS "A" >
									<cfset GameText = "#GameText# -"><!--- \\\\\\ Press \\\\\\ ---> 
								<cfelseif Result IS "D" >
									<cfset GameText = "#GameText# D"><!--- \\\\\\ Press \\\\\\ ---> 
								<cfelse>
									<cfset GameText = "#GameText# #HomeGoals#"><!--- \\\\\\ Press \\\\\\ ---> 
								</cfif>
								</span>
							</td>
							<td width="1%" bgcolor="silver"  align="center"><span class="pix13">v</span>
							</td>
							<td width="2%" align="left" bgcolor="silver"> <span class="pix13">
								<cfif Result IS "H" >
								  - 
								  <cfelseif Result IS "A" >
								  A 
								  <cfelseif Result IS "D" >
								  D 
								  <cfelse>
								  #AwayGoals# 
								</cfif>
								</span>
							</td>
						</cfif>	
						<cfif UCase(AwayGuest) IS "GUEST">
							<td  align="left" width="30%" ><span class="pix13italic">#AwayTeam# #AWayOrdinal#</span><span class="pix10"> #message01#</span></td>
						<cfelse>
							<td  align="left" width="30%" ><span class="pix13">#AwayTeam# #AWayOrdinal#</span><span class="pix10"> #message01#</span></td>
						</cfif>
						<cfset GameText = "#GameText# #AwayTeam# #AWayOrdinal#"><!--- \\\\\\ Press \\\\\\ --->
						<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
						<cfelseif Result IS "H" >
							<cfset GameText = "#GameText# -"><!--- \\\\\\ Press \\\\\\ ---> 
						<cfelseif Result IS "A" >
							<cfset GameText = "#GameText# A"><!--- \\\\\\ Press \\\\\\ ---> 
						<cfelseif Result IS "D" >
							<cfset GameText = "#GameText# D"><!--- \\\\\\ Press \\\\\\ ---> 
						<cfelse>
							<cfset GameText = "#GameText# #AwayGoals#"><!--- \\\\\\ Press \\\\\\ ---> 
						</cfif>
					</tr>
				</cfif>
				<cfset LineText = "#LineText##GameText#; "><!--- \\\\\\ Press \\\\\\ --->
			</cfoutput>
			<span class="pix10">#LineText#<br></span><!--- \\\\\\ Press \\\\\\ --->											
		</cfoutput>
		<br>
		</cfif>
	</table>
</cfif>
<hr>
<!---                      
***************************          
* Next Date with Fixtures *
***************************
--->
<cfset MDate = DateFormat(ListGetAt(ListOfDistinctDates, I))>
<cfinclude template="queries/qry_QFixtures_v2.cfm">

<cfoutput>
<table width="100%" border="0" align="center" bgcolor="white">
<tr> 
	<td colspan="6" align="center"><a href="Counties.cfm?County=#request.County#"><img src="mitoo_logo1.png" alt="fmlogo" border="0"></a></td></tr>
	<tr> <td colspan="6" align="center"><span class="pix13bold">#SeasonName#</span></td></tr>
	<tr> <td colspan="6" align="center"><span class="pix13bold">#LeagueName#</span></td></tr>
	<tr> <td colspan="6" align="center"><span class="pix13bold">#DateFormat(MDate, 'DDDD, DD MMMM YYYY')#</span></td></tr>
</table>
</cfoutput>

<cfif QFixtures.RecordCount GT 0 >
	<table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="white">
		<cfif KickOffTimeOrder>
		<cfoutput query="QFixtures" group="DivName1"> 
			<tr> 
				<cfif ExternalComp IS 'Yes'>
					<td colspan="6" height="30" valign="bottom"><span class="pix13bolditalic">#DivName1#</span></td>
				<cfelse>
					<td colspan="6" height="30" valign="bottom"><span class="pix13bold">#DivName1#</span></td>
				</cfif>
			</tr>
				<cfoutput group="KOTime">
				<tr>
					<td height="10" colspan="2" align="left"></td>
					<td height="10" colspan="3" align="center"><span class="pix10bold">#TimeFormat(KOTime, 'h:mm tt')#</span></td>
					<td height="10" colspan="1" align="left"></td>
				</tr>
				<cfoutput>
				<cfif Result IS "T" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
					<!--- if it is a TEMP fixture then suppress output for the public --->
				<cfelse>	
					<cfif Result IS "H" AND HideScore IS "No" >
						<cfset message01 = "[ Home Win was awarded ]">
					<cfelseif Result IS "A" AND HideScore IS "No" >
						<cfset message01 = "[ Away Win was awarded ]">
					<cfelseif Result IS "U" AND HideScore IS "No" >
						<cfset message01 = "[ Home Win on penalties ]">
					<cfelseif Result IS "V" AND HideScore IS "No" >
						<cfset message01 = "[ Away Win on penalties ]">
					<cfelseif Result IS "D" AND HideScore IS "No" >
						<cfset message01 = "[ Draw was awarded ]">
					<cfelseif Result IS "P" >
						<cfset message01 = "[ Postponed ]">
					<cfelseif Result IS "Q" >
						<cfset message01 = "[ Abandoned ]">
					<cfelseif Result IS "W" >
						<cfset message01 = "[ Void ]">
					<cfelseif Result IS "T" >
						<cfset message01 = " hidden from the public ">
					<cfelse>
						<cfset message01 = "">
					</cfif>
					<tr>
						<cfif ExternalComp IS 'Yes'>
							<td width="20%"><span class="pix13italic">#IIF(Len(Trim(RoundName)) GT 0, DE( "[#RoundName#]"), DE(""))#</span></td>
						<cfelse>
							<td width="20%"><span class="pix13">#IIF(Len(Trim(RoundName)) GT 0, DE( "[#RoundName#]"), DE(""))#</span></td>
						</cfif>
						<cfif UCase(HomeGuest) IS "GUEST">
							<td width="30%" align="right"><span class="pix13italic">#HomeTeam# #HomeOrdinal#</span></td>
						<cfelse>
							<td width="30%" align="right"><span class="pix13">#HomeTeam# #HomeOrdinal#</span></td>
						</cfif>
	
						<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (HomeGoals IS "" AND AwayGoals IS "" AND Result IS "") >
									<td colspan="3" align="center"><span class="pix10grey">&nbsp;</span></td>
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
						<cfelseif Result IS "P">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">P</span></td>
						<cfelseif Result IS "Q">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">A</span></td>
						<cfelseif Result IS "W">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">V</span></td>
						<cfelseif Result IS "T">
							<td colspan="3" bgcolor="aqua" align="center" ><span class="pix13">TEMP</span></td>
						<cfelse>
							<td bgcolor="silver" width="2%" align="right"><span class="pix13"> 
								<cfif Result IS "H" >
								  H 
								  <cfelseif Result IS "A" >
								  - 
								  <cfelseif Result IS "D" >
								  D 
								  <cfelse>
								  #HomeGoals# 
								</cfif>
								</span>
							</td>
							<td width="1%" bgcolor="silver"  align="center"><span class="pix13">v</span>
							</td>
							<td width="2%" align="left" bgcolor="silver"> <span class="pix13">
								<cfif Result IS "H" >
								  - 
								  <cfelseif Result IS "A" >
								  A 
								  <cfelseif Result IS "D" >
								  D 
								  <cfelse>
								  #AwayGoals# 
								</cfif>
								</span>
							</td>
						</cfif>	
						<cfif UCase(AwayGuest) IS "GUEST">
							<td  align="left" width="30%" ><span class="pix13italic">#AwayTeam# #AWayOrdinal#</span><span class="pix10"> #message01#</span></td>
						<cfelse>
							<td  align="left" width="30%" ><span class="pix13">#AwayTeam# #AWayOrdinal#</span><span class="pix10"> #message01#</span></td>
						</cfif>
					</tr>
				</cfif>
				</cfoutput>
			</cfoutput>
		</cfoutput>
					
					
		<cfelse>
		<cfoutput query="QFixtures" group="DivName1"> 
			<tr> 
				<cfif ExternalComp IS 'Yes'>
					<td colspan="6" height="30" valign="bottom"><span class="pix13bolditalic">#DivName1#</span></td>
				<cfelse>
					<td colspan="6" height="30" valign="bottom"><span class="pix13bold">#DivName1#</span></td>
				</cfif>
			</tr>
			<cfset LineText = "#DivName1#: "><!--- \\\\\\ Press \\\\\\ --->
			
			<cfoutput>
			
				<cfif Result IS "T" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
					<!--- if it is a TEMP fixture then suppress output for the public --->
				<cfelse>	
					<cfif Result IS "H" AND HideScore IS "No" >
						<cfset message01 = "[ Home Win was awarded ]">
					<cfelseif Result IS "A" AND HideScore IS "No" >
						<cfset message01 = "[ Away Win was awarded ]">
					<cfelseif Result IS "U" AND HideScore IS "No" >
						<cfset message01 = "[ Home Win on penalties ]">
					<cfelseif Result IS "V" AND HideScore IS "No" >
						<cfset message01 = "[ Away Win on penalties ]">
					<cfelseif Result IS "D" AND HideScore IS "No" >
						<cfset message01 = "[ Draw was awarded ]">
					<cfelseif Result IS "P" >
						<cfset message01 = "[ Postponed ]">
					<cfelseif Result IS "Q" >
						<cfset message01 = "[ Abandoned ]">
					<cfelseif Result IS "W" >
						<cfset message01 = "[ Void ]">
					<cfelseif Result IS "T" >
						<cfset message01 = " hidden from the public ">
					<cfelse>
						<cfset message01 = "">
					</cfif>
					<tr>
						<cfif ExternalComp IS 'Yes'>
							<td width="20%"><span class="pix13italic">#IIF(Len(Trim(RoundName)) GT 0, DE( "[#RoundName#]"), DE(""))#</span></td>
						<cfelse>
							<td width="20%"><span class="pix13">#IIF(Len(Trim(RoundName)) GT 0, DE( "[#RoundName#]"), DE(""))#</span></td>
						</cfif>
						<cfset GameText = ""><!--- \\\\\\ Press \\\\\\ --->
						<cfif UCase(HomeGuest) IS "GUEST">
							<td width="30%" align="right"><span class="pix13italic">#HomeTeam# #HomeOrdinal#</span></td>
						<cfelse>
							<td width="30%" align="right"><span class="pix13">#HomeTeam# #HomeOrdinal#</span></td>
						</cfif>
						<cfset GameText = "#GameText##HomeTeam# #HomeOrdinal#"><!--- \\\\\\ Press \\\\\\ --->
						<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (HomeGoals IS "" AND AwayGoals IS "" AND Result IS "") >
									<td colspan="3" align="center"><span class="pix10grey">&nbsp;</span></td>
									<cfset GameText = "#GameText# "><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
									<cfset GameText = "#GameText# Played"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
									<cfset GameText = "#GameText# Played"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
									<td colspan="3" align="center"><span class="pix10grey">Played</span></td>
									<cfset GameText = "#GameText# Played"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif Result IS "P">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">P</span></td>
									<cfset GameText = "#GameText# P"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif Result IS "Q">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">A</span></td>
									<cfset GameText = "#GameText# A"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif Result IS "W">
							<td colspan="3" bgcolor="silver" align="center" ><span class="pix13">V</span></td>
									<cfset GameText = "#GameText# V"><!--- \\\\\\ Press \\\\\\ --->
						<cfelseif Result IS "T">
							<td colspan="3" bgcolor="aqua" align="center" ><span class="pix13">TEMP</span></td>
									<cfset GameText = "#GameText# TEMP"><!--- \\\\\\ Press \\\\\\ --->
						<cfelse>
							<td bgcolor="silver" width="2%" align="right"><span class="pix13"> 
								<cfif Result IS "H" >
								  H 
								  <cfelseif Result IS "A" >
								  - 
								  <cfelseif Result IS "D" >
								  D 
								  <cfelse>
								  #HomeGoals# 
								</cfif>
								<cfif Result IS "H" >
									<cfset GameText = "#GameText# H"><!--- \\\\\\ Press \\\\\\ ---> 
								<cfelseif Result IS "A" >
									<cfset GameText = "#GameText# -"><!--- \\\\\\ Press \\\\\\ ---> 
								<cfelseif Result IS "D" >
									<cfset GameText = "#GameText# D"><!--- \\\\\\ Press \\\\\\ ---> 
								<cfelse>
									<cfset GameText = "#GameText# #HomeGoals#"><!--- \\\\\\ Press \\\\\\ ---> 
								</cfif>
								</span>
							</td>
							<td width="1%" bgcolor="silver"  align="center"><span class="pix13">v</span>
							</td>
							<td width="2%" align="left" bgcolor="silver"> <span class="pix13">
									<cfif Result IS "H" >
									  - 
									  <cfelseif Result IS "A" >
									  A 
									  <cfelseif Result IS "D" >
									  D 
									  <cfelse>
									  #AwayGoals#
									</cfif>
								</span>
							</td>
						</cfif>	
						<cfif UCase(AwayGuest) IS "GUEST">
							<td  align="left" width="30%" ><span class="pix13italic">#AwayTeam# #AWayOrdinal#</span><span class="pix10"> #message01#</span></td>
						<cfelse>
							<td  align="left" width="30%" ><span class="pix13">#AwayTeam# #AWayOrdinal#</span><span class="pix10"> #message01#</span></td>
						</cfif>
						<cfset GameText = "#GameText# #AwayTeam# #AWayOrdinal#"><!--- \\\\\\ Press \\\\\\ --->
						<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel)>
						<cfelseif Result IS "H" >
							<cfset GameText = "#GameText# -"><!--- \\\\\\ Press \\\\\\ ---> 
						<cfelseif Result IS "A" >
							<cfset GameText = "#GameText# A"><!--- \\\\\\ Press \\\\\\ ---> 
						<cfelseif Result IS "D" >
							<cfset GameText = "#GameText# D"><!--- \\\\\\ Press \\\\\\ ---> 
						<cfelse>
							<cfset GameText = "#GameText# #AwayGoals#"><!--- \\\\\\ Press \\\\\\ ---> 
						</cfif>
					</tr>
				</cfif>
				<cfset LineText = "#LineText##GameText#; "><!--- \\\\\\ Press \\\\\\ --->
			</cfoutput>
			<span class="pix10">#LineText#<br></span><!--- \\\\\\ Press \\\\\\ --->											
		</cfoutput>
		<br>
		</cfif>
	</table>
</cfif>
<hr><br><br><br><br>
