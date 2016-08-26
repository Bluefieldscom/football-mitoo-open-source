<cfsilent>
<!--- New November 2009 "football.mitoo is evolving" interrupt screen  
<cfinclude template="InclfmEvolving.cfm">

    New January 2010 "football.mitoo is evolving" interrupt screen  
<cfinclude template="InclfmEvolving2.cfm">
--->

<!--- I added this in Nov. 2001 so that if another website links directly to a News.cfm page they will go
back to the appropriate county on clicking on the football.mitoo logo --->
<cfinclude template="queries/qry_QGetRelevantCounty.cfm">

<!--- Today's date and suppresses the Division name, too.... --->
<cfset MDate = DateFormat( Now() , "DDDD, DD MMMM YYYY") >

<cfif QGetRelevantCounty.RecordCount GT 0>
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.County = "#GetToken(QGetRelevantCounty.CountiesList,1,',')#" >
	</cflock>
<cfelse>
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.County = "LondonMiddx">
	</cflock>
</cfif>

</cfsilent>

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">
<cfif StructKeyExists(url, "NB") IS "Yes" OR  StructKeyExists(form, "NB") IS "Yes" >
<cfelse>
	<cflocation url="Noticeboard.cfm?countieslist=#countieslist#&LeagueCode=#LeagueCode#" addtoken="no">
</cfif>

<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cfinclude template="BroadcastImportantMessageToAdministrators.cfm">
</cfif>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<cfinclude template="InclNewsTopSectionFIX.cfm">
		</td>
	</tr>
</table>
<!---                                       
                                        **************************************
                                        *  Show Yellow League Reports menu?  *
                                        **************************************
--->
<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cfoutput>
		<table width="100%" border="1" cellspacing="0" cellpadding="2" align="center" class="loggedinScreen">
			<tr valign="top" bgcolor="Yellow">
				<td width="50%" align="center">
					<table width="100%" border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td align="center">
								<span class="pix18bold">League Reports</span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="pix13bold">Referees' Availability <a href="RefereesAvailability.cfm?LeagueCode=#LeagueCode#">by Date</a></span>
								<span class="pix13bold"> or <a href="RefereesAvailability2.cfm?LeagueCode=#LeagueCode#">by Name</a></span>
							</td>
						</tr>	
						<tr>
							<td>
								<span class="pix13bold"><a href="ListOfReferees.cfm?LeagueCode=#LeagueCode#">List of Referees</a></span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="pix13bold"><a href="RefAnalysis.cfm?LeagueCode=#LeagueCode#">Referee Coverage</a></span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="pix13bold">Fixtures and Referee Appointments <a href="RefAppointsXLS.cfm?LeagueCode=#LeagueCode#">Microsoft Excel Report</a></span>
							</td>
						</tr>	
						<tr>
							<td>
								<span class="pix10">Fixtures and Referee Appointments: 
								<a href="RefAppoints.cfm?LeagueCode=#LeagueCode#">Report 1</a> 
								<a href="FixturesTxt.cfm?LeagueCode=#LeagueCode#" target="_blank">Report 2</a> 
								<!--- <a href="RefAppointsInWord.cfm?LeagueCode=#LeagueCode#">Microsoft Word format</a></span> --->
							</td>
						</tr>	
						<cfif DefaultGoalScorers IS "Yes">
							<tr>
								<td>
									<span class="pix13bold"><a href="SeeGoalscorers.cfm?LeagueCode=#LeagueCode#">List of Goalscorers</a></span>
								</td>
							</tr>
						</cfif>
						
						<!--- applies to season 2012 onwards only --->
						<cfif RIGHT(request.dsn,4) GE 2012>
							<tr>
								<td align="center"><cfinclude template="RefereeListForm.cfm"></td>
							</tr>
						</cfif>
						
					</table>
				</td>
				<td width="50%" align="center" bgcolor="Beige">
					<table width="100%" border="0" cellpadding="2" cellspacing="2"> 
						<tr>
							<td align="center">
								<span class="pix18bold">Team Reports</span>
							</td>
						</tr>
						<tr>
							<td><cfinclude template="RegistListForm.cfm"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</cfoutput>
</cfif>

<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<!---                                       
											**************************************
											*  Show Administration Reports menu  *
											**************************************
	--->
	
	<cfinclude template="AdministrationReportsMenu.cfm">
	

	<!---                                       
											*****************************
											*  Show the JAB Only menu?  *
											*****************************
	--->
	<cfif ListFind("Silver",request.SecurityLevel) >
		<cfinclude template="inclShowJABOnly.cfm">
	</cfif>
	
	<cfinclude template="queries/qry_QOldFixtures.cfm">
	<cfinclude template="queries/qry_FixturesMissingKORound.cfm">
							<!--- JAB temp --->
	<cfinclude template="queries/qry_SuspectGuestTeams.cfm">
	
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
	
		<tr bgcolor="red">
			<cfif QFixturesMissingKORound.RecordCount GT "0">
				<td align="center" valign="top">
					<span class="pix18boldwhite">
						<cfoutput>
							<cfif QFixturesMissingKORound.RecordCount GT "1">
								WARNING - #QFixturesMissingKORound.RecordCount# fixtures with missing Knock Out Round<BR>
							<cfelse>
								WARNING - #QFixturesMissingKORound.RecordCount# fixture with missing Knock Out Round<BR>
							</cfif>
						</cfoutput>
					</span>
					<br>
					<span class="pix18boldwhite">Please immediately click on these fixtures to specifiy the KO Round.<br></span>
					
					<cfoutput query="QFixturesMissingKORound" group="DivName">
						<span class="pix13boldwhite"><br><br>#DivName#<br></span>
						<cfoutput group="FixtureDate">
							<span class="pix13boldwhite">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#<br></span>
							<cfoutput>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(FixtureDate,'YYYY-MM-DD')#&DivisionID=#DID#&LeagueCode=#LeagueCode#&Whence=MD&fmTeamID=#TID#"><span class="pix13bold">#HomeTeamName# v #AwayTeamName#</span></a><br>
							</cfoutput>
						</cfoutput>
					</cfoutput>
				</td>
			</cfif>
		</tr>
		<tr>
			<cfif QOldFixtures.RecordCount GT "0">
				<td valign="top" align="left" >
					<span class="pix18boldred">
						<cfoutput>
							<cfif QOldFixtures.RecordCount GT "1">
								AUTOMATIC WARNING - #QOldFixtures.RecordCount# fixtures with missing results.<BR>
							<cfelse>
								AUTOMATIC WARNING - #QOldFixtures.RecordCount# fixture with missing result.<BR>
							</cfif>
						</cfoutput>
					</span>
					<BR>
					<span class="pix10boldred">If a fixture is awaiting a disciplinary decision then please enter an explanatory note.<br>
					To ignore a fixture put </span><span class="pix10boldrealblack">NoAutomaticWarning</span><span class="pix10boldred"> in the PRIVATE Notes area.<br><br><br></span>
					
					<cfoutput query="QOldFixtures" group="FixtureDate">
						<span class="pix18bold">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#<BR></span>
						<cfoutput group="DivName">
							<span class="pix13bold">#DivName#<BR></span>
							<cfoutput>
								<span class="pix13">#HomeTeam# #HomeOrdinal# v #AwayTeam# #AwayOrdinal#	<cfif TRIM(#RoundName#)IS NOT "" > [ #RoundName# ]</cfif></span>
								<span class="pix13boldnavy"><cfif Result IS "P">Postponed<cfelseif Result IS "Q">Abandoned</cfif><br /></span>
								<cfif TRIM(#FixtureNotes#)IS NOT "" >
									<span class="pix10">#FixtureNotes#<BR></span>
								</cfif>
							</cfoutput>
						</cfoutput>
					</cfoutput>
				</td>
			</cfif>
	
							<!--- JAB temp --->
			<cfif QSuspectGuestTeams.RecordCount GT "0">
				<cfoutput><span class="pix24boldred">#QSuspectGuestTeams.RecordCount# SUSPECT GUEST TEAMS</span><br></cfoutput>
				<cfoutput query="QSuspectGuestTeams">
					<span class="pix18boldred">#Longcol#</span><br>
				</cfoutput>
			</cfif>
	
			<td valign="top">
			<cfif ListFind("Silver",request.SecurityLevel) >
				<cfinclude template="BroadcastMessageToAdministrators.cfm">
			</cfif>
			</td>
		</tr>
	</table>
</cfif>	
