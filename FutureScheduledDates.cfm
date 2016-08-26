<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- this is in Administration Reports --->

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!--- ========================================================================================== --->

<cfinclude template="queries/qry_QCountFixtures.cfm">

<!---
																					**************************
																					* come from Unsched.cfm? *
																					**************************
--->

<cfif StructKeyExists(url, "T1") AND StructKeyExists(url, "O1") AND StructKeyExists(url, "T2") AND StructKeyExists(url, "O2") >
	<cfset form.StateVector = "7">
	<cfif CBSunday IS "1"><cfset form.BoxSunday = "1"></cfif>
	<cfif CBMonday IS "1"><cfset form.BoxMonday = "1"></cfif>
	<cfif CBTuesday IS "1"><cfset form.BoxTuesday = "1"></cfif>
	<cfif CBWednesday IS "1"><cfset form.BoxWednesday = "1"></cfif>
	<cfif CBThursday IS "1"><cfset form.BoxThursday = "1"></cfif>
	<cfif CBFriday IS "1"><cfset form.BoxFriday = "1"></cfif>
	<cfif CBSaturday IS "1"><cfset form.BoxSaturday = "1"></cfif>
</cfif>


<cfif NOT StructKeyExists(form, "StateVector") >
<!---
																					*****************
																					* First time in *
																					*****************
--->
	
	<CFFORM NAME="FutureScheduledDates" ACTION="FutureScheduledDates.cfm" >
		<cfoutput>
			<input type="Hidden" name="StateVector" value="1">
			<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
			<input type="Hidden" name="ID" value="#QLeagueCode.ID#">
			<cfset Request.StageInConversation ="First time in">
			<cfset Request.TIDSelected1 = "">
			<cfset Request.TIDSelected2 = "">
			<cfset Request.OIDSelected1 = "">
			<cfset Request.OIDSelected2 = "">
		</cfoutput>
		<table width="30%"  border="0" align="left" cellpadding="2" cellspacing="2" bgcolor="#B8C8F0">
			<tr>
				<td>
					<span class="pix13bold">for</span>
				</td>
			</tr>
			<tr>
				<td>
					<cfset TIDSelected = Request.TIDSelected1>				
					<cfinclude template="InclTblChooseTeam.cfm">					
				</td>
				<td>
					<cfset OIDSelected = Request.OIDSelected1>				
					<cfinclude template="InclTblChooseOrdinal.cfm">					
				</td>
			</tr>
			<tr>
				<td>
					<span class="pix13bold">and </span>
				</td>
			</tr>
			<tr>
				
				<td>
					<cfset TIDSelected = Request.TIDSelected2>								
					<cfinclude template="InclTblChooseTeam.cfm">					
				</td>
				<td>
					<cfset OIDSelected = Request.OIDSelected2>								
					<cfinclude template="InclTblChooseOrdinal.cfm">					
				</td>
			</tr>
			<tr>
				<td height="30" colspan="2" align="center">
				<span class="pix10">
					Sun<cfif CBSunday IS "1"><input name="BoxSunday" type="checkbox" value="1" checked><cfelse><input name="BoxSunday" type="checkbox" value="0"></cfif>
					Mon<cfif CBMonday IS "1"><input name="BoxMonday" type="checkbox" value="1" checked><cfelse><input name="BoxMonday" type="checkbox" value="0"></cfif>
					Tue<cfif CBTuesday IS "1"><input name="BoxTuesday" type="checkbox" value="1" checked><cfelse><input name="BoxTuesday" type="checkbox" value="0"></cfif>
					Wed<cfif CBWednesday IS "1"><input name="BoxWednesday" type="checkbox" value="1" checked><cfelse><input name="BoxWednesday" type="checkbox" value="0"></cfif>
					Thu<cfif CBThursday IS "1"><input name="BoxThursday" type="checkbox" value="1" checked><cfelse><input name="BoxThursday" type="checkbox" value="0"></cfif>
					Fri<cfif CBFriday IS "1"><input name="BoxFriday" type="checkbox" value="1" checked><cfelse><input name="BoxFriday" type="checkbox" value="0"></cfif>
					Sat<cfif CBSaturday IS "1"><input name="BoxSaturday" type="checkbox" value="1" checked><cfelse><input name="BoxSaturday" type="checkbox" value="0"></cfif>
				</span> </td>
			</tr>
			
	<!---
								*************
								* OK Button *
								*************
	--->
				<tr>
					<td height="40" colspan="2" align="center">
						<input type="Submit" value="OK">
					</td>
				</tr>

		</table>
	</cfform>
	
<cfelseif StructKeyExists(form, "StateVector") >
<!---
																					***************
																					* 2nd time in *
																					***************
--->

	<!--- repeat the form above the results of the query --->
		<CFFORM NAME="FutureScheduledDates" ACTION="FutureScheduledDates.cfm" >
			<cfoutput>
				<input type="Hidden" name="StateVector" value="1">
				<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
				<input type="Hidden" name="ID" value="#QLeagueCode.ID#">
				<cfset Request.StageInConversation ="2nd time in">
				
				<cfif form.StateVector IS "7" >
					<cfset Request.TIDSelected1 = url.T1>
					<cfset Request.OIDSelected1 = url.O1>
					<cfset Request.TIDSelected2 = url.T2>
					<cfset Request.OIDSelected2 = url.O2>
				<cfelse>
					<cfset Request.TIDSelected1 = "#ListGetAt(Form.TID, 1)#">
					<cfset Request.TIDSelected2 = "#ListGetAt(Form.TID, 2)#">
					<cfset Request.OIDSelected1 = "#ListGetAt(Form.OID, 1)#">
					<cfset Request.OIDSelected2 = "#ListGetAt(Form.OID, 2)#">
				</cfif>
			</cfoutput>
			<table width="30%" border="0" align="left" cellpadding="2" cellspacing="2" bgcolor="#B8C8F0">
				<tr>
				
					<td>
						<span class="pix13bold">for</span>
					</td>
				</tr>
				<tr>
					
					<td>
						<cfset TIDSelected = Request.TIDSelected1>
						<cfinclude template="InclTblChooseTeam.cfm">					
					</td>
					<td>
						<cfset OIDSelected = Request.OIDSelected1>
						<cfinclude template="InclTblChooseOrdinal.cfm">					
					</td>
				</tr>
				<tr>
					<td>
						<span class="pix13bold">and </span>
					</td>
				</tr>
				<tr>
					<td>
						<cfset TIDSelected = Request.TIDSelected2>
						<cfinclude template="InclTblChooseTeam.cfm">					
					</td>
					<td>
						<cfset OIDSelected = Request.OIDSelected2>
						<cfinclude template="InclTblChooseOrdinal.cfm">					
					</td>
				</tr>
				
			<tr>
				<td height="30" colspan="2" align="center">
				<span class="pix10">
					Sun<cfif StructKeyExists( form, "BoxSunday")><input name="BoxSunday" type="checkbox" value="1" checked><cfelse><input name="BoxSunday" type="checkbox" value="0"></cfif>
					Mon<cfif StructKeyExists( form, "BoxMonday")><input name="BoxMonday" type="checkbox" value="1" checked><cfelse><input name="BoxMonday" type="checkbox" value="0"></cfif>
					Tue<cfif StructKeyExists( form, "BoxTuesday")><input name="BoxTuesday" type="checkbox" value="1" checked><cfelse><input name="BoxTuesday" type="checkbox" value="0"></cfif>
					Wed<cfif StructKeyExists( form, "BoxWednesday")><input name="BoxWednesday" type="checkbox" value="1" checked><cfelse><input name="BoxWednesday" type="checkbox" value="0"></cfif>
					Thu<cfif StructKeyExists( form, "BoxThursday")><input name="BoxThursday" type="checkbox" value="1" checked><cfelse><input name="BoxThursday" type="checkbox" value="0"></cfif>
					Fri<cfif StructKeyExists( form, "BoxFriday")><input name="BoxFriday" type="checkbox" value="1" checked><cfelse><input name="BoxFriday" type="checkbox" value="0"></cfif>
					Sat<cfif StructKeyExists( form, "BoxSaturday")><input name="BoxSaturday" type="checkbox" value="1" checked><cfelse><input name="BoxSaturday" type="checkbox" value="0"></cfif>
				</span> </td>
			</tr>
				
	
		<!---
									*************
									* OK Button *
									*************
		--->
					<tr>
						<td height="40" colspan="2" align="center">
							<input type="Submit" value="OK">
						</td>
					</tr>
			</table>
		</cfform>
		<cfset ThisDate = DateFormat(Now(),'YYYY-MM-DD') >
		<table width="100%"   border="0" align="center" cellpadding="2" cellspacing="2">
			<cfloop condition = "ThisDate LESS THAN OR EQUAL TO #DateFormat(SeasonEndDate,'YYYY-MM-DD')#">
				<cfinclude template="queries/qry_QGetDatesForTwoTeams.cfm">
				<cfinclude template="queries/qry_QGetDatesForAnyTeam.cfm">
				<cfif QGetDatesForAnyTeam.RecordCount IS 0>
				
					<cfif 
					(DayOfWeek(ThisDate) IS 1 AND StructKeyExists( form, "BoxSunday")) OR
					(DayOfWeek(ThisDate) IS 2 AND StructKeyExists( form, "BoxMonday")) OR
					(DayOfWeek(ThisDate) IS 3 AND StructKeyExists( form, "BoxTuesday")) OR
					(DayOfWeek(ThisDate) IS 4 AND StructKeyExists( form, "BoxWednesday")) OR
					(DayOfWeek(ThisDate) IS 5 AND StructKeyExists( form, "BoxThursday")) OR
					(DayOfWeek(ThisDate) IS 6 AND StructKeyExists( form, "BoxFriday")) OR
					(DayOfWeek(ThisDate) IS 7 AND StructKeyExists( form, "BoxSaturday"))
					>
						<cfoutput>
							<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
								<td colspan="3" valign="bottom" bgcolor="##EEEEEE"><span class="pix13bold">#DateFormat(ThisDate,'DDDD, DD MMM YYYY')#</span></td>
							</tr>
							<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
								<td width="20%">&nbsp;</td>
								<td width="50%" ><span class="pix13">&nbsp;</span></td> 
								<td width="30%" ><span class="pix13">0 fixtures</span></td> 
							</tr>
							<tr>
								<td height="5">&nbsp;</td>	
							</tr>
						</cfoutput>
					</cfif>
				<cfelseif QGetDatesForTwoTeams.RecordCount IS 0>
				
					<cfif 
					(DayOfWeek(ThisDate) IS 1 AND StructKeyExists( form, "BoxSunday")) OR
					(DayOfWeek(ThisDate) IS 2 AND StructKeyExists( form, "BoxMonday")) OR
					(DayOfWeek(ThisDate) IS 3 AND StructKeyExists( form, "BoxTuesday")) OR
					(DayOfWeek(ThisDate) IS 4 AND StructKeyExists( form, "BoxWednesday")) OR
					(DayOfWeek(ThisDate) IS 5 AND StructKeyExists( form, "BoxThursday")) OR
					(DayOfWeek(ThisDate) IS 6 AND StructKeyExists( form, "BoxFriday")) OR
					(DayOfWeek(ThisDate) IS 7 AND StructKeyExists( form, "BoxSaturday"))
					>
						<cfoutput>
							<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
								<td colspan="3" valign="bottom" bgcolor="##EEEEEE"><a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(ThisDate,'DD-MMM-YY')#&LeagueCode=#LeagueCode#"><span class="pix13bold">#DateFormat(ThisDate,'DDDD, DD MMM YYYY')#</span></a></td>
							</tr>
							<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
								<td width="20%">&nbsp;</td>
								<td width="50%" ><span class="pix13">&nbsp;</span></td> 
								<td width="30%" ><span class="pix13">#QGetDatesForAnyTeam.RecordCount# fixtures</span></td> 
							</tr>
							<tr>
								<td colspan="3" height="5">&nbsp;</td>	
							</tr>
						</cfoutput>
					</cfif>
				<cfelse>
					<cfoutput query="QGetDatesForTwoTeams" group="fixturedate">
							<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
							<td colspan="3" valign="bottom" bgcolor="##EEEEEE"><a href="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(fixturedate,'DD-MMM-YY')#&LeagueCode=#LeagueCode#"><span class="pix13bold">#DateFormat(fixturedate, 'DDDD, DD MMM YYYY')#</span></a></td>
						</tr>
							<cfoutput>
							<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
									<td width="20%"></td>
									<td width="50%">
									<span class="pix13">
									<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#"><cfif Request.TIDSelected1 IS QGetDatesForTwoTeams.TID1 OR Request.TIDSelected2 IS QGetDatesForTwoTeams.TID1><strong>#HomeTeam#</strong><cfelse>#HomeTeam#</cfif></a>
									v
									<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HID#&AwayID=#AID#&LeagueCode=#LeagueCode#"><cfif Request.TIDSelected1 IS QGetDatesForTwoTeams.TID2 OR Request.TIDSelected2 IS QGetDatesForTwoTeams.TID2><strong>#AwayTeam#</strong><cfelse>#AwayTeam#</cfif></a>
									</span>
									</td> 
									<td width="30%"><span class="pix13">#DivisionName#</span></td> 
								</tr>
							</cfoutput>
						<tr>
							<td height="5" colspan="3" align="right"><span class="pix13">plus #(QGetDatesForAnyTeam.RecordCount-QGetDatesForTwoTeams.RecordCount)# other fixtures</span></td>	
						</tr>
					</cfoutput>
				</cfif>		
				<cfset ThisDate = DateAdd('d', 1, ThisDate)>
			</cfloop>
		</table>
</cfif> <!--- 1st or 2nd time in --->
