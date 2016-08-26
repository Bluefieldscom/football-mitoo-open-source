<!--- included by News.cfm --->

<cfset AltRSecretWord = '' > <!--- alternative password chosen by Referee --->
<cfif StructKeyExists(form, "RSubmitted")> <!--- not the first time in --->
	<table border="0"  align="center" cellpadding="2" cellspacing="2">
<!---
																	*********************
																	*  Silver, Skyblue  *
																	*********************
--->
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
			<cfset RefereeID = SpanExcluding(Form.RefereeInfo, " ") >
				<!--- use this ID to get all the referee's information --->
				<cfinclude template="queries/qry_GetRefereeInfo.cfm">
			
				<!--- request.DropDownRefereeID is the first part of form.RefereeInfo (remember, RefereeInfo is "#ID# #LongCol#" separated with a space in middle)  --->
				<cfset request.DropDownRefereeID = SpanExcluding(Form.RefereeInfo, " ") > <!--- get the #ID# part  --->
				<cfset L = Len(Form.RefereeInfo) - Len(request.DropDownRefereeID) - 1>
				<!--- DropDownRefereeName is the second part of form.RefereeInfo --->
				<cfset request.DropDownRefereeName = Right(Form.RefereeInfo, L)>
 				<cfinclude template="InclRefereeInfo.cfm">
<!---
																	**************
																	*  Yellow    *
																	**************
--->
		<cfelseif ListFind("Yellow",request.SecurityLevel) >
			<cfset RefereeID = SpanExcluding(Form.RefereeInfo, " ") >
				<!--- use this ID to get all the referee's information --->
				<cfinclude template="queries/qry_GetRefereeInfo.cfm">
			
				<!--- request.DropDownRefereeID is the first part of form.RefereeInfo (remember, RefereeInfo is "#ID# #LongCol#" separated with a space in middle)  --->
				<cfset request.DropDownRefereeID = SpanExcluding(Form.RefereeInfo, " ") > <!--- get the #ID# part  --->
				<cfset L = Len(Form.RefereeInfo) - Len(request.DropDownRefereeID) - 1>
				<!--- DropDownRefereeName is the second part of form.RefereeInfo --->
				<cfset request.DropDownRefereeName = Right(Form.RefereeInfo, L)>
				
				<!--- calculate password "RSecretWord" using this algorithm with referee surname --->
				<cfif GetRefereeInfo.forename IS "" OR GetRefereeInfo.surname  IS "" >
					<cfset RSecretWord = "" >
				<cfelse>
					<cfset RSecretWord = "#Trim(GetRefereeInfo.Surname)##Trim(GetRefereeInfo.Forename)#" >
					<cfset SecretWord = RSecretWord >
					<cfset SecretID = RefereeID >
					<cfinclude template="InclSecretWordCreation.cfm">
					<cfset RSecretWord = SecretWord >
				</cfif>
				
				<!--- maybe they are using an alternative password, let's see if there is one for this referee --->
				<cfif Len(Trim(Form.RefereePwd)) GT 0 >
					<cfinclude template="queries/qry_RLookUpAltPWD.cfm">
					<cfif RLookUpAltPWD.RecordCount IS 1 >
						<cfset AltRSecretWord = "#Trim(RLookUpAltPWD.altPwd)#" >
					<cfelse>
						<cfset AltRSecretWord = "" >
					</cfif>			
				</cfif>
				<!---
				 <span class="pix10">
				<cfoutput>TEMP: RSecretWord is #RSecretWord#</cfoutput><br>
				<cfoutput>TEMP: Form.RefereePwd is #Form.RefereePwd#</cfoutput><br>
				<cfoutput>TEMP: AltRSecretWord is #AltRSecretWord#</cfoutput>
				 </span>
				 --->
				<!--- Check if they have entered the correct password or alternative (chosen by them) password --->
				<cfif Len(Trim(Form.RefereePwd)) GT 0 
				AND (      CompareNoCase(Form.RefereePwd , RSecretWord ) IS 0 
				OR        (CompareNoCase(Form.RefereePwd , AltRSecretWord ) IS 0 AND GetToken(RLookUpAltPWD.IDName, 1) IS request.DropDownRefereeID ) )>
				
					
					<cfset request.YellowKey = "#request.CurrentLeagueCode#|#request.DropDownRefereeID#" >
					
					
					<cfinclude template="InclRefereeInfo.cfm">
				<cfelse>
					<cfset request.YellowKey = "">
				</cfif>
		<cfelse> <!--- SecurityLevel is White --->
			<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
			<cfabort>
		</cfif>
	</table>
		<cfif StructKeyExists(form, "ChosenPwd") AND Len(Trim(form.ChosenPwd)) GT 0> 
			<cfset AltRSecretWord = Trim(form.ChosenPwd)>
				<!---
				<cfoutput><span class="pix10">#AltRSecretWord#</span></cfoutput>
				--->
			<!--- check the chosen new password is valid before adding or updating --->
			<cfif Len(Trim(AltRSecretWord)) LE 5>	
				<cfoutput><span class="pix13boldred">ERROR: Your chosen password must be at least 6 characters long. To try again please enter the original password.</span></cfoutput>
			<cfelseif REFindNoCase("\W", AltRSecretWord) GT 0>	
				<cfoutput><span class="pix13boldred">ERROR: Your chosen password contains invalid characters. To try again please enter the original password.</span></cfoutput>
			<cfelseif NOT (REFindNoCase("\d", AltRSecretWord) GT 0 AND REFindNoCase("\D", AltRSecretWord) GT 0) >	
				<cfoutput><span class="pix13boldred">ERROR: Your chosen password must contain some letters and some numbers. To try again please enter the original password.</span></cfoutput>
			<cfelse>
				<cfif Len(Trim(Form.RefereePwd)) GT 0 >
					<cfif RLookUpAltPWD.RecordCount IS 0 > <!--- ADD --->
						<cfset AltPWDMessage = "Your chosen password has been accepted.">
						<cfinclude template="queries/ins_RInsertAltPWD.cfm">
						<cfoutput><span class="pix13boldnavy">#AltPWDMessage#</span></cfoutput>
					<cfelseif RLookUpAltPWD.RecordCount IS 1 > <!--- UPDATE --->
						<cfset AltPWDMessage = "Your chosen password has been changed.">
						<cfinclude template="queries/upd_RUpdateAltPWD.cfm">
						<cfoutput><span class="pix13boldnavy">#AltPWDMessage#</span></cfoutput>
					<cfelse>
						ERROR 45qw26 in RefereeListForm.cfm <cfabort>
					</cfif>			
				</cfif>
			</cfif>
		</cfif>
</cfif>
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.SecurityLevel = request.SecurityLevel >
	<cfset session.DropDownRefereeName = request.DropDownRefereeName >
	<cfset session.DropDownRefereeID = request.DropDownRefereeID >
	<cfset session.YellowKey = request.YellowKey >
	<cfset session.LeagueCode = LeagueCode >
</cflock>
<FORM ACTION="News.cfm" METHOD="post" >
	<!--- pass the TblName in a hidden field etc --->
	<INPUT TYPE="HIDDEN" NAME="TBLNAME" VALUE="<cfoutput>#TblName#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="<cfoutput>#LeagueCode#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="SeasonName" VALUE="<cfoutput>#SeasonName#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="LeagueName" VALUE="<cfoutput>#LeagueName#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="NB" VALUE="0">
	<cfinclude template = "queries/qry_RefereeListFormGetReferee.cfm"> <!--- get the ID and Referee Name of all the referees in this league ---> 
 	<table width="100%" border="0" cellspacing="0" cellpadding="2" >
		
		<cfif StructKeyExists(form, "RSubmitted")> <!--- not the first time in --->
		<cfelseif ListFind("Yellow",request.SecurityLevel) >
			<tr>
				<td align="center">
					<table border="1" cellpadding="5" cellspacing="0"  bgcolor="white">
						<tr>
							<td align="center" valign="middle">
								<span class="pix13boldred">Referees please Log In here ...</span>
							</td>
						</tr>
					</table>
				
				</td>
			</tr>
		</cfif>
		<tr>
			<td height="30" align="center" valign="middle">
				<span class="pix10">choose --> </span>
				<select name="RefereeInfo" size="1">
					<cfoutput query="GetReferee" >
							<option value="#ID# #LongCol#"<cfif StructKeyExists(form,"RefereeInfo") AND form.RefereeInfo IS "#ID# #LongCol#">selected</cfif> >#LongCol#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		<cfif ListFind("Yellow",request.SecurityLevel) >
			<cfif StructKeyExists(form, "RefereePwd") AND CompareNoCase(Form.RefereePwd , RSecretWord ) IS 0 AND AltRSecretWord IS ''>
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
									<cfoutput><span class="pix10">your chosen password: <input type="Password" name="ChosenPwd"  size="10" maxlength="20"  onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=300;return escape('Enter both your chosen password and the original password. Your password must be at least 6 characters long and must contain some letters and some numbers.')"> the original password: <input type="Password" name="RefereePwd"  size="10" maxlength="20"  onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=300;return escape('Enter the original password here.')"></span></cfoutput> 
								</td>
							</tr>
						</table>
					</td>
				</tr>
			<cfelseif StructKeyExists(form, "RefereePwd") AND CompareNoCase(Form.RefereePwd , RSecretWord ) IS 0 AND NOT StructKeyExists(form, "ChosenPwd")>
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
									<cfoutput><span class="pix10">your chosen password: <input type="password" name="ChosenPwd"  size="10" maxlength="20" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='Azure';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=300;return escape('Enter both your chosen password and the original password. Your password must be at least 6 characters long and must contain some letters and some numbers.')"> the original password: <input type="Password" name="RefereePwd"  size="10" maxlength="20"  onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='Azure';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=300;return escape('Enter the original password here.')"></span></cfoutput> 
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
			<cfelse>
				<tr>
					<td align="center"><input type="Password" name="RefereePwd"  size="10" maxlength="20" <cfoutput>onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='Azure';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('If you are a referee then please contact the league and ask for your password.')"</cfoutput> ><br /><span class="pix10">password</span></td>
				</tr>
			</cfif>
			
		</cfif>
		<tr>
			<td height="120" colspan="2" align="center" valign="top"><INPUT NAME="RSubmitted" TYPE="submit" VALUE="OK"></td>
		</tr>
	</table>
</FORM>

<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>

