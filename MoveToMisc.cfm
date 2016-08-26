<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif NOT StructKeyExists(form, "StateVector")>
	<!--- First time in --->
	<cfinclude template = "queries/qry_GetMiscID.cfm">
	<cfif GetMiscID.RecordCount IS 0 >
		<cfinclude template="queries/ins_Misc.cfm">
		<cfinclude template = "queries/qry_GetMiscID.cfm">
		<cfset request.MiscID = GetMiscID.ID>
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.MiscID = request.MiscID>
		</cflock>
	<cfelseif GetMiscID.RecordCount IS 1 >
		<cfset request.MiscID = GetMiscID.ID>
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.MiscID = request.MiscID>
		</cflock>
	<cfelse>
		<span class="pix14bold">Miscellaneous Division invalid. Please contact INSERT_EMAIL_HERE</span>
		<CFABORT>
	</cfif>
	<cfinclude template="queries/qry_GetFixtureInfo.cfm">
	<cfif QGetFixtureInfo.RecordCount IS NOT 1>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
	<cfform action="MoveToMisc.cfm?LeagueCode=#LeagueCode#" METHOD="POST">
		<cfoutput>
			<input type="Hidden" name="StateVector" value="1">
			<input type="Hidden" name="FID" value="#FID#">
			<input type="Hidden" name="FixtureDate" value="#QGetFixtureInfo.FixtureDate#">
			<input type="Hidden" name="HomeID" value="#QGetFixtureInfo.HomeID#">
			<input type="Hidden" name="AwayID" value="#QGetFixtureInfo.AwayID#">
			<input type="Hidden" name="DivisionName" value="#QGetFixtureInfo.DivisionName#">
			<input type="Hidden" name="DivisionID" value="#QGetFixtureInfo.DivisionID#">
		</cfoutput>
		<table width="100%" class="loggedinScreen">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="2">
						<tr>
							<td align="center">
							<cfoutput><span class="pix18realblack">
							
							<span class="pix24boldnavy">MOVING<br></span><span class="pix13boldblack">together with all its associated information 
							(referees, marks, appearances, goals, sportsmanship, attendance etc.)<br><br></span>
							 <span class="pix18boldblack">#DateFormat(QGetFixtureInfo.FixtureDate, 'DDDD, DD MMMM YYYY')#<br>
							  #QGetFixtureInfo.HomeTeamName# &nbsp; #QGetFixtureInfo.HomeGoals# &nbsp; v &nbsp; #QGetFixtureInfo.AwayGoals# &nbsp; #QGetFixtureInfo.AwayTeamName#</strong><br>
							  FROM: #QGetFixtureInfo.DivisionName#<br>
							  TO: Miscellaneous<br></span>
							 </cfoutput>
							 </td>
						</tr>
						
						<tr>
							<td><center><textarea name="ReasonForMove" cols="80" rows="1" wrap="virtual"></textarea></center></td>
						</tr>
						<tr>
							<td height="50" valign="top">
							<span class="pix10bold"><center>Enter above your name and the reason for the move to Miscellaneous</center></span>
							</td>
						</tr>
						
						<tr>
							<td align="left" bgcolor="white">
							<span class="pix18boldred">Please be careful. This move can't be easily reversed. If you want to expunge the complete playing record of a "Withdrawn" team then DO NOT use this form. 
							Please contact INSERT_EMAIL_HERE instead.</span>
							</td>
						</tr>
						
						<tr align="center" valign="bottom">
								<td height="60" align="center">
								<span class="pix13"><input type="Submit" name="Action" value="OK"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="pix13"><input type="Submit" name="Action" value="Cancel"></span>
								</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</cfform>
<cfelseif Form.StateVector IS 1 and form.Action IS "Cancel">
	<cfoutput>
		<cflocation url="UpdateForm.cfm?TblName=Matches&id=#form.FID#&HomeID=#form.HomeID#&AwayID=#form.AwayID#&DivisionID=#form.DivisionID#&LeagueCode=#LeagueCode#" addtoken="no">
	</cfoutput>
<cfelseif Form.StateVector IS 1 and form.Action IS "OK">
	<cfif Len(Trim(form.ReasonForMove)) LT 20>
		<cfoutput>
		<span class="pix18boldred">Name and Reason must be more than 20 characters. Press the Back button on your browser.</span>
		<cfabort>
		</cfoutput>
	</cfif>

	<cfoutput>
		<input type="Hidden" name="DivisionName" value="#form.DivisionName#">
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.MiscID = session.MiscID >
		</cflock>
		<cfset ThisDivisionID = request.MiscID >
		<!--- Home Team --->
		<cfinclude template = "queries/qry_QMisc003.cfm"> <!--- get the Constitution row for this HomeID --->
		<cfinclude template = "queries/qry_QGetIDMisc003.cfm"> <!--- get the Miscellaneous Constitution row corresponding to this TeamID and OrdinalID --->
		<cfif QGetIDMisc003.RecordCount IS 0> <!--- if the Miscellaneous Constitution row is not there then create it --->
			<cfinclude template = "queries/ins_QInsrtMisc003.cfm">
		</cfif>
		<cfinclude template = "queries/qry_QGetIDMisc003.cfm">
		<cfif QGetIDMisc003.RecordCount IS 0>
			<cfabort>
		</cfif>
		<!--- Away Team --->
		<cfinclude template = "queries/qry_QMisc005.cfm">
		<cfinclude template = "queries/qry_QGetIDMisc005.cfm">
		<cfif QGetIDMisc005.RecordCount IS 0>
			<cfinclude template = "queries/ins_QInsrtMisc005.cfm">
		</cfif>
		<cfinclude template = "queries/qry_QGetIDMisc005.cfm">
		<cfinclude template = "queries/upd_QUpdtMisc007.cfm">
		<cfset ThisDivisionID = Form.DivisionID >
		<cfinclude template="RefreshLeagueTable.cfm">
		<cfset ThisDivisionID = request.MiscID >
		<cfinclude template="RefreshLeagueTable.cfm">
		<cflocation url="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(form.FixtureDate, 'YYYY-MM-DD')#&LeagueCode=#LeagueCode#" addtoken="no">
	</cfoutput>
</cfif>
