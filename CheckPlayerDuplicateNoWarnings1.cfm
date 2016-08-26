<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset BatchInput = "No">
<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">
<table width="100%" border="1" cellspacing="0" cellpadding="2" align="CENTER" class="loggedinScreen">
	<tr bgcolor="ivory">
		<td align="center" bgcolor="red"><span class="pix10bold"> </span></td>
		<td align="center"><span class="pix10bold">RegNo</span></td>
		<td align="center"><span class="pix10bold">Forename(s)</span></td>
		<td align="center"><span class="pix10bold">Surname</span></td>
		<td align="center"><span class="pix10bold">Date of Birth</span></td>
		<td align="center"><span class="pix10bold">Address and <em>Notes</em></span></td>
		<td align="center"><span class="pix10bold">Player</span></td>
		<td align="center"><span class="pix10bold">Current Registration</span></td>
		<td align="center"><span class="pix10bold">Appearances</span></td>
	</tr>
	<cfinclude template="queries/qry_QCheckPDNW1.cfm">
	<cfoutput query="QCheckPDNW1">
		<tr>
			<td height="60" align="center" bgcolor="red" rowspan="2" valign="middle"><a href="RemoveSuppressedWarning.cfm?LeagueCode=#LeagueCode#&ID=#WarningID#&Type=1"><span class="pix10white">Remove</span></a></td>
			<td align="center" rowspan="1" valign="middle"><span class="pix10">#RegNo1#</span></td>
			<td align="center" rowspan="2" valign="middle"><span class="pix10">#Forename1#</span></td>
			<td align="center" rowspan="2" valign="middle"><span class="pix10">#Surname1#</span></td>
			<td align="center" rowspan="2" valign="middle"><span class="pix10">#DateFormat(DoB1, "DD/MM/YYYY")#</span></td>
			<td width="400" align="center" rowspan="1" valign="middle">
				<span class="pix10">
					<!--- applies to season 2012 onwards only --->
					<cfif RIGHT(request.dsn,4) GE 2012>
						#AddressLine11#&nbsp;&##8226;&nbsp;#AddressLine12#&nbsp;&##8226;&nbsp;#AddressLine13#&nbsp;&##8226;&nbsp;#Postcode1#<br>
					</cfif>
					<em>#Notes1#</em>
				</span> 
			</td>
			<cfset ThisPID = #PID1# >
			<cfinclude template="queries/qry_GetRegistrationInfo.cfm">
			<td align="center" rowspan="1" valign="middle"><span class="pix10"><a href="UpdateForm.cfm?TblName=Player&ID=#ThisPID#&LeagueCode=#LeagueCode#"><u>Upd/Del</u></a></span></td>
			<cfif GetRegistrationInfo.ClubName IS ''>
				<td><span class="pix10">unregistered</span></td>
			<cfelse>
				<td><a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> since #DateFormat(GetRegistrationInfo.FirstDay,'DD/MM/YY')#</span></td>
			</cfif>
			<td align="center"><cfif GetAppearanceInfo.NumberOfAppearances GT 0><span class="pix18boldblack">#GetAppearanceInfo.NumberOfAppearances# </span><a href="PlayersHist.cfm?PI=#ThisPID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>see</u></span></a><cfelse><span class="pix10">-</span></cfif></td>
		</tr>
		<tr>
			<td align="center" rowspan="1" valign="middle"><span class="pix10">#RegNo2#</span></a></td>
			<td width="400" rowspan="1" align="center" valign="middle">
				<span class="pix10">
					<!--- applies to season 2012 onwards only --->
					<cfif RIGHT(request.dsn,4) GE 2012>
						#AddressLine21#&nbsp;&##8226;&nbsp;#AddressLine22#&nbsp;&##8226;&nbsp;#AddressLine23#&nbsp;&##8226;&nbsp;#Postcode2#<br>
					</cfif>
					<em>#Notes2#</em>
				</span> 
			</td>
			<cfset ThisPID = #PID2# >
			<cfinclude template="queries/qry_GetRegistrationInfo.cfm">
			<td align="center" rowspan="1" valign="middle"><span class="pix10"><a href="UpdateForm.cfm?TblName=Player&ID=#ThisPID#&LeagueCode=#LeagueCode#"><u>Upd/Del</u></a></span></td>
			<cfif GetRegistrationInfo.ClubName IS ''>
				<td><span class="pix10">unregistered</span></td>
			<cfelse>
				<td><a href="RegisteredList1.cfm?LeagueCode=#LeagueCode#&TblName=Register&TeamID=#GetRegistrationInfo.TID#&SortSeq=Name&PID=#ThisPID#"><span class="pix10bold"><u>#GetRegistrationInfo.ClubName#</u></span></a><span class="pix10"> since #DateFormat(GetRegistrationInfo.FirstDay,'DD/MM/YY')#</span></td>
			</cfif>
			<td align="center"><cfif GetAppearanceInfo.NumberOfAppearances GT 0><span class="pix18boldblack">#GetAppearanceInfo.NumberOfAppearances# </span><a href="PlayersHist.cfm?PI=#ThisPID#&LeagueCode=#LeagueCode#"><span class="pix10"><u>see</u></span></a><cfelse><span class="pix10">-</span></cfif></td>
		</tr>
		<tr bgcolor="ivory">
			<td height="3" colspan="9"></td>
		</tr>
	</cfoutput>
</table>
