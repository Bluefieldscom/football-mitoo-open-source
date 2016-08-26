<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif NOT StructKeyExists(form, "StateVector")>
	<!--- First time in --->
	<cfinclude template = "queries/qry_GetMiscID.cfm">

	<cfif GetMiscID.RecordCount IS NOT 1>
		<span class="pix14bold">Miscellaneous Division missing or invalid</span>
		<CFABORT>
	<cfelse>
		<cfset request.MiscID = GetMiscID.ID>
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.MiscID = request.MiscID>
		</cflock>
	</cfif>
	
	<cfinclude template="queries/qry_GetMiscDivision.cfm">

	<CFFORM ACTION="TransferTeamToMisc.cfm?LeagueCode=#LeagueCode#" METHOD="POST">
		<input type="Hidden" name="StateVector" value="1">
		<table width="100%" class="loggedinScreen">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5">
						<tr>
							<cfoutput>
							<td><span class="pix10bold">Choose the Division</span></td>
							</cfoutput>
							<td><select name="DivisionID" size="1">
								<cfoutput query="GetMiscDivision"><OPTION VALUE="#ID#">#LongCol#</OPTION></cfoutput>
								</select>
							</td>
						</tr>
						<tr align="CENTER">
							<cfoutput>
								<td colspan="2"><span class="pix13"><input type="Submit" name="Action" value="OK"></span></td>				
							</cfoutput>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</cfform>
<cfelseif StructKeyExists(form, "StateVector")>
	<cfif Form.StateVector IS 1>
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.MiscID = session.MiscID >
		</cflock>
		<cfinclude template="queries/qry_GetMiscTeamName.cfm">

		<CFFORM ACTION="TransferTeamToMisc.cfm?LeagueCode=#LeagueCode#" METHOD="POST">
			<input type="Hidden" name="StateVector" value="2">
			<input type="Hidden" name="DivisionID" value = <cfoutput>"#Form.DivisionID#"</cfoutput> >
			<cfset ThisDivisionID = Form.DivisionID >
			
			<table width="100%" class="loggedinScreen">
				<tr>
					<td align="CENTER">
						<table border="0" cellspacing="0" cellpadding="5">
							<tr align="CENTER">
								<cfoutput>
								<td><span class="pix10bold">Choose the Team</span></td>
								</cfoutput>
								<td><select name="CID" size="1">
									<cfoutput query="GetMiscTeamName"><OPTION VALUE="#CID#">#TeamName# #OrdinalName#</OPTION></cfoutput>
									</select>
								</td>
							</tr>
							<tr align="CENTER">
								<cfoutput>
									<td colspan="2"><span class="pix13"><input type="Submit" name="Action" value="OK"></span></td>				
								</cfoutput>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</cfform>
	
	<cfelseif Form.StateVector IS 2>	
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.MiscID = session.MiscID >
		</cflock>
		
		<cfset ThisDivisionID = request.MiscID >
		
		<cfinclude template="queries/upd_QMisc01.cfm">

		<cfinclude template="queries/qry_QMisc02.cfm">

		<cfset HomeIDList = ValueList(QMisc02.HomeID)>
		<cfset Maxx = #QMisc02.RecordCount#>
		<cfloop index="x" from="1" to="#Maxx#" step="1" >

			<cfinclude template = "queries/qry_QMisc03.cfm">
			<cfinclude template = "queries/qry_QGetIDMisc03.cfm">

			<cfif QGetIDMisc03.RecordCount IS 0>
				<cfinclude template = "queries/ins_QInsrtMisc03.cfm">
			</cfif>
			
			<cfinclude template = "queries/qry_QGetIDMisc03.cfm">
			<cfinclude template = "queries/upd_QUpdtMisc03.cfm">
		
		</cfloop>
		
		<cfinclude template = "queries/qry_QMisc04.cfm">

		<cfset AwayIDList = ValueList(QMisc04.AwayID)>
		<cfset Maxx = #QMisc04.RecordCount#>
		<cfloop index="x" from="1" to="#Maxx#" step="1" >
		
			<cfinclude template = "queries/qry_QMisc05.cfm">
			<cfinclude template = "queries/qry_QGetIDMisc05.cfm">

			<cfif QGetIDMisc05.RecordCount IS 0>
				<cfinclude template = "queries/ins_QInsrtMisc05.cfm">
			</cfif>
			
			<cfinclude template = "queries/qry_QGetIDMisc05.cfm">
			<cfinclude template = "queries/upd_QUpdtMisc05.cfm">			
		
		</cfloop>
		
		
		<cfset ThisDivisionID = Form.DivisionID >
		<cfinclude template="RefreshLeagueTable.cfm">
		<cfset ThisDivisionID = request.MiscID >
		<cfinclude template="RefreshLeagueTable.cfm">
		
	</cfif>
</cfif>
