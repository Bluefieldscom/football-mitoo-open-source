<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!--- ========================================================================= StateVector is missing - first time in ========================================== --->
<cfif NOT StructKeyExists(form, "StateVector")>
	<!--- First time in --->
	<cfinclude template="queries/qry_QGetCountyInfo.cfm"> <!--- get a list of all the County names in asc sequence - ignoring "TEST" --->
	<form ACTION="GatherTeamsUnderClub.cfm?LeagueCode=<cfoutput>#LeagueCode#</cfoutput>" METHOD="POST">
		<input type="Hidden" name="StateVector" value="1">
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5" style="bg_pink">
						<tr>
							<td><select name="CountyInfo" size="1">
								<cfoutput query="QGetCountyInfo"><option value="#ID#^#CountyName#">#CountyName#</option></cfoutput>
								</select>
							</td>
						</tr>
						<tr>
							<td align="center"><span class="pix13"><input type="Submit" name="Action" value="OK"></span></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
<!--- ========================================================================= StateVector IS 1 ========================================================== --->
<cfelseif StructKeyExists(form, "StateVector") AND Form.StateVector IS 1>

	<cfif StructKeyExists(form, "Action") AND form.Action IS "Add">
				<cfset ClubInfoID = GetToken(form.ClubInfo, 1, '^' ) >
		<cfset ClubName = GetToken(form.ClubInfo, 2, '^' ) >

			<cfinclude template="queries/ins_ClubInfo.cfm"> <!--- insert a new ClubInfo record --->
		</cfif>
	<!--- separate the components of the proposed CountyInfoID_CountyName using ^ as delimiter --->
	<cfset CountyInfoID = GetToken(form.CountyInfo, 1, '^' ) >
	<cfset CountyName = GetToken(form.CountyInfo, 2, '^' ) >
	<cfif StructKeyExists(form, "ClubInfo")>
		<cfset ThisClubName = GetToken(form.ClubInfo, 2, '^' ) >
	<cfelse>
		<cfset ThisClubName = "" >
	</cfif>
	<cfinclude template="queries/qry_QGetClubNames.cfm"> <!--- get all the ClubInfo records in ascending ClubName sequence for the current county --->
	<cfset ClubNameList = ValueList(QGetClubNames.ClubName)> 
	<cfif ListLen(ClubNameList) IS 0>
		<cfset ClubNameList = ListAppend(ClubNameList, 0)>
	</cfif>
		
	<form ACTION="GatherTeamsUnderClub.cfm?LeagueCode=<cfoutput>#LeagueCode#</cfoutput>" METHOD="POST">
		<input type="Hidden" name="StateVector" value="2">
		<input type="Hidden" name="CountyInfo" value=<cfoutput>"#CountyInfo#"</cfoutput> >
		<input type="Hidden" name="CountyInfoID" value=<cfoutput>"#CountyInfoID#"</cfoutput> >
		<input type="Hidden" name="CountyName" value=<cfoutput>"#CountyName#"</cfoutput> >
		<input type="Hidden" name="ClubNameList" value=<cfoutput>"#ClubNameList#"</cfoutput> >
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="2" >
						<tr align="center">
							<td><span class="pix13bold"><cfoutput>#CountyName#</cfoutput></span></td>
						</tr>
						<tr align="CENTER">
							<td><select name="ClubInfo" size="1">
								<cfoutput query="QGetClubNames">
									<option value="#ID#^#ClubName#" <cfif ClubName IS #ThisClubName#>selected</cfif> >#ClubName#</option>
								</cfoutput>
								<option value="x" disabled>===================</option>
								<option value="AddNewClub">add a new Parent Club</option>
								</select>
							</td>
						</tr>
						<tr align="CENTER">
							<cfoutput>
							<td align="center"><span class="pix13"><input type="Submit" name="Action" value="OK"></span></td>
							</cfoutput>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
<!--- ========================================================================= StateVector is 2 and adding a new Parent Club ============================ --->
<cfelseif StructKeyExists(form, "StateVector") AND Form.StateVector IS 2 AND StructKeyExists(form, "ClubInfo") AND form.ClubInfo IS "AddNewClub" >
	<!---
	******************************************************************************
	* show a list of potential new Parent Clubs, disabling existing Parent Clubs *
	******************************************************************************
	--->
	<cfinclude template="queries/qry_QClubList.cfm">   <!--- the same query as for ClubList.cfm, get Team records sorted in Guest, TeamName sequence ---> 
	<form ACTION="GatherTeamsUnderClub.cfm?LeagueCode=<cfoutput>#LeagueCode#</cfoutput>" METHOD="POST">
	<input type="Hidden" name="StateVector" value="1">
	<input type="Hidden" name="CountyInfoID" value=<cfoutput>"#CountyInfoID#"</cfoutput> >
	<input type="Hidden" name="CountyInfo" value=<cfoutput>"#CountyInfo#"</cfoutput> >
	<input type="Hidden" name="CountyName" value=<cfoutput>"#CountyName#"</cfoutput> >
	<input type="Hidden" name="ClubNameList" value=<cfoutput>"#ClubNameList#"</cfoutput> >
	<table width="100%">
		<tr>
			<td align="CENTER">
				<table border="0" cellspacing="0" cellpadding="2" >
					<tr align="center">
						<td><span class="pix13bold">adding a new Parent Club</span></td>
					</tr>
					<tr align="CENTER">
						<td><select name="ClubInfo" size="1">
							<cfoutput query="QClubList">
								<cfif RedundantTeam>
								<cfelseif Guest>
								<cfelseif ListFind(ClubNameList, LongCol)>
									<option value="x-" disabled>#LongCol#</option>
								
								<cfelse>
									<option value="#ID#^#LongCol#">#LongCol#</option>
								</cfif>
							</cfoutput>
							</select>
						</td>
					</tr>
					<tr align="CENTER">
						<td align="center"><span class="pix13"><input type="Submit" name="Action" value="Add"></span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</form>
<!--- ========================================================================= StateVector is 2 and not adding a new Parent Club ======================= --->
			
<cfelseif StructKeyExists(form, "StateVector") AND Form.StateVector IS 2 AND StructKeyExists(form, "ClubInfo") AND form.ClubInfo IS NOT "AddNewClub" >
	<!---
	**************************************
	* or chosen an existing Parent Club  *
	**************************************
	--->
	<cfoutput>
	<form ACTION="GatherTeamsUnderClub.cfm?LeagueCode=#LeagueCode#" METHOD="POST">
		<input type="Hidden" name="StateVector" value="2">
		<input type="Hidden" name="CountyInfoID" value="#CountyInfoID#" >
		<input type="Hidden" name="CountyInfo" value="#CountyInfo#" >
		<input type="Hidden" name="CountyName" value="#CountyName#" >
		<input type="Hidden" name="ClubInfo" value="#ClubInfo#" >
	</cfoutput>
		<cfset ClubInfoID = GetToken(form.ClubInfo, 1, '^' ) >
		<cfset ClubName = GetToken(form.ClubInfo, 2, '^' ) >
		
		<cfif StructKeyExists(form, "Action") AND form.Action IS "Finished" >
			<CFLOCATION URL="GatherTeamsUnderClub.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
		</cfif>
		
		<cfif StructKeyExists(form, "Action") AND form.Action IS "Delete" >
			<cfinclude template="queries/del_DelClubInfo.cfm">   <!--- delete the Parent row in the ClubInfo table   --->	
			<CFLOCATION URL="GatherTeamsUnderClub.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
		</cfif>
		
		<cfif StructKeyExists(form, "Action") AND form.Action IS "Update">
			<cfif StructKeyExists(form, "IncludedCount")>	
				<!--- Delete TeamInfo records corresponding to [unticked] rows in the "Included" table  --->
				<cfloop index="R" from="1" to="#IncludedCount#" step="1" >
					<cfif StructKeyExists(form, "InclNo#R#") >
					<!--- leave alone --->
					<cfelse>
						<cfset TeamInfoID = "TeamInfoID#R#" >
						<cfset TeamInfoID = Evaluate(TeamInfoID) >
						<cfinclude template="queries/del_DelTeamInfo.cfm">   <!--- delete this row in the TeamInfo table   --->	
					</cfif>
				</cfloop>
			</cfif>
			<cfif StructKeyExists(form, "ExcludedCount")>	
				<!--- Insert TeamInfo records corresponding to [ticked] rows in the "Excluded" table  --->
				<cfloop index="R" from="1" to="#ExcludedCount#" step="1" >
					<cfif StructKeyExists(form, "ExcludedCheckbox#R#") >
						<cfset fmTeamID = "fmTeamID#R#" >
						<cfset fmTeamID = Evaluate(fmTeamID) >
						<cfset LeagueInfoID = "LeagueInfoID#R#" >
						<cfset LeagueInfoID = Evaluate(LeagueInfoID) >
						<cfinclude template="queries/ins_InsrtTeamInfo.cfm">   <!--- insert a new row into the TeamInfo table   --->	
					</cfif>
				</cfloop>
			</cfif>
		</cfif>
		<!--- having just done any deletions and insertions in the code above, as a result of ticking/unticking, 
		get all the existing TeamInfo rows for this Club so they can be listed --->
		<cfinclude template="queries/qry_QTeamInfo.cfm"> <!--- get TeamInfo and corresponding LeagueInfo columns: LeagueCodeYear, NameSort, SeasonName --->	
		<cfset fmTeamIDList = ValueList(QTeamInfo.fmTeamID)>
		<cfif ListLen(fmTeamIDList) IS 0>
			<cfset fmTeamIDList = ListAppend(fmTeamIDList, 0)>
		</cfif>
		<table width="100%">
			<tr>
				<cfoutput>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="2" >
						<tr align="center">
							<td colspan="2" ><span class="pix13bold">#CountyName#</span></td>
						</tr>
						<tr align="center">
							<td colspan="2" ><span class="pix13bold">#ClubName#</span></td>
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
		<cfinclude template="inclFindOtherTeams.cfm"> <!--- Parse the name of this team and get all candidate "same club" teams from all leagues for this season --->
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
		<table border="1" align="center" cellpadding="2" cellspacing="0" class="bg_highlight">
			<cfif QfmTeamID.RecordCount GT 0>
				<tr>
					<td height="10" colspan="4" align="left" valign="middle"><span class="pix10">tick to include</span></td>
				</tr>
			</cfif>
			<cfset ExcludedCount = 0 >
			<cfoutput query="QfmTeamID">
				<cfset QCountiesList = QueryNew("County") >
				<cfloop index="County" list="#QfmTeamID.CountiesList#" delimiters="," >
				   <cfset temp = QueryAddRow(QCountiesList) >
				   <cfset temp = QuerySetCell(QCountiesList, "County", County) >
				</cfloop>
				<!--- we have two lists of counties. One comes from the LeagueInfo record for the current Parent Club.
				The other comes from the (looped) candidate team. If there is a county common to both lists then present it, otherwise ignore it --->
				<cfinclude template="queries/qry_QInTheSameCounty.cfm"> <!--- get the counties that are common to both lists --->	
				<cfif QInTheSameCounty.RecordCount GT 0>
					<cfset ExcludedCount = ExcludedCount + 1 > <!--- If there is a county common to both lists then present it, otherwise ignore it --->
					<tr>
						<input name="fmTeamID#ExcludedCount#" type="hidden" value="#fmTeamID#">
						<input name="LeagueInfoID#ExcludedCount#" type="hidden" value="#LeagueInfoID#">
						<td><span class="pix13"><input name="ExcludedCheckbox#ExcludedCount#" type="checkbox" value="1" ></span></td>
						<td><span class="pix13">#ClubName#</span></td> 
						<td><span class="pix13">#LeagueName#</span></td> 
						<td><span class="pix13">#Season#</span></td>
					</tr>
				</cfif>
			</cfoutput>
			<input name="ExcludedCount" type="hidden" value="<cfoutput>#ExcludedCount#</cfoutput>">
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
	</form>
<!--- ========================================================================= otherwise unexpected combination .... ======================= --->
<cfelse>
	<cfdump var="#form#">
	<cfabort>			
</cfif>
