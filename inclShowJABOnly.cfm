<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!---
<cfif leaguecodeyear GT 2007 >
	 check to see if any lk_constitution rows need to be removed (relevant only for seasons 2007 onwards 
	<cfinclude template="queries/qry_Qlk_constitution.cfm">	
	<cfif Qlk_constitution.RecordCount GT 0>
		<cfset lk_constitutionIDList = ValueList(Qlk_constitution.ID)>
		<table class="loggedinScreen">
			<cfoutput query="Qlk_constitution">
				<tr>
					<td><span class="pix10">#id#</span></td>
					<td><span class="pix10">#leaguecode#</span></td>
					<td><span class="pix10">#divisionname#</span></td>
					<td><span class="pix10">#TeamName#</span></td>
				</tr>
			</cfoutput>
			<cfoutput>
				<tr>
					<td><a href="DeleteLKID.cfm?LeagueCode=#LeagueCode#&InList=#lk_constitutionIDList#"><span class="pix13bold">Remove All</span></a></td>
				</tr>
			</cfoutput>
		</table>
	</cfif>
</cfif>
--->




<!--- report on any teams that should be guests --->
<cfinclude template="queries/qry_BadGuests.cfm">
<cfif QBadGuests.RecordCount GT "0">
	<table class="loggedinScreen">
		<cfoutput query="QBadGuests">
			<tr>
				<td align="left"><span class="pix18bold"><a href="ClubList.cfm?fmTeamID=#QBadGuests.TID#&LeagueCode=#LeagueCode#">#teamname#</a> should be a guest</span></td>
			</tr>
		</cfoutput>
	</table>
</cfif>
	
<!--- This query is used to see if there are any orphaned teamdetails rows  --->
<cfinclude template="queries/qry_QOrphanedTeamDetails.cfm">
<cfif QOrphanedTeamDetails.RecordCount GT 0>
	<cfoutput>
		<center><br><span class="pix24boldred">#QOrphanedTeamDetails.RecordCount# orphaned teamdetails rows. <a href="queries/del_OrphanedTeamDetails.cfm?LeagueCode=#LeagueCode#"><span class="pix24boldred">click here</a> to delete</span><br><br></center>
	</cfoutput>
</cfif>


<!--- Housekeeping --->
<!--- DELETE all rows in constitution table where the team name has " or " within it e.g. "Chelsea or Arsenal" UNLESS involved in a fixture --->
	<cfinclude template="queries/qry_OrTypeConstitution.cfm">
	<cfif QOrTypeConstitution.RecordCount GT 0>
		<cfoutput>
			<center><br><span class="pix18boldred">#QOrTypeConstitution.RecordCount#  " or " teams in constitution table not involved in a fixture. <a href="queries/del_OrTypeConstitution.cfm?LeagueCode=#LeagueCode#"><span class="pix24boldred">click here</a> to delete</span><br><br></center>
		</cfoutput>
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<cfoutput query="QOrTypeConstitution">
				<tr>
					<td><span class="pix10">#leaguecode#</span></td>
					<td><span class="pix10">#DivisionName#</span></td>
					<td><span class="pix10">#TeamName#</span></td>
					<td><span class="pix10">#OrdinalName#</span></td>
				</tr>
			</cfoutput>
		</table>
	</cfif>
<!--- DELETE all rows in team table where the team name has " or " within it e.g. "Chelsea or Arsenal" UNLESS involved in a constitution --->
	<cfinclude template="queries/qry_OrTypeTeam.cfm">
	<cfif QOrTypeTeam.RecordCount GT 0>
		<cfoutput>
			<center><br><span class="pix18boldred">#QOrTypeTeam.RecordCount#  " or " teams in team table not involved in a constitution. <a href="queries/del_OrTypeTeam.cfm?LeagueCode=#LeagueCode#"><span class="pix24boldred">click here</a> to delete</span><br><br></center>
		</cfoutput>
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<cfoutput query="QOrTypeTeam">
				<tr>
					<td><span class="pix10">#leaguecode#</span></td>
					<td><span class="pix10">#TeamName#</span></td>
				</tr>
			</cfoutput>
		</table>
	</cfif>

<!---                                       
                                        *****************************
                                        *  Show the JAB Only menu?  *
                                        *****************************
--->

<table width="600" border="0" align="center" cellpadding="10" cellspacing="0" bgcolor="silver" class="loggedinScreen">
	<tr>
		<td align="LEFT">
			<span class="pix24bold">JAB Only</span>						
		</td>
	</tr>
	<!---
	<tr>
		<td align="LEFT">
			<cfoutput>
				<a href="GatherTeamsUnderClubProcess2.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Club Umbrella Process</span></a><br />
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="LEFT">
			<cfoutput>
				<a href="ClubUmbrellaReport1.cfm?LeagueCode=#LeagueCode#&prefix=C"><span class="pix13bold">Club Umbrella Report 1 - Teams without an umbrella</span></a><br />
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="LEFT">
			<cfoutput>
				<a href="ClubUmbrellaReport2.cfm?LeagueCode=#LeagueCode#&prefix=Ca"><span class="pix13bold">Club Umbrella Report 2 - Clubs</span></a><br />
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="LEFT">
			<cfoutput>
				<a href="UmbrellaCompare.cfm?LeagueCode=#LeagueCode#"><span class="pix13bold">Umbrella Compare for #LeagueCodeYear#</span></a><br />
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="LEFT">
			<cfoutput>
				<a href="DTOCompare.cfm?LeagueCode=#LeagueCode#"><span class="pix13boldred">Division, Team and Ordinal Compare for #LeagueCodeYear#</span></a><br />
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="LEFT">
			<cfoutput>
				<a href="DTOCompare.cfm?LeagueCode=#LeagueCode#&Only=Yes"><span class="pix13boldred">#LeagueCode# only - Division, Team and Ordinal Compare for #LeagueCodeYear#</span></a><br />
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="LEFT">
			<cfoutput>
				<a href="testing01.cfm?LeagueCode=#LeagueCode#"><span class="pix13boldred">#LeagueCode# only Compare #LeagueCodeYear# with previous season</span></a><br />
			</cfoutput>
		</td>
	</tr>
	--->
	<tr>
		<td align="LEFT">
			<span class="pix13bold">
			<cfoutput>
			<a href="ROYWarnings.cfm?LeagueCode=#LeagueCode#">Red/Orange/Yellow Player Warnings</a> <br />
			<br />
			<a href="ListOfHiddenLeagues.cfm?LeagueCode=#LeagueCode#">List of Leagues for Season 2013-2014</a><br />
			<br />
			<a href="NewSeason.cfm?LeagueCode=#LeagueCode#">Create a new season from an existing season</a><br />
			<br />
			<a href="LoadFixturesAndResultsFromSpreadsheet.cfm?LeagueCode=#LeagueCode#">Load Fixtures and Results from Spreadsheet</a><br />
			<br />
			<a href="LoadPlayersAndRegistrationsFromSpreadsheet.cfm?LeagueCode=#LeagueCode#">Load Players and Registrations from Spreadsheet</a><br />
			<br />
			<a href="LoadRefereesFromSpreadsheet.cfm?LeagueCode=#LeagueCode#">Load Referees from Spreadsheet</a><br />
			<br />
			<a href="CommitteeDetailsXLS.cfm?LeagueCode=#LeagueCode#">Export #RIGHT(request.DSN,4)# Committee Details (Excel)</a><br />
			<br />
			<a href="ExportFixturesAndResultsXLS.cfm?LeagueCode=#LeagueCode#">Export #RIGHT(request.DSN,4)# Fixtures and Results (Excel)</a><br />
			<br /></span><span class="pix13boldblackongreen">
			<a href="ExportLightBlueXLS.cfm?LeagueCode=#LeagueCode#">LightBlue Export #RIGHT(request.DSN,4)# Committee Email Addresses (Excel)</a><br />
			
			<br />
			<a href="ExportYellowXLS.cfm?LeagueCode=#LeagueCode#">Yellow Export #RIGHT(request.DSN,4)# Team and Referee Email Addresses (Excel)</a><br />
			
			<br />
			<a href="ExportRegistrationOfInterestXLS.cfm?LeagueCode=#LeagueCode#">Registration of Interest (Excel)</a><br />

			<!---
			<cfset fmNewYYYY = "fm#NumberFormat((RIGHT(LeagueCode,4) + 1), '9999')#">
			<a href="HideLeagueCode.cfm?LeagueCode=#LeagueCode#&DS=#fmNewYYYY#">Hide #fmNewYYYY# tables where #request.filter#</a><br /><br />
			--->
			<br /></span><span class="pix13bold">
			<a href="SwapHomeAway.cfm?LeagueCode=#LeagueCode#&SwapFixtureID=0">Reverse fixture and swap Home and Away values</a><br />
			<a href="ChangeClubPassword.cfm?LeagueCode=#LeagueCode#&OldTeamID=0&NewTeamID=0">Change Club Password</a><br />
			<a href="LeaguesOnAlert.cfm?LeagueCode=#LeagueCode#">Leagues with Email alert when they log in</a><br />
			<a href="TransferTeamToMisc.cfm?LeagueCode=#LeagueCode#">Transfer team results to Miscellaneous Division</a><br />
			<a href="RestoreBackFromMisc.cfm?LeagueCode=#LeagueCode#">Restore team results back from Miscellaneous Division</a><br />
			<a href="RegistrationInfo.cfm?LeagueCode=#LeagueCode#">Registration of Interest</a><br />
			<a href="JLogInQuery.cfm?LeagueCode=#LeagueCode#">LogIn Query including Supervisor</a><br /><br />
			<a href="JLogInQuery.cfm?LeagueCode=#LeagueCode#&DeleteSupervisorTrail=Y">LogIn Query - Delete Supervisor Trail</a><br /><br />
			<a href="JLogInQuery2.cfm?LeagueCode=#LeagueCode#&DeleteSupervisorTrail=Y">LogIn Query - Delete Supervisor Trail - hide passwords</a><br /><br />
			<a href="JLogInQueryLimit.cfm?LeagueCode=#LeagueCode#&ThisLimit=10">LogIn Query - Specify Limit</a><br /><br />
			<a href="LeagueInfoUpdate.cfm?LeagueCode=#LeagueCode#">League Info. Update</a><br /><br />

			</cfoutput>
			</span>
		</td>
	</tr>
</table>

