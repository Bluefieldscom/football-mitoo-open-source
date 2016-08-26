<!--- Need to be logged in to see this report --->
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>



<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!--- ========================================================================= StateVector is missing - first time in ========================================== --->
<cfif NOT StructKeyExists(form, "StateVector") AND NOT StructKeyExists(url, "fmTeamID")>
<!--- First time in --->
	<!--- do some housekeeping - are there teaminfo rows for a club without at least one teaminfo row for the "current" season i.e. 2009 --->
	<cfquery name="housekeeping03" datasource="zmast">
		SELECT
			clubname, ti.clubinfoid,  MAX(LeagueCodeYear) 
		FROM
			teaminfo ti, leagueinfo li, clubinfo ci 
		WHERE  
			ti.clubinfoid=ci.id and ti.LeagueinfoID=li.ID 
		GROUP BY
			ci.id
		HAVING 
			MAX(LeagueCodeYear) < 2009
		ORDER BY 
			clubname
	</cfquery>
	<table width="50%" border="1" align="center" cellpadding="2" cellspacing="2">
		<cfif housekeeping03.recordcount GT 0>
			<tr>
				<td colspan="2"><span class="pix13">Warning: these club umbrellas don't have any teaminfo rows for 2009 </span></td> 
			</tr>
		</cfif>	
		<cfoutput query="housekeeping03">
			<tr>
				<td><span class="pix13">#clubinfoid#</span></td> 
				<td><span class="pix13">#clubname#</span></td>
			</tr>
			<!---
			<cfquery name="housekeeping03delete" datasource="zmast">
				 DELETE FROM clubinfo WHERE ID = #housekeeping03.clubinfoid# 
			</cfquery>
			--->
		</cfoutput>
	</table>
	<!--- do some housekeeping - delete clubinfo parents without teaminfo children --->
	<cfquery name="housekeeping01" datasource="zmast">
		SELECT
			id,
			clubname
		FROM
			clubinfo
		WHERE
			id NOT IN(SELECT clubinfo.id FROM clubinfo, teaminfo WHERE clubinfo.id=teaminfo.clubinfoid)
		ORDER BY
			clubname, id
	</cfquery>
	<table width="50%" border="1" align="center" cellpadding="2" cellspacing="2">
		<cfif housekeeping01.recordcount GT 0>
			<tr>
				<td colspan="2"><span class="pix13">Housekeeping: <cfoutput>#housekeeping01.recordcount#</cfoutput> clubinfo parent(s) without teaminfo children have been deleted</span></td> 
			</tr>
		</cfif>	
		<cfoutput query="housekeeping01">
			<tr>
				<td><span class="pix13">#id#</span></td> 
				<td><span class="pix13">#clubname#</span></td>
			</tr>
			<cfquery name="housekeeping01delete" datasource="zmast">
				DELETE FROM clubinfo WHERE ID = #housekeeping01.ID#
			</cfquery>
		</cfoutput>
	</table>
	<!--- do some more housekeeping - delete teaminfo children without clubinfo parents  --->
	<cfquery name="housekeeping02" datasource="zmast">
		SELECT
			id, clubinfoid
		FROM
			teaminfo
		WHERE
			clubinfoid NOT IN(SELECT clubinfo.id FROM clubinfo, teaminfo WHERE clubinfo.id=teaminfo.clubinfoid)
		ORDER BY
			id, clubinfoid
	</cfquery>
	<table width="50%" border="1" align="center" cellpadding="2" cellspacing="2" >
		<cfif housekeeping02.recordcount GT 0>
			<tr>
				<td colspan="2"><span class="pix13">Housekeeping: <cfoutput>#housekeeping02.recordcount#</cfoutput> teaminfo child(ren) without clubinfo parents have been deleted</span></td> 
			</tr>
		</cfif>	
		<cfoutput query="housekeeping02">
			<tr>
				<td><span class="pix13">#id#</span></td> 
				<td><span class="pix13">#clubinfoid#</span></td>
			</tr>
			<cfquery name="housekeeping01delete" datasource="zmast">
				DELETE FROM teaminfo WHERE ID = #housekeeping02.ID#
			</cfquery>
		</cfoutput>
	</table>
	
	
	
	
	
	
	
	
	
	
	
	<form ACTION="GatherTeamsUnderClubProcess2.cfm?LeagueCode=<cfoutput>#LeagueCode#</cfoutput>" METHOD="POST">
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5" style="bg_pink">
						<tr>
							<td align="center"><span class="pix10">Year <input name="Year" type="text" value="2009" size="4" maxlength="4"></span></td>
							<td align="center"><span class="pix10">Club Name Prefix e.g. Act <input name="ClubNamePrefix" type="text" value="" size="6" maxlength="6"></span></td>
							<td align="center"><span class="pix13"><input type="Submit" name="Action" value="OK"></span></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type="Hidden" name="StateVector" value="1">
	</form>
<!--- ========================================================================= chosen a year and prefix, or "Finished", or "Delete" ================= --->
<cfelseif (StructKeyExists(form, "StateVector") AND form.StateVector IS 1 AND form.Action IS "OK") 
			OR (StructKeyExists(form, "Action") AND form.Action IS "Finished") 
			OR (StructKeyExists(form, "Action") AND form.Action IS "Delete")>
			
			<cfif form.Action IS "Delete">
				<cfinclude template="queries/del_DelClubInfo.cfm">   <!--- delete the Parent row in the ClubInfo table   --->
			</cfif>	
	<form ACTION="GatherTeamsUnderClubProcess2.cfm?LeagueCode=<cfoutput>#LeagueCode#</cfoutput>" METHOD="POST">
		<table width="100%" >
			<cfoutput>
				<tr>
					<td align="CENTER">
						<table border="0" cellspacing="0" cellpadding="5" style="bg_pink">
							<tr>
								<td align="center"><span class="pix10">Year <input name="Year" type="text" value="#form.Year#" size="4" maxlength="4"></span></td>
								<td align="center"><span class="pix10">Club Name Prefix e.g. Act <input name="ClubNamePrefix" type="text" value="#form.ClubNamePrefix#"  size="6" maxlength="6"></span></td>
								<td align="center"><span class="pix13"><input type="Submit" name="Action" value="OK"></span></td>
							</tr>
						</table>
					</td>
				</tr>
			</cfoutput>
		</table>
		<cfif NOT (form.Year GT "2000" AND form.Year LT "2010")>
			<span class="pix13boldred">ERROR: Year must be between "2001" and "2009"</span>
			<cfset StructDelete(form, "StateVector")>
		<cfelseif form.ClubNamePrefix IS "">
			<cfset StructDelete(form, "StateVector")>
			<span class="pix13boldred">ERROR: missing Club Name Prefix</span>
		<cfelse>
			<cfinclude template="queries/qry_QUmbrella.cfm">
			<table width="100%" border="1" cellpadding="2" cellspacing="2" >
				<tr>
					<td><span class="pix10bold">Team</span></td>
					<td bgcolor="lightblue"><span class="pix10bold">Umbrella Club Name</span></td>
					<td bgcolor="lightblue"><span class="pix10bold">Umbrella Club ID</span></td>
					<td><span class="pix10bold">League/Competition</span></td>
					<td><span class="pix10bold">League Code</span></td>
				</tr>
				<cfoutput query="QUmbrella">
					<tr>
						<cfif cid IS "">
							<td><span class="pix13"><a href="GatherTeamsUnderClubProcess2.cfm?LeagueCode=#LeagueCode#&fmTeamID=#fmTeamID#&LgCode=#LgCode#&Year=#form.Year#&Action=Yes&ClubNamePrefix=#form.ClubNamePrefix#">#teamname#</a></span></td>
							<td><span class="pix13">#umbrella_clubname#</span><cfif Len(Trim(location)) GT 0><span class="pix10bold"> [#location#]</span></cfif></td>
							<td><span class="pix13">#cid#</span></td>
						<cfelse>
							<td><span class="pix13bold"><a href="GatherTeamsUnderClubProcess2.cfm?LeagueCode=#LeagueCode#&fmTeamID=#fmTeamID#&LgCode=#LgCode#&Year=#form.Year#&ClubInfoID=#cid#&Action=Yes&ClubNamePrefix=#form.ClubNamePrefix#">#teamname#</a></span></td>
							<td bgcolor="lightblue"><span class="pix13">#umbrella_clubname#</span><cfif Len(Trim(location)) GT 0><span class="pix10bold"> [#location#]</span></cfif></td>
							<td bgcolor="lightblue"><span class="pix13">#cid#</span></td>
						</cfif>
						<td><span class="pix13">#league#</span><br><span class="pix9">#countieslist#</span></td>
						<td><span class="pix13">#LgCode#</span></td>
					</tr>
				</cfoutput>
			</table>
		</cfif>
		<input type="Hidden" name="StateVector" value="1">
	</form>
<!--- ======================================================= clicked on a href link in a list, for an existing club umbrella or not ===================================== --->
<cfelseif StructKeyExists(url, "Action") AND url.Action IS "Yes">
	<cfif StructKeyExists(url, "ClubInfoID")> <!--- we are dealing with an existing club umbrella --->
		<cfset umbrella = "old">
	<cfelse>
		<cfset umbrella = "new">
	</cfif>
	<form ACTION="GatherTeamsUnderClubProcess2.cfm?LeagueCode=<cfoutput>#LeagueCode#</cfoutput>" METHOD="POST">
		<cfif umbrella IS "old">
			<cfinclude template="queries/qry_QUmbrellaName.cfm">
			<cfif QUmbrellaName.RecordCount IS 1>
				<cfset ClubName = QUmbrellaName.ClubName >
				<cfset Location = QUmbrellaName.Location >
				<cfset ClubInfoID = QUmbrellaName.ID >
			<cfelse>
				QUmbrellaName.RecordCount error
				<cfabort>
			</cfif>
		<cfelse> <!--- umbrella IS "new" --->
			<cfinclude template="queries/qry_QClubName2.cfm">
			<cfif QClubName2.RecordCount IS 1>
				<cfset ClubName = QClubName2.ClubName >
			<cfelse>
				QClubName2.RecordCount error
				<cfabort>
			</cfif>
			
			<cfquery name="Qtryout" datasource="zmast" >
				SELECT
					id,
					location,
					ClubName
				FROM
					clubinfo
				WHERE
					ClubName = '#ClubName#'
			</cfquery>
			<cfif Qtryout.RecordCount IS 1>
				<cfset ClubInfoID = Qtryout.id >
				<cfset location = Qtryout.location >
			<cfelse>
				<cfinclude template="queries/ins_ClubInfo2.cfm"> <!--- insert the new ClubInfo record --->
				<cfinclude template="queries/qry_QUmbrellaID.cfm"> <!--- get the new ClubInfo record --->
				<cfif QUmbrellaID.RecordCount IS 1>
					<cfset ClubInfoID = QUmbrellaID.ID >
					<cfset ClubName = QUmbrellaID.ClubName >
					<cfset Location = QUmbrellaID.Location >
				<cfelse>
					QUmbrellaID.RecordCount error <cfoutput>#QUmbrellaID.RecordCount#</cfoutput>
					<cfabort>
				</cfif>
				
			</cfif>
		</cfif>
		<cfinclude template="inclUmbrella.cfm">
		<input type="Hidden" name="StateVector" value="1">
		<cfoutput>
		<input type="Hidden" name="ClubInfoID" value="#ClubInfoID#">
		<input type="Hidden" name="Year" value="#url.Year#">
		
		</cfoutput>
</form>
<!--- ======================================================= clicked on Update button ===================================== --->
<cfelseif StructKeyExists(form, "Action") AND form.Action IS "Update">

	<cfinclude template="queries/upd_ClubInfo.cfm"> <!--- update the name & location of the Umbrella club in case they were changed --->

	<form ACTION="GatherTeamsUnderClubProcess2.cfm?LeagueCode=<cfoutput>#LeagueCode#</cfoutput>" METHOD="POST">

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
			<cfinclude template="inclUmbrella.cfm">
		<input type="Hidden" name="StateVector" value="1">
		<cfoutput>
		<input type="Hidden" name="ClubInfoID" value="#ClubInfoID#">
		<input type="Hidden" name="Year" value="#form.Year#">
		
		</cfoutput>
</form>
						
			
			

<!--- ========================================================================= otherwise unexpected combination .... ======================= --->
<cfelse>
	<cfdump var="#form#">
	<cfabort>			
</cfif>
