<cfif NOT StructKeyExists(url, "TblName")>
	<span class="pix24boldred">Table name is missing! Aborting........</span>
	<CFABORT>
</cfif>
<cfinclude template="InclBegin.cfm">
<!--- This is what happens when the OK button is pressed.... --->
<CFSWITCH expression="#TblName#">
	<CFCASE VALUE="Constitution">
		<FORM ACTION="ConstitList.cfm" METHOD="POST">
			<cfoutput>
				<INPUT TYPE="HIDDEN" NAME="TBLNAME" VALUE="#TblName#">
				<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="#LeagueCode#">
			</cfoutput>
			<cfinclude template="queries/qry_GetDivisionInfo.cfm">
			
			<table width="100%" border="0" cellspacing="5" cellpadding="5">
				<tr>
					<td align="CENTER">
						<SELECT NAME="DivisionID" size="1" >
							<cfoutput query="GetDivisionInfo" >
								<OPTION VALUE="#CompetitionID#">#CompetitionDescription#</OPTION>
							</cfoutput>
						</select>
					</td>
				</tr>
				<tr>
					<td align="CENTER">
						<INPUT TYPE="Submit" NAME="Operation" VALUE="OK">
					</td>
				</tr>
			</table>
			
		</FORM>
	</CFCASE>
	
	<CFCASE VALUE="PitchAvailable">
	
		<cfif NOT StructKeyExists(url, "PA")>
			<span class="pix24boldred">PA parameter is missing! Aborting........</span>
			<CFABORT>
		</cfif>
	
		<FORM ACTION="PitchAvailableList.cfm" METHOD="POST">
			<cfoutput>
				<INPUT TYPE="HIDDEN" NAME="TBLNAME" VALUE="#TblName#">
				<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="#LeagueCode#">
			</cfoutput>
			
			<cfif url.PA IS "Team">
				<INPUT TYPE="HIDDEN" NAME="PA" VALUE="Team">
				<cfinclude template="queries/qry_GetTInfo.cfm">
				<table width="100%" border="0" cellspacing="5" cellpadding="5">
					<tr>
						<td align="CENTER">
							<SELECT NAME="TeamIDOrdinalID" size="1" >
								<cfoutput query="GetTInfo" >
									<option value="#TeamID#^#OrdinalID#">#TeamOrdinalDescription#</option>
								</cfoutput>
							</select>
						</td>
					</tr>
					<tr>
						<td align="CENTER">
							<INPUT TYPE="Submit" NAME="Operation" VALUE="OK">
						</td>
					</tr>
				</table>
			
			<cfelseif url.PA IS "Venue">
				<INPUT TYPE="HIDDEN" NAME="PA" VALUE="Venue">
				<cfinclude template="queries/qry_GetVInfo.cfm">
				<table width="100%" border="0" cellspacing="5" cellpadding="5">
					<tr>
						<td align="CENTER">
							<SELECT NAME="VenueID" size="1" >
								<cfoutput query="GetVInfo" >
									<OPTION VALUE="#VenueID#">#VenueDescription#</OPTION>
								</cfoutput>
							</select>
						</td>
					</tr>
					<tr>
						<td align="CENTER">
							<INPUT TYPE="Submit" NAME="Operation" VALUE="OK">
						</td>
					</tr>
				</table>
				
			<cfelse>
				<span class="pix24boldred">PA parameter is invalid! Aborting........</span>
				<CFABORT>
			</cfif>
			
			
		</FORM>
	</CFCASE>
	
	<CFCASE VALUE="FinesAndPayments">
		<span class="pix24boldred">Fines and Payments section is not available</span>
		<CFABORT>
		<!---
		CFFORM ACTION="AdminFineList.cfm" METHOD="POST"
		
		INPUT TYPE="HIDDEN" NAME="TBLNAME" VALUE="<cfoutput>#TblName#</cfoutput>"
		INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="<cfoutput>#LeagueCode#</cfoutput>"
		cfinclude template="InclFine01.cfm"
		/CFFORM
		--->
	</CFCASE>
	
	<CFCASE VALUE="Matches">
		<span class="pix24boldred">This should never happen......Aborting.........</span>
		<CFABORT>
	</CFCASE>
</CFSWITCH>
