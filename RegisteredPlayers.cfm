<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QRegistrationsCount.cfm">
<cfinclude template="queries/qry_QPlayersCount.cfm">
<cfinclude template="queries/qry_QRegPlayersCount.cfm">
<cfinclude template="queries/qry_QLapsedRegPlayersCount.cfm">
<cfinclude template="queries/qry_QUnregisteredPlayersCount.cfm">
<cfinclude template="queries/qry_QRegPlayers2.cfm">
<cfinclude template="queries/qry_QRegPlayers3.cfm">
<cfinclude template="queries/qry_QRegPlayers7.cfm">

<cfinclude template="queries/qry_QCheckPDNW1.cfm">
<cfinclude template="queries/qry_QCheckPDNW2.cfm">
<cfinclude template="queries/qry_QCheckPDNW3.cfm">


<table border="0" cellspacing="0" cellpadding="2" align="CENTER" class="loggedinScreen">
	<tr>
		<td valign="TOP">
			<table border="0" cellspacing="0" cellpadding="0" align="CENTER" class="loggedinScreen">
				<cfoutput>
					<tr>
						<td align="left" height="30"><span class="pix13">Total players</span></td>		
						<td align="RIGHT"><span class="pix13">#QPlayersCount.cnt#</span></td>
					</tr>
					<tr>
						<td  align="left" height="30"><span class="pix13">Total registrations</span></td>		
						<td align="RIGHT"><span class="pix13">#QRegistrationsCount.cnt#</span></td>
					</tr>
					<tr>
						<td  align="left" height="30"><span class="pix13">Current registrations<BR>as at #DateFormat(Now(), 'DD/MM/YY')#</span></td>
						<td align="RIGHT"><span class="pix13">#QRegPlayersCount.cnt#</span></td>
					</tr>

					<tr>
						<td  align="left" height="30"><span class="pix13">Expired &amp; Future Registrations<BR>as at #DateFormat(Now(), 'DD/MM/YY')#</span></td>
						<td align="RIGHT"><span class="pix13">#QLapsedRegPlayersCount.cnt1#</span></td>
					</tr>

					<tr>
						<td  align="left" height="30"><span class="pix13">Players unregistered</span></td>
						<td align="RIGHT"><span class="pix13">#QUnregisteredPlayersCount.cnt#</span></td>
					</tr>
					
					<tr>
						<td  align="left" height="30"><span class="pix10">
						<a href="mailto:INSERT_EMAIL_HERE?subject=Please delete all unregistered players for #LeagueCode# apart from those players who have suspensions.">Email a request</a> to delete<br />all unregistered players apart from<br />those players who have suspensions</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					<tr>
						<td  align="left" height="30" valign="top"><span class="pix10"><a href="UnregPlayersForDeletion.cfm?LeagueCode=#LeagueCode#&ReqFilter=#request.filter#" target="_blank">click here</a> to see who will be deleted</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10bold"><a href="DateRange.cfm?LeagueCode=#LeagueCode#" target="_blank">click here</a> for Registrations, Deregistrations<br>or Transfers by Date Range</span></td>		
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10"><a href="UnusualRegistrations.cfm?LeagueCode=#LeagueCode#&RegType=B&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank">click here</a> to see Contract Registrations</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10"><a href="UnusualRegistrations.cfm?LeagueCode=#LeagueCode#&RegType=C&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank">click here</a> to see Short Loan Registrations</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10"><a href="UnusualRegistrations.cfm?LeagueCode=#LeagueCode#&RegType=D&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank">click here</a> to see Long Loan Registrations</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10"><a href="UnusualRegistrations.cfm?LeagueCode=#LeagueCode#&RegType=E&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank">click here</a> to see Work Experience Registrations</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10"><a href="UnusualRegistrations.cfm?LeagueCode=#LeagueCode#&RegType=G&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank">click here</a> to see Lapsed Registrations</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10"><a href="UnusualRegistrations.cfm?LeagueCode=#LeagueCode#&RegType=F&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank">click here</a> to see Temporary Registrations</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10"><a href="UnusualRegistrations.cfm?LeagueCode=#LeagueCode#&RegType=U&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank">click here</a> to see Under 18 Registrations</span></td>
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					
					<!--- 
					***********************************************************
					* commented out until I get the latest Rule12 spreadsheet *
					***********************************************************
					<cfif ListFind(CountiesList, "LondonMiddx") GT 0 >
						<tr>
							<td height="30" valign="bottom" bgcolor="yellow"><span class="pix10"><a href="CheckRule12SineDie.cfm?LeagueCode=#LeagueCode#" target="_blank">click here</a> for Rule 12 or Sine Die Check</span></td>
							<td align="right" bgcolor="yellow"><span class="pix13bold">NEW</span></td>
						</tr>
					</cfif>
					--->
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix10"><a href="CheckPlayerAppearances.cfm?LeagueCode=#LeagueCode#" target="_blank">click here</a> for Player Appearances Check</span></td>		
						<td align="RIGHT"><span class="pix13"></span></td>
					</tr>
					
					<cfif QCheckPDNW1.RecordCount GT 0>
						<tr>
							<td  align="left" height="10" valign="bottom"><span class="pix10"></span></td>
							<td  align="left" height="10" valign="bottom"><span class="pix10"></span></td>
						</tr>
						<tr>
							<td   align="left" bgcolor="red"><span class="pix10white"><a href="CheckPlayerDuplicateNoWarnings1.cfm?LeagueCode=#LeagueCode#">click here</a> to see #QCheckPDNW1.RecordCount# Suppressed Warnings of Duplicate Forename(s), Surname and Date of Birth</span></td>		
							<td align="RIGHT"><span class="pix13"></span></td>
						</tr>
					</cfif>
					<cfif QCheckPDNW2.RecordCount GT 0>
						<tr>
							<td  align="left" height="10" valign="bottom"><span class="pix10"></span></td>
							<td  align="left" height="10" valign="bottom"><span class="pix10"></span></td>
						</tr>
						<tr>
							<td   align="left" bgcolor="orange"><span class="pix10"><a href="CheckPlayerDuplicateNoWarnings2.cfm?LeagueCode=#LeagueCode#">click here</a> to see #QCheckPDNW2.RecordCount# Suppressed Warnings of Duplicate Forename(s) and Date of Birth</span></td>		
							<td align="RIGHT"><span class="pix13"></span></td>
						</tr>
					</cfif>
					<cfif QCheckPDNW3.RecordCount GT 0>
						<tr>
							<td  align="left" height="10" valign="bottom"><span class="pix10"></span></td>
							<td  align="left" height="10" valign="bottom"><span class="pix10"></span></td>
						</tr>
						<tr>
							<td   align="left" bgcolor="yellow"><span class="pix10"><a href="CheckPlayerDuplicateNoWarnings3.cfm?LeagueCode=#LeagueCode#">click here</a> to see #QCheckPDNW3.RecordCount# Suppressed Warnings of Duplicate Surname and Date of Birth</span></td>		
							<td align="RIGHT"><span class="pix13"></span></td>
						</tr>
					</cfif>
				</cfoutput>
				
				<cfif QTeamsWithNoPlayers.RecordCount GT 0>
					<tr>
						<td  align="left" height="30" valign="bottom"><span class="pix13"><u><cfoutput>#QTeamsWithNoPlayers.RecordCount#</cfoutput> Teams Without Registered Players</u></span></td>
					</tr>
				
					<cfoutput query="QTeamsWithNoPlayers">
						<tr>
							<td align="left"><span class="pix13">#TName#</span></td>
						</tr>
					</cfoutput>
				</cfif>
				
			</table>
		</td>
		<td  align="left" valign="TOP">
			<table border="1" cellspacing="0" cellpadding="4" align="CENTER">
					<tr>
						<td align="left"><span class="pix10"><cfoutput>#QRegPlayers2.RecordCount#</cfoutput> clubs</span></td>
						<td align="left"><span class="pix10">Current<br>Registrations</span></td>
					</tr>
			
				<cfoutput query="QRegPlayers2">
					<tr>
						<td align="left"><a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TID#&SortSeq=Name"><span class="pix10">#ClubName#</span></a></td>
						<td align="RIGHT"><span class="pix10">#PlayerCount#</span></td>
					</tr>
				</cfoutput>
			</table>
		</td>
		<cfif QRegPlayers3.RecordCount GT 0 >
		<td valign="TOP">
			<table border="1" cellspacing="0" cellpadding="4" align="CENTER">
					<tr>
						<td align="left" bgcolor="beige"><span class="pix10"><cfoutput>#QRegPlayers3.RecordCount#</cfoutput> clubs</span></td>
						<td align="left" bgcolor="beige"><span class="pix10">Expired<br>Registrations</span></td>
					</tr>
			
				<cfoutput query="QRegPlayers3">
					<tr>
						<td  align="left" bgcolor="beige"><a href="RegisteredList2.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TID#&SortSeq=Name"><span class="pix10">#ClubName#</span></a></td>
						<td  bgcolor="beige" align="RIGHT"><span class="pix10">#LapsedPendingCount#</span></td>
					</tr>
				</cfoutput>
			</table>
		</td>
		</cfif>
		<cfif QRegPlayers7.RecordCount GT 0 >
		<td valign="TOP">
			<table border="1" cellspacing="0" cellpadding="4" align="CENTER">
					<tr>
						<cfoutput>
						<td align="left" bgcolor="##FF20A0"><span class="pix10"><cfoutput>#QRegPlayers7.RecordCount#</cfoutput> clubs</span></td>
						<td align="left" bgcolor="##FF20A0"><span class="pix10">Future<br>Registrations</span></td>
						</cfoutput>
					</tr>
			
				<cfoutput query="QRegPlayers7">
					<tr>
						<td align="left" bgcolor="##FF20A0"><a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#TID#&SortSeq=Name"><span class="pix10">#ClubName#</span></a></td>
						<td bgcolor="##FF20A0" align="RIGHT"><span class="pix10">#FutureCount#</span></td>
					</tr>
				</cfoutput>
			</table>
		</td>
		</cfif>
		
	</tr>
</table>

<cfif ListFind("Silver",request.SecurityLevel) >
	<table>
		<tr>
			<cfoutput>
				<td align="left" height="30" bgcolor="silver">
					<span class="pix10">
						<strong>JAB Only</strong> <a href="JABDeleteAllRegistrations.cfm?LeagueCode=#LeagueCode#">Delete ALL Registrations</a> 
					</span>
				</td>
			</cfoutput>
		</tr>
	</table>
</cfif>
