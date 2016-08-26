<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
<!---         <cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) > -------------------- Julian needs to use this soon ---------->
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!---  for yellow security level check that the url.ID (referee's id) parameter and leaguecode parametere have not been tampered with.  --->
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cflock scope="session" timeout="10" type="readonly">
		<cfset request.YellowKey = session.YellowKey  >
	</cflock>
	<cfif url.ID IS "#Reverse(GetToken(Reverse(request.YellowKey),1,'|'))#" AND url.LeagueCode IS "#GetToken(request.YellowKey,1,'|')#">
		<!--- all OK --->
	<cfelse>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
</cfif>

<cfset variables.robotindex="no">
<!--- Use this one .cfm file to do all of the following:
ADD
UPDATE
DELETE
--->

<cfif NOT StructKeyExists(url, "ID")>
<!--- ADDING A NEW RECORD....... --->
    <cfset NewRecord = "Yes">
<cfelse>
<!--- UPDATING or DELETING A RECORD....... --->
	<cfif NOT StructKeyExists(url, "TblName")>
		Parameter TableName is missing! Aborting........
		<CFABORT>
	</cfif>
    <cfset NewRecord = "No">
</cfif>

<!--- include toolbars 1 & 2 --->
<cfinclude template="InclBegin.cfm">

<!--- This bit displays e.g. Adding Referee at the top of the screen WHITE on BLACK background--->
<cfif TblName IS "Matches">
<cfelse>
	<cfinclude template="inclTblBlack1.cfm">
</cfif>
<!--- SQL for populating the screen fields for Update/Delete --->
<cfif NewRecord IS "Yes">
<!--- do nothing here when Adding..... --->
<cfelse>
	<cfif TblName IS "Constitution">
	<cfelseif TblName IS "PitchAvailable">
	<cfelseif TblName IS "Register">
	<cfelseif TblName IS "Matches">
	<cfelseif TblName IS "Committee">
	<cfelseif TblName IS "Noticeboard">
		<cfset ThisTableName = "noticeboard">
		<cfif StructKeyExists(url, "OldAdverts")>
			<cfif url.OldAdverts IS "Y" >
				<cfset ThisTableName = "noticeboard_old">
			</cfif>
		</cfif>
		<cfinclude template="queries/qry_GetNoticeboard.cfm">
	<cfelseif TblName IS "Document">
		<cfinclude template="queries/qry_GetDocument.cfm">
	<cfelse>
		<cfinclude template="queries/qry_GetTblName.cfm">
	</cfif>
</cfif>

<!--- This is what happens when the Add/Update/Delete button is pressed.... --->
<CFFORM ACTION="Action.cfm" METHOD="post" name="terry" >
	<cfif TblName IS "Noticeboard" AND NewRecord IS "No">
		<INPUT TYPE="HIDDEN" NAME="ThisTableName" VALUE="<cfoutput>#ThisTableName#</cfoutput>">
	</cfif>
	<!--- pass Whence in a hidden field --->
	<cfif StructKeyExists(url, "Whence")>
		<INPUT TYPE="HIDDEN" NAME="Whence" VALUE="<cfoutput>#Whence#</cfoutput>">
	</cfif>
	<!--- pass Sort Order, S, in a hidden field --->
	<cfif StructKeyExists(url, "S")>
		<INPUT TYPE="HIDDEN" NAME="S" VALUE="<cfoutput>#S#</cfoutput>">
	</cfif>
	<!--- pass the TblName in a hidden field --->
	<INPUT TYPE="HIDDEN" NAME="TBLNAME" VALUE="<cfoutput>#TblName#</cfoutput>">
	<!--- pass the LeagueCode in a hidden field --->
	<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="<cfoutput>#LeagueCode#</cfoutput>">
	<!--- pass the ID in a hidden field --->
	<INPUT TYPE="HIDDEN" NAME="LeagueID" VALUE="<cfoutput>#request.LeagueID#</cfoutput>">
	
	<cfif NewRecord IS "Yes">
	<cfelse>
		<INPUT TYPE="HIDDEN" NAME="ID" VALUE="<cfoutput>#URL.ID#</cfoutput>">
	</cfif>
	<CFSWITCH expression="#TblName#">
		<CFCASE VALUE="Constitution">
			<cfinclude template="InclConstit02.cfm">
			<!--- pass the DivisionID in a hidden field --->
			<INPUT TYPE="HIDDEN" NAME="DivisionID" VALUE="<cfoutput>#DivisionID#</cfoutput>">
		</CFCASE>

		<CFCASE VALUE="PitchAvailable">
			<cfset ThisPA = url.PA >
			<cfif ThisPA IS "Venue">
				<cfinclude template="InclPitchAvailable01.cfm">
				<INPUT TYPE="HIDDEN" NAME="ThisPA" VALUE="<cfoutput>#ThisPA#</cfoutput>">
			<cfelseif ThisPA IS "Team">
				<!--- <cfif StructKeyExists(url, "FixtureDate")> --->
					<cfinclude template="inclTeamPitchHistory.cfm">
					<cfoutput>
					<INPUT TYPE="HIDDEN" NAME="BookingDateList" VALUE="#BookingDateList#">
					<INPUT TYPE="HIDDEN" NAME="VenueNameList" VALUE="#VenueNameList#">
					<INPUT TYPE="HIDDEN" NAME="PitchNameList" VALUE="#PitchNameList#">
					<INPUT TYPE="HIDDEN" NAME="PitchStatusList" VALUE="#PitchStatusList#">
					</cfoutput>
					
					
					
				<!---  </cfif>  --->
				<cfinclude template="InclPitchAvailable02.cfm">
				<INPUT TYPE="HIDDEN" NAME="ThisPA" VALUE="<cfoutput>#ThisPA#</cfoutput>">
			<cfelse>
			xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx <cfabort>
			</cfif>
		</CFCASE>

		<CFCASE VALUE="Matches">
			<cfinclude template="InclSchedule01.cfm">
		</CFCASE>
		<cfcase value="Player">
			<cfinclude template = "InclLookUpPlayer.cfm">
		</cfcase>
 		<cfcase value="Referee">
			<cfinclude template="InclLookUp.cfm">
		</cfcase>
 		<cfcase value="Committee">
			<cfinclude template="InclLookUpCommittee.cfm">
		</cfcase>
		<CFDEFAULTCASE>
			<cfinclude template="InclLookUp.cfm">
		</CFDEFAULTCASE>
	</CFSWITCH>
	<cfif NewRecord IS "No">
		<cfoutput> 
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="loggedinScreen">
			<tr>
				<!--- <cfif TblName IS "PitchAvailable">
					<td>
						<cfinclude template="InclTblDelete.cfm">
					</td>
				<cfelse> --->
					<td>
						<cfinclude template="InclTblUpdateDelete.cfm">
					</td>
				<!--- </cfif> --->
			</tr>
			<cfif TblName IS "Team">
			
				<cfset maxp = 3 >
				<tr bgcolor="aqua">
					<td>
						<span class="pix10">
						Highlight and copy the batch header line and the following #maxp# data lines to add new players and register them to <strong>#GetTblName.LongCol#</strong> all in one go using <u>Batch Input</u>. <br />
						You can have more than #maxp# data lines so add extra data lines for extra players.
						</span>
					</td>
				</tr>
				<tr bgcolor="white">
					<td>
						<span class="pix13boldred">NEW: Football Association Number added at end of batch input line  [FAN]</span>
					</td>
				</tr>
				
				<tr bgcolor="white">
					<td>
						<span class="monopix12">{#LeagueCode#NewPlayerRegistrations}</span>
					</td>
				</tr>
				<cfloop index="p" from="1" to="#maxp#">
				<tr bgcolor="white">
					<td>
						<span class="monopix12">{#LeagueCode#,#GetTblName.ID#}[Surname][Forenames][DOB yyyy-mm-dd][Reg.No.][Notes][First Day yyyy-mm-dd][Registration Type][FAN]</u></span>
					</td>
				</tr>
				</cfloop>
				<tr bgcolor="gray">
					<td>
						<span class="monopix12white">{#LeagueCode#,#GetTblName.ID#}[Smith][John Arthur][1981-03-27][13672][ Here is an example][2005-11-21][Non-Contract][12345678]</u></span><span class="pix10boldred"> EXAMPLE</span>
					</td>
				</tr>
				<tr bgcolor="gray">
					<td>
						<span class="monopix12white">{#LeagueCode#,#GetTblName.ID#}[Forbes-Hamilton ][ William][ 1985-11-17][ 2133 ][Here is another example ][ 2005-10-13][ Contract][]</u></span><span class="pix10boldred"> EXAMPLE</span>
					</td>
				</tr>
			</cfif>
			<cfif TblName IS "Matches">
<!--- 
				**************************************
				* move this fixture to Miscellaneous *
				**************************************
--->						
				<cfif QFixtureDate.FixtureDate GE Now()>
				<cfelseif QFixtureDate.HomeNoScore IS "NoScore" OR QFixtureDate.AwayNoScore IS "NoScore">
				<cfelseif ThisCompetitionDescription IS "Miscellaneous" >
				<cfelse>
					<tr>
						<td align="right">
							<span class="pix10"><input type="Submit" name="Operation" value="Move to Miscellaneous">
						</td>
					</tr>
				</cfif>
			</cfif>
		</table>
		</cfoutput>
	<cfelse>
		<cfoutput> 
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="loggedinScreen">
			<tr>
				<td>
					<cfinclude template="InclTblAddAMany.cfm">
				</td>
			</tr>
			<cfif TblName IS "PitchAvailable" AND ThisPA IS "Team" AND UnknownCount GT 0 >
				<tr>
					<td align="center"><span class="pix13">or</span></td>
				</tr>
				<tr>
					<td align="center">
						<table border="1" cellpadding="5" cellspacing="0">
							<tr>
								<td align="center" bgcolor="white"><span class="pix13"><input type="Submit" name="Operation" value="-Add-"> for all fixtures where blank</span></td>
							</tr>
						</table>
					</td>
				</tr>
			</cfif>
		</table>
		</cfoutput>
	</cfif>
</CFFORM>
<!--- this puts the input cursor into the LongCol field ready for the user to start typing --->
<!--- currently, this is causing some JS errors when the field doesn't exist --->
<script type="text/javascript">
	<!--
	if (document.terry.LongCol && document.terry.LongCol.type == "text") {
		document.terry.LongCol.focus();
	}
	else if (document.terry.Surname) 
	{
		document.terry.Surname.focus();
	}

	//-->
</script>
