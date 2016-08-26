<!--- called by RegistListForm.cfm and InclLookUp.cfm --->

<cfinclude template="queries/qry_QClubStuff.cfm">
<table border="1" cellpadding="2" cellspacing="0" bgcolor="white">

	<tr>
		<cfif QClubStuff.RecordCount IS 0>
			<td>
				<cfoutput>
					<span class="pix10">No competitions have been entered.</span>
				</cfoutput>
			</td>
		<cfelseif QClubStuff.RecordCount IS 1>
			<td>
				<cfoutput>
					<span class="pix10">One competition has been entered:</span>
				</cfoutput>
			</td>
		<cfelse>
			<td>
				<cfoutput>
					<span class="pix10">#QClubStuff.RecordCount# competitions have been entered:</span>
				</cfoutput>
			</td>
		</cfif>
	</tr>
	<cfoutput query="QClubStuff" group="ClubName">
		<cfset AllEmailString = "">
		<cfoutput group="OrdnlName">
			<tr bgcolor="beige">
				<td>
					<cfif #TRIM(OrdnlName)# IS "">
						<table border="0" align="center" cellpadding="3" cellspacing="0">
							<cfif HomeGuest IS "Guest">
								<tr>
									<td align="center"><span class="pix13bolditalic">#ClubName# <em>(First Team)</em> - GUEST TEAM </span></td>
								</tr>
							<cfelse>
								<tr>
									<td align="center"><span class="pix13boldnavy">#ClubName# <em>(First Team)</em></span></td>
								</tr>
							</cfif>
							<tr>
								<td>
									<table border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="beige">
										<tr>
											<td align="center" bgcolor="thistle"><span class="pix13boldnavy">To add, update or delete team details <cfif VenueAndPitchAvailable IS "Yes">and to see Pitch Availability calendar </cfif><a href="TeamDetailsUpdate.cfm?LeagueCode=#LeagueCode#&TID=#TeamID#&OID=#OrdinalID#"><u>click here</u></a></span></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					<cfelse>
						<table border="0" align="center" cellpadding="3" cellspacing="0">
							<cfif HomeGuest IS "Guest">
								<tr>
									<td align="center"><span class="pix13bolditalic"><em>#ClubName# #OrdnlName#</em> - GUEST TEAM</span></td>
								</tr>
							<cfelse>
								<tr>
									<td align="center"><span class="pix13boldnavy">#ClubName# #OrdnlName# </span></td>
								</tr>
							</cfif>
							<tr>
								<td>
									<table border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="beige">
										<tr>
											<td align="center" bgcolor="thistle"><span class="pix13boldnavy">To add, update or delete team details <cfif VenueAndPitchAvailable IS "Yes">and to see Pitch Availability calendar </cfif><a href="TeamDetailsUpdate.cfm?LeagueCode=#LeagueCode#&TID=#TeamID#&OID=#OrdinalID#"><u>click here</u></a></span></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</cfif>
				</td>
			</tr>
			
			<cfset ThisPA = "Team">
			<cfset ThisTeamID = QClubStuff.TeamID >
			<cfset ThisOrdinalID = QClubStuff.OrdinalID >
			<cfinclude template="queries/qry_TeamDetails.cfm">
			<cfif QTeamDetails.RecordCount GT 0>
				<tr bgcolor="beige">
					<td>
						<table border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="beige">
							<cfloop query="QTeamDetails">
								<cfinclude template="TeamDetailsLoop.cfm">
								<cfif Len(Trim(ThisEmailString)) GT 0>
									<cfset AllEmailString = "#AllEmailString##ThisEmailString#," >
								</cfif>
							</cfloop>
						</table>
					</td>
				</tr>
			</cfif>
			
			<cfoutput>
				<tr>
					<td>
						<span class="pix10">#QClubStuff.CurrentRow#. #DivnName#</span>
					</td>
				</tr>
			</cfoutput>
		</cfoutput>
		<cfset LenAllEmailString = Len(Trim(AllEmailString))>
		<cfif LenAllEmailString GT 0>
			<cfset AllEmailString = Left(AllEmailString, (LenAllEmailString-1))>
			<tr>
				<td>
					<table border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="beige">
						<tr>
							<td height="40" colspan="2" align="center"><span class="pix10bold">#TN#<br><a href="mailto:#AllEmailString#?subject=#TN# - #LN#">Email All Contacts</a></span></td>
						</tr>
					</table>
				</td>
			</tr>
		</cfif>
								
	</cfoutput>
</table>


