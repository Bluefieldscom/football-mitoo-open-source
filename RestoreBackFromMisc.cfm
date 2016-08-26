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
	
	<cfinclude template="queries/qry_GetTheOriginalDivision.cfm">
	<cfform action="RestoreBackFromMisc.cfm?LeagueCode=#LeagueCode#" METHOD="POST">
		<input type="Hidden" name="StateVector" value="1">
		<table width="100%" class="loggedinScreen">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5">
						<tr>
							<cfoutput>
							<td><span class="pix10bold">Choose the ORIGINAL Division</span></td>
							</cfoutput>
							<td><select name="OriginalDivisionID" size="1">
								<cfoutput query="GetTheOriginalDivision"><OPTION VALUE="#ID#">#LongCol#</OPTION></cfoutput>
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
		<cfinclude template="queries/qry_GetWithdrawnTeamName.cfm">

		<CFFORM ACTION="RestoreBackFromMisc.cfm?LeagueCode=#LeagueCode#" METHOD="POST">
			<input type="Hidden" name="StateVector" value="2">
			<input type="Hidden" name="OriginalDivisionID" value = <cfoutput>"#Form.OriginalDivisionID#"</cfoutput> >
			
 			<table width="100%" class="loggedinScreen">
				<tr>
					<td align="CENTER">
						<table border="0" cellspacing="0" cellpadding="5">
							<tr align="CENTER">
								<cfoutput>
								<td><span class="pix10bold">Choose the (WITHDRAWN) Team</span></td>
								</cfoutput>
								<td><select name="CID" size="1">
									<cfoutput query="GetWithdrawnTeamName"><OPTION VALUE="#CID#">[#CID#] #TeamName# #OrdinalName#</OPTION></cfoutput>
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
		
		<cfset WithdrawnCID = form.CID >
		
		<!--- get the Miscellaneous Constitution row for the withdrawn team --->
		<!--- add it back into the constitution of its original division --->
		<!--- get the Constitution ID (NewCID) of the row we just inserted  --->
		<cfinclude template="queries/QRestore01.cfm">
		<!--- now correct the home and away fixtures with this NewCID --->
		
		<cfset ThisDivisionID = form.OriginalDivisionID >
		
		<cfinclude template="queries/upd_Restore02.cfm">
		
		
		<cfinclude template="RefreshLeagueTable.cfm">
		
		<!--- Tidy up (get rid of) any Miscellaneous constitution rows for teams with no Miscellaneous fixtures or results --->
		<cfinclude template="queries/qry_QPossibleID.cfm">
		<cfloop query="QPossibleID">
		
			<cfquery name="Step00645" datasource="#request.DSN#" >
			SELECT  
				ID as DeadID
			FROM 
				fixture 
			WHERE 
				LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND (HomeID = #PossibleID# OR AwayID = #PossibleID#)
			</cfquery>
			<cfif Step00645.RecordCount GE 1>
			
			<cfelse>
				<cfquery name="Step00645" datasource="#request.DSN#" >
					DELETE FROM Constitution 
					WHERE 
						LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
						AND ID = #QPossibleID.PossibleID#
				</cfquery>
			</cfif>
		</cfloop>
		
		<cfset ThisDivisionID = request.MiscID >
		<cfinclude template="RefreshLeagueTable.cfm">
		
	</cfif>

</cfif>
