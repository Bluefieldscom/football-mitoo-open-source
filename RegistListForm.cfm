<!--- included by News.cfm --->
<cfset request.ChosenConstitsAllSides = "">
<cfset AltSecretWord = '' > <!--- alternative password chosen by Team --->
<cfif StructKeyExists(form, "Submitted")> <!--- not the first time in --->
	<table border="0"  align="center" cellpadding="2" cellspacing="2">
<!---
																	*********************
																	*  Silver, Skyblue  *
																	*********************
--->
																	
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
			<cfset fmTeamID = SpanExcluding(Form.TeamInfo, " ") >
			<cfset request.fmTeamID = fmTeamID >
			<cfif form.TeamInfo IS "entire league" >
			<cfelse>
			<tr>
				<td>
					<cfinclude template="InclTeamDetails.cfm">		
				</td>
			</tr>
			</cfif>
			<cfif form.TeamInfo IS "entire league" >
				<cfset request.DropDownTeamName = form.TeamInfo >
				<cfset request.DropDownTeamID = 0 >
				<tr>
					<cfoutput>
					<td><span class="pix13bold">See <a href="RegistListTextEntireLeague.cfm?LeagueCode=#LeagueCode#" target="_blank">Player Registrations for Entire League</a></span></td>
					</cfoutput>
				</tr>
			<cfelse>  <!-- club name chosen --->
				<!--- request.DropDownTeamID is the first part of form.TeamInfo (remember, TeamInfo is "#ID# #LongCol#" separated with a space in middle)  --->
				<cfset request.DropDownTeamID = SpanExcluding(Form.TeamInfo, " ") > <!--- get the #ID# part  --->
				<cfset L = Len(Form.TeamInfo) - Len(request.DropDownTeamID) - 1>
				<!--- DropDownTeamName is the second part of form.TeamInfo --->
				<cfset request.DropDownTeamName = Right(Form.TeamInfo, L)>
				<tr>
					<cfoutput>
					<td align="center"><span class="pix13bold">See <a href="RegistListText.cfm?LeagueCode=#LeagueCode#" target="_blank">Player Registrations</a> for</span></td>
					</cfoutput>
				</tr>
				
				<tr>
					<cfoutput>
					<td align="center"><span class="pix13bold">See <a href="TeamDiscipAnalysis.cfm?LeagueCode=#LeagueCode#&TeamID=#fmTeamID#">Disciplinary Analysis</a></span></td>
					</cfoutput>
				</tr>
				<tr>
					<cfset ToolTipText = "Please note: this will only display games where you have entered your Starting Line-Ups.">		
					<cfoutput>
					<td align="center"><span class="pix13bold">See <a href="AppearanceRecord.cfm?LeagueCode=#LeagueCode#&TeamID=#fmTeamID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#TooltipText#');">Appearance Record</a></span></td>
					</cfoutput>
				</tr>
				<tr>
					<cfoutput>
					<td align="center"><span class="pix13bold">See <a href="TeamCurrentRegistrationsXLS.cfm?LeagueCode=#LeagueCode#&TeamID=#fmTeamID#">Current Player Registrations<br>Microsoft Excel</a></span></td>
					</cfoutput>
				</tr>
				
				<tr>
					<cfoutput>
					<td align="center">
						<table border="1" cellpadding="5" cellspacing="0">
							<tr>
								<td bgcolor="white"><span class="pix18boldnavy">#request.DropDownTeamName#</span></td>
							</tr>
						</table>
					</td>
					</cfoutput>
				</tr>
				<cfif NoPlayerReRegistrationForm IS 0 >
					<tr>
						<cfoutput>
						<td align="center"><span class="pix13bold"><a href="RegistListPDF.cfm?LeagueCode=#LeagueCode#" target="_blank">Player Re-Registration Form (.PDF)</a></span></td>
						</cfoutput>
					</tr>
				</cfif>
				<cfinclude template="queries/qry_QConstitsAllSides.cfm">
				<!--- Create a list of these chosen constitutions (i.e. chosen competitions for all sides within the club e.g. First Team, Reserves, 'A' team etc) --->
				<cfset request.ChosenConstitsAllSides = ValueList(QConstitsAllSides.ID)>
				<cfif request.ChosenConstitsAllSides IS "">
					<cfset request.ChosenConstitsAllSides = "0">
				</cfif>
				<cfinclude template="queries/qry_QFixtures_v9.cfm">
				<cfif QFixtures.RecordCount IS "0">
					<center><span class="pix13bold">No matches have been played</span></center>
				<cfelse>
					<cfinclude template = "InclTeamSheetList.cfm">
				</cfif>
				
			</cfif>
<!---
																	**************
																	*  Yellow    *
																	**************
--->
		<cfelseif ListFind("Yellow",request.SecurityLevel) >
			<cfif form.TeamInfo IS "entire league" >
				<cfset request.DropDownTeamName = form.TeamInfo >
				<cfset request.DropDownTeamID = 0 >
				<!--- the password to see entire league will be based on the short password, 'EL' and leaguecode e.g. MDXELFT8 --->
				<cfset SecretWord = "#RIGHT(request.filter,1)#A#LEFT(Reverse(request.PWD3),2)#B#LEFT(request.filter,1)#" >  <!--- XA8TBM --->
				<!--- Check if they have entered the correct "entire league" password --->
				<cfif CompareNoCase(Form.TeamPwd, SecretWord ) IS  0>
					<cfset request.YellowKey = "#request.CurrentLeagueCode#EntireLeague">
					<tr>
						<cfoutput>
						<td><span class="pix13bold">See <a href="RegistListTextEntireLeague.cfm?LeagueCode=#LeagueCode#" target="_blank">Player Registrations for Entire League</a></span></td>
						</cfoutput>
					</tr>
				<cfelse>
					<cfset request.YellowKey = "">
				</cfif>
			<cfelse> <!-- club name chosen --->
				<!--- request.DropDownTeamID is the first part of form.TeamInfo (remember, TeamInfo is "#ID# #LongCol#" separated with a space in middle)  --->
				<cfset request.DropDownTeamID = SpanExcluding(Form.TeamInfo, " ") > <!--- get the #ID# part  --->
				<cfset L = Len(Form.TeamInfo) - Len(request.DropDownTeamID) - 1>
				<!--- DropDownTeamName is the second part of form.TeamInfo --->
				<cfset request.DropDownTeamName = Right(Form.TeamInfo, L)>
				<!--- calculate club password "SecretWord" using this algorithm from team name --->
				<cfset SecretWord = request.DropDownTeamName >
				<cfset SecretID = request.DropDownTeamID >
				<cfinclude template="InclSecretWordCreation.cfm">
				<!--- maybe they are using an alternative password, let's see if there is one for this team --->
				<cfif Len(Trim(Form.TeamPwd)) GT 0 >
					<cfinclude template="queries/qry_LookUpAltPWD.cfm">
					<cfif LookUpAltPWD.RecordCount IS 1 >
						<cfset AltSecretWord = '#Trim(LookUpAltPWD.altPwd)#' >
					</cfif>			
				</cfif>
				<!--- Check if they have entered the correct club password or alternative (chosen by them) club password --->
				<cfif Len(Trim(Form.TeamPwd)) GT 0 AND (CompareNoCase(Form.TeamPwd , SecretWord ) IS 0 OR CompareNoCase(Form.TeamPwd , AltSecretWord ) IS 0)  >
					<cfset request.YellowKey = "#request.CurrentLeagueCode##request.DropDownTeamID#">
					<cfset fmTeamID = request.DropDownTeamID >
					<cfset request.fmTeamID = fmTeamID >
					<tr>
						<td>
							<cfinclude template="InclTeamDetails.cfm">		
						</td>
					</tr>
					<tr>
						<cfoutput>
						<td align="center"><span class="pix13bold">See <a href="RegistListText.cfm?LeagueCode=#LeagueCode#" target="_blank">Player Registrations</a> for</span></td>
						</cfoutput>
					</tr>
					
					<tr>
						<cfoutput>
						<td align="center"><span class="pix13bold">See <a href="TeamDiscipAnalysis.cfm?LeagueCode=#LeagueCode#&TeamID=#fmTeamID#">Disciplinary Analysis</a></span></td>
						</cfoutput>
					</tr>
					<tr>
						<cfoutput>
						<cfset ToolTipText = "Please note: this will only display games where you have entered your Starting Line-Ups.">		
						<td align="center"><span class="pix13bold">See <a href="AppearanceRecord.cfm?LeagueCode=#LeagueCode#&TeamID=#fmTeamID#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=2;this.T_WIDTH=300;return escape('#TooltipText#');">Appearance Record</a></span></td>
						</cfoutput>
					</tr>
					<tr>
						<cfoutput>
						<td align="center"><span class="pix13bold">See <a href="TeamCurrentRegistrationsXLS.cfm?LeagueCode=#LeagueCode#&TeamID=#fmTeamID#">Current Player Registrations<br>Microsoft Excel</a></span></td>
						</cfoutput>
					</tr>
					
					<tr>
						<cfoutput>
						<td align="center">
							<table border="1" cellpadding="5" cellspacing="0">
								<tr>
									<td bgcolor="white"><span class="pix18boldnavy">#request.DropDownTeamName#</span></td>
								</tr>
							</table>
						</td>
						</cfoutput>
					</tr>
					<cfif NoPlayerReRegistrationForm IS 0 >
						<tr>
							<cfoutput>
							<td align="center"><span class="pix13bold"><a href="RegistListPDF.cfm?LeagueCode=#LeagueCode#" target="_blank">Player Re-Registration Form (.PDF)</a></span></td>
							</cfoutput>
						</tr>
					</cfif>
					<cfinclude template="queries/qry_QConstitsAllSides.cfm">
					<!--- Create a list of these chosen constitutions (i.e. chosen competitions for all sides within the club e.g. First Team, Reserves, 'A' team etc) --->
					<cfset request.ChosenConstitsAllSides = ValueList(QConstitsAllSides.ID)>
					<cfif request.ChosenConstitsAllSides IS "">
						<cfset request.ChosenConstitsAllSides = "0">
					</cfif>
					<cfinclude template="queries/qry_QFixtures_v9.cfm">
					<cfif QFixtures.RecordCount IS "0">
						<center><span class="pix13bold">No matches have been played</span></center>
					<cfelse>
						<cfinclude template = "InclTeamSheetList.cfm">
					</cfif>
				<cfelse>
					<cfset request.YellowKey = "">
				</cfif>
			</cfif>
		<cfelse> <!--- SecurityLevel is White --->
			<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
			<cfabort>
		</cfif>
	</table>
		<cfif StructKeyExists(form, "ChosenPwd") AND Len(Trim(form.ChosenPwd)) GT 0> 
			<cfset AltSecretWord = Trim(form.ChosenPwd)>
				<!---
				<cfoutput><span class="pix10">#AltSecretWord#</span></cfoutput>
				--->
			<!--- check the chosen new password is valid before adding or updating --->
			<cfif Len(Trim(AltSecretWord)) LE 5>	
				<cfoutput><span class="pix13boldred">ERROR: Your chosen password must be at least 6 characters long. To try again please enter the original password.</span></cfoutput>
			<cfelseif REFindNoCase("\W", AltSecretWord) GT 0>	
				<cfoutput><span class="pix13boldred">ERROR: Your chosen password contains invalid characters. To try again please enter the original password.</span></cfoutput>
			<cfelseif NOT (REFindNoCase("\d", AltSecretWord) GT 0 AND REFindNoCase("\D", AltSecretWord) GT 0) >	
				<cfoutput><span class="pix13boldred">ERROR: Your chosen password must contain some letters and some numbers. To try again please enter the original password.</span></cfoutput>
			<cfelse>
				<cfif Len(Trim(Form.TeamPwd)) GT 0 >
					<cfif LookUpAltPWD.RecordCount IS 0 > <!--- ADD --->
						<cfset AltPWDMessage = "Your chosen password has been accepted.">
						<cfinclude template="queries/ins_InsertAltPWD.cfm">
						<cfoutput><span class="pix13boldnavy">#AltPWDMessage#</span></cfoutput>
					<cfelseif LookUpAltPWD.RecordCount IS 1 > <!--- UPDATE --->
						<cfset AltPWDMessage = "Your chosen password has been changed.">
						<cfinclude template="queries/upd_UpdateAltPWD.cfm">
						<cfoutput><span class="pix13boldnavy">#AltPWDMessage#</span></cfoutput>
					<cfelse>
						ERROR 4526 in RegistListForm.cfm <cfabort>
					</cfif>			
				</cfif>
			</cfif>
		</cfif>
</cfif>
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.ChosenConstitsAllSides = request.ChosenConstitsAllSides >
	<cfset session.SecurityLevel = request.SecurityLevel >
	<cfset session.DropDownTeamName = request.DropDownTeamName >
	<cfset session.DropDownTeamID = request.DropDownTeamID >
	<cfset session.YellowKey = request.YellowKey >
	<cfset session.LeagueCode = LeagueCode >
	<cfset session.fmTeamID = request.fmTeamID >
</cflock>
<FORM ACTION="News.cfm" METHOD="post" >
	<!--- pass the TblName in a hidden field etc --->
	<INPUT TYPE="HIDDEN" NAME="TBLNAME" VALUE="<cfoutput>#TblName#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="<cfoutput>#LeagueCode#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="SeasonName" VALUE="<cfoutput>#SeasonName#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="LeagueName" VALUE="<cfoutput>#LeagueName#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="NB" VALUE="0">
	<cfinclude template = "queries/qry_RegistListFormGetTeam.cfm"> <!--- get the ID and TeamName of all the teams in this league ---> 

	<table width="100%" border="0" cellspacing="0" cellpadding="2" >
		<tr>
			<td height="50" align="center" valign="middle">
				<span class="pix10">choose --> </span>
				<select name="TeamInfo" size="1">
					<cfoutput query="GetTeam" >
							<option value="#ID# #LongCol#"<cfif StructKeyExists(form,"TeamInfo") AND form.TeamInfo IS "#ID# #LongCol#">selected</cfif> >#LongCol#</option>
					</cfoutput>
					<option value="x" disabled>==================</option>
					<option value="entire league" >entire league</option>
				</select>
			</td>
		</tr>
		<cfif ListFind("Yellow",request.SecurityLevel) >
			<cfif StructKeyExists(form, "TeamPwd") AND CompareNoCase(Form.TeamPwd , SecretWord ) IS 0 AND AltSecretWord IS ''>
				<tr>
					<td>
						<table border="1" align="center" cellpadding="2" cellspacing="0" >
							<tr>
								<td align="center" bgcolor="red">
									<span class="pix13boldwhite">Do you want to set up your own password that's easier to remember?</span>		
								</td>
							</tr>
							<tr>
								<td align="center" bgcolor="white">
									<cfoutput><span class="pix10">your chosen password: <input type="Password" name="ChosenPwd"  size="10" maxlength="20"  onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=300;return escape('Enter both your chosen password and the original password. Your password must be at least 6 characters long and must contain some letters and some numbers.')"> the original password: <input type="Password" name="TeamPwd"  size="10" maxlength="20"  onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=300;return escape('Enter the original password here.')"></span></cfoutput> 
								</td>
							</tr>
						</table>
					</td>
				</tr>
			<cfelseif StructKeyExists(form, "TeamPwd") AND CompareNoCase(Form.TeamPwd , SecretWord ) IS 0 AND NOT StructKeyExists(form, "ChosenPwd")>
				<tr>
					<td>
						<table border="1" align="center" cellpadding="2" cellspacing="0" >
							<tr>
								<td align="center">
									<span class="pix13">Do you want to change your own password?</span>		
								</td>
							</tr>
							<tr>
								<td align="center" bgcolor="white">
									<cfoutput><span class="pix10">your chosen password: <input type="password" name="ChosenPwd"  size="10" maxlength="20" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=300;return escape('Enter both your chosen password and the original password. Your password must be at least 6 characters long and must contain some letters and some numbers.')"> the original password: <input type="Password" name="TeamPwd"  size="10" maxlength="20"  onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=300;return escape('Enter the original password here.')"></span></cfoutput> 
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
			<cfelse>
				<tr>
					<td align="center"><input type="Password" name="TeamPwd"  size="10" maxlength="20" <cfoutput>onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('If you are a club secretary then please contact the league and ask for your password.')"</cfoutput> ><br /><span class="pix10">password</span></td>
				</tr>
			</cfif>
			
		</cfif>
		<tr>
			<td height="120" colspan="2" align="center" valign="top"><INPUT NAME="Submitted" TYPE="submit" VALUE="OK"></td>
		</tr>
	</table>
</FORM>

<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>
