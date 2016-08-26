

		<!--- 	get all the TeamInfo rows for this Club Umbrella so they can be listed --->
		
		<cfinclude template="queries/qry_QTeamInfo.cfm"> <!--- get TeamInfo and corresponding LeagueInfo columns: LeagueCodeYear, NameSort, SeasonName --->	
		<cfset fmTeamIDList = ValueList(QTeamInfo.fmTeamID)>
		<cfif ListLen(fmTeamIDList) IS 0>
			<cfset fmTeamIDList = ListAppend(fmTeamIDList, 0)>
		</cfif>
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="2" >
						<cfoutput>
							<td align="CENTER">
								<table border="0" cellspacing="0" cellpadding="2" >
									<tr align="center">
										<td align="justify" bgcolor="white" ><span class="pix10navy">umbrella<br>club name<td ></span><input name="ClubName" type="text" value="#ClubName#" size="30"> <span class="pix13">#ClubInfoID#</span></td>
									</tr>
									<tr align="center">
										<td align="justify" bgcolor="white" ><span class="pix10navy">location<td ></span><input name="Location" type="text" value="#Location#" size="30"> </td>
									</tr>

								</table>
							</td>
						</cfoutput>
					</table>
				</td>
			</tr>
		</table>
		
		<table width="100%">
			<tr>
				<cfoutput>
					<td align="CENTER">
						<table border="0" cellspacing="0" cellpadding="2" >
							<tr align="CENTER">
								<td colspan="1" align="center"><span class="pix13"><input type="Submit" name="Action" value="Update"></span></td>
								<td colspan="1" align="center"><span class="pix13"><input type="Submit" name="Action"  <cfif QTeamInfo.RecordCount IS 0 >value="Delete"<cfelse>value="Finished"</cfif>></span></td>
							</tr>
						</table>
					</td>
				</cfoutput>
			</tr>
		</table>


		<!---
								 ***********************************
								 * Table of Included TeamInfo rows *
								 ***********************************
		--->
							<table border="1" align="center" cellpadding="2" cellspacing="0">
								<cfif QTeamInfo.RecordCount GT 0>
									<tr>
										<td height="10" colspan="3" align="left" valign="middle"><span class="pix10">untick to exclude</span></td>
									</tr>
								</cfif>
								<cfoutput query="QTeamInfo" group="SeasonName">
								<tr>
									<td colspan="3" align="center"><span class="pix10bold">#QTeamInfo.SeasonName#</span></td>
								</tr>
								<cfoutput>
									<input type="Hidden" name="fmTeamID" value="#fmTeamID#">
									<input type="Hidden" name="TeamInfoID#CurrentRow#" value="#QTeamInfo.id#">
									<cfset ThisLeagueCodeYear = QTeamInfo.LeagueCodeYear>
									<cfinclude template="queries/qry_QTeamLongCol.cfm"> <!---  Identify the "fmnnnn" datasource, e.g. fm2004, and then get the Team LongCol e.g. "Reds United" --->	
									<tr>
										<td><span class="pix13"><input name="InclNo#CurrentRow#" type="checkbox" value="#CurrentRow#" checked ></span></td>
										<td><span class="pix13">#QTeamLongCol.LongCol#</span></td>
										<td><span class="pix13">#QTeamInfo.NameSort#</span></td>
									</tr>
								</cfoutput>
								</cfoutput>
								<cfoutput>
								<input name="IncludedCount" type="hidden" value="#QTeamInfo.RecordCount#">
								</cfoutput>
							</table>
							<cfinclude template="inclExemptTokens.cfm"> <!--- ExemptTokenList is a list of exempt tokens e.g. Wanderers, Athletic, Town, City, United, Rangers --->
							<cfset GoodTokenCount = 0 >
							<cfinclude template="inclFindOtherTeams.cfm"> <!--- Parse the name of this team and get all candidate "same club" teams from all leagues for this season --->
							<cfif GoodTokenCount IS 0 >
								<cfinclude template="inclFindOtherTeams2.cfm">
							</cfif>
							
							<cfinclude template="queries/qry_QDistinctToken.cfm"> <!--- CF created query in inclFindOtherTeams.cfm of distinct tokens used for parsing  --->
							<cfinclude template="queries/qry_QDistinctIgnoredToken.cfm"> <!--- CF created query in inclFindOtherTeams.cfm of distinct tokens to be ignored when parsing  --->	
						
		<!--- 
		**********************************************************
		* searched for ... *           * ignored ... *           *
		**********************************************************
		--->
		<table border="0" align="center" cellpadding="0" cellspacing="5" class="bg_white" >
			<tr>
				<cfif QDistinctToken.RecordCount GT 0 >
				<!--- searched for --->
				<td>
					<table border="1" align="center" cellpadding="2" cellspacing="0">
						<tr>
							<td><span class="pix13"><em>searched for ...</em></span></td> 
							<cfoutput query="QDistinctToken">
								<td><span class="pix13bold">#Token#</span></td> 
							</cfoutput>
						</tr>
					</table>
				</td>
				</cfif>
				<cfif QDistinctIgnoredToken.RecordCount GT 0 >
				<!--- ignored --->
				<td>
					<table border="1" align="center" cellpadding="2" cellspacing="0">
						<tr>
							<td><span class="pix13"><em>ignored ...</em></span></td> 
						<cfoutput query="QDistinctIgnoredToken">
								<td><span class="pix13bold">#IgnoredToken#</span></td> 
						</cfoutput>
						</tr>
					</table>
				</td>
				</cfif>
			</tr>
		</table>
						
						
						
		<!---
								 ************************************
								 * Table of Excluded TeamInfo rows  *
								 ************************************
		--->
		<!--- get the Excluded rows --->
		<cfinclude template="queries/qry_QfmTeamID.cfm"> <!--- CF created query in inclFindOtherTeams.cfm of distinct candidate teams that could be included in this club --->	
		<cfif QfmTeamID.RecordCount GT 5000>
			<table border="1" align="center" cellpadding="2" cellspacing="0" bgcolor="red" >
				<tr>
					<td height="10" colspan="4" align="left" valign="middle"><span class="pix10bold">too many records returned....</span></td>
				</tr>
			</table>
		<cfelse>
			<table border="1" align="center" cellpadding="2" cellspacing="0" class="bg_highlight">
				<cfif QfmTeamID.RecordCount GT 0>
					<tr>
						<td height="10" colspan="4" align="left" valign="middle"><span class="pix10">tick to include</span></td>
					</tr>
				</cfif>
				<cfset ExcludedCount = 0 >
				<cfoutput query="QfmTeamID">
					<!--- we have two lists of counties. One comes from the LeagueInfo record for the current Parent Club.
					The other comes from the (looped) candidate team. If there is a county common to both lists then present it, otherwise ignore it --->
						<cfset ExcludedCount = ExcludedCount + 1 > <!--- If there is a county common to both lists then present it, otherwise ignore it --->
						<tr>
							<input name="fmTeamID#ExcludedCount#" type="hidden" value="#fmTeamID#">
							<input name="LeagueInfoID#ExcludedCount#" type="hidden" value="#LeagueInfoID#">
							<td><span class="pix13"><input name="ExcludedCheckbox#ExcludedCount#" type="checkbox" value="1" ></span></td>
							<td><span class="pix13">#ClubName#</span></td> 
							<td><span class="pix13">#LeagueName#</span><br><span class="pix9">#Left(CountiesList,60)#<cfif Len(trim(CountiesList)) GT 60 > etc.</cfif></span></td> 
							<td><span class="pix13">#Season#</span></td>
						</tr>
				</cfoutput>
				<input name="ExcludedCount" type="hidden" value="<cfoutput>#ExcludedCount#</cfoutput>">
			</table>
		
			<input name="LeagueCodeYear" type="hidden" value="<cfoutput>#LeagueCodeYear#</cfoutput>">
			<input name="ClubNamePrefix" type="hidden" value="<cfoutput>#ClubNamePrefix#</cfoutput>">
			<table width="100%">
				<tr>
					<cfoutput>
						<td align="CENTER">
							<table border="0" cellspacing="0" cellpadding="2" >
								<tr align="CENTER">
									<td colspan="1" align="center"><span class="pix13"><input type="Submit" name="Action" value="Update"></span></td>
									<td colspan="1" align="center"><span class="pix13"><input type="Submit" name="Action"  <cfif QTeamInfo.RecordCount IS 0 >value="Delete"<cfelse>value="Finished"</cfif>></span></td>
								</tr>
							</table>
						</td>
					</cfoutput>
				</tr>
			</table>
		</cfif>
