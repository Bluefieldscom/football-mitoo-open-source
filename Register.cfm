<cfsilent>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
</cfsilent>
<cfinclude template="InclBegin.cfm">
<SCRIPT LANGUAGE="Javascript">
<!--
function myValidate() {
	if (document.mailing.InputEmailAddr.value.length > 0) {
	if 
(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(document.mailing.InputEmailAddr.value)) {
	return true
	}
	alert("Please enter a valid e-mail address!\n" + "' " +document.mailing.InputEmailAddr.value+" '"+ " is invalid.");
	document.mailing.InputEmailAddr.focus();
	return false
	}
	}
//-->
</SCRIPT>
<cfoutput>	
<FORM name="mailing" id="mailing" ACTION="RegCheck.cfm" METHOD="POST" onSubmit = "return myValidate();">

<!--- pass the LeagueCode in a hidden field --->
<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="#LeagueCode#">
<INPUT TYPE="HIDDEN" NAME="LEAGUENAME" VALUE="#LeagueName#">
<table width="100%" border="0" cellspacing="0" cellpadding="5" >
	<tr>
		<!--- column 1 --->
		<td>
			<table>
				<cfset CaptchaNumber = Right(getTickCount(),5)>
				<input type="hidden" name="ThisCaptchaNumber" VALUE="#CaptchaNumber#">
				<!---
				<cfimage
					required
					action = "captcha"
					height = "number of pixels"
					text = "text string"
					width = "number of pixels"
					optional
					destination = "absolute pathname|pathname relative to the web root"
					difficulty = "high|medium|low"
					overwrite = "yes|no"
					fonts = "comma-separated list of font names"
					fontSize = "point size">
				--->
				<tr>
					<td align="right" valign="middle">
						<cfimage action="captcha" height = "60" fontSize="24" difficulty = "low" text="#CaptchaNumber#" fonts="Verdana,Arial,Courier New,Courier">
					</td>
					<td align="left" valign="middle">
						<input name="CaptchaVerify" type="text"  size="10" maxlength="10"><span class="pix10bold">*</span><br><span class="pix10bold">verification number</span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<span class="pix10bold">your forename</span>
					</td>
					<td align="left">
						<input name="forename" type="text"  size="40" maxlength="40"><span class="pix10bold">*</span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<span class="pix10bold">your surname</span>
					</td>
					<td align="left">
						<input name="surname" type="text"  size="40" maxlength="40"><span class="pix10bold">*</span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<span class="pix10bold">your email</span>
					</td>
					<td align="left">
						<input name="InputEmailAddr" type="text"  size="40" maxlength="40"><span class="pix10bold">*</span>
					</td>
				<tr>
				<tr>
					<td align="right">
						<span class="pix10bold">team(s) with which you are involved</span>
					</td>
					<td align="left">
						<input name="TeamsInvolved" type="text"  size="40" maxlength="40">
					</td>
				<tr>
				<tr>
					<td align="right" valign="top">
						<span class="pix10bold">your role *</span>
					</td>
					<td></td>
				</tr>
				<tr>
				<td></td>
					<td align="left" valign="top" >
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td align="left" valign="top">
									<span class="pix10bold">
										<input name="RoleList" type="checkbox" value="1"> player<br>
										<input name="RoleList" type="checkbox" value="2"> manager<br>
										<input name="RoleList" type="checkbox" value="3"> secretary<br>
									</span>
								</td>
								<td align="left" valign="top">
									<span class="pix10bold">
										<input name="RoleList" type="checkbox" value="4"> supporter<br>
										<input name="RoleList" type="checkbox" value="5"> referee<br>
										<input name="RoleList" type="checkbox" value="6"> other <input name="other" type="text"  size="20" maxlength="20">
								</td>
							</tr>
							<tr>
								<td colspan="2" align="left" >
									<span class="pix9">tick boxes that apply</span>
								</td>
							</tr>
						</table>
					</td>
					
				<tr>
			</table>
		</td>
		<!--- column 2 --->
		<td>
			<table>
				<tr>
					<td align="right">
						<span class="pix10bold">how you found out<br>about <i>football.mitoo</i></span>
					</td>
					<td align="left">
						<input name="HowFoundOut" type="text"  size="40" maxlength="40">
					</td>
				<tr>
				<tr>
					<td align="right">
						<span class="pix10bold">how long you've been<br>using <i>football.mitoo</i></span>
					</td>
					<td align="left">
						<input name="HowLongUsing" type="text"  size="40" maxlength="40">
					</td>
				<tr>
				<tr>
					<td align="right">
						<span class="pix10bold">your age range</span><span class="pix10bold"> *</span>
					</td>
					<td align="left">
						<table width="200" border="0" cellpadding="5" cellspacing="0">
							<tr>
								<td width="50%" align="right" valign="middle">
									<span class="pix10">&nbsp;0 - &nbsp;9</span><input name="AgeRange" type="radio" value="1" ><br>
									<span class="pix10">10 - 19</span><input name="AgeRange" type="radio" value="2" ><br>
									<span class="pix10">20 - 29</span><input name="AgeRange" type="radio" value="3" ><br>
									<span class="pix10">30 - 39</span><input name="AgeRange" type="radio" value="4" >
								</td>
								<td width="50%" align="right" valign="middle">
									<span class="pix10">40 - 49</span><input name="AgeRange" type="radio" value="5" ><br>
									<span class="pix10">50 - 59</span><input name="AgeRange" type="radio" value="6" ><br>
									<span class="pix10">60 - 69</span><input name="AgeRange" type="radio" value="7" ><br>
									<span class="pix10">70&nbsp; + &nbsp;&nbsp;</span><input name="AgeRange" type="radio" value="8" >
								</td>
							</tr>
						</table>
					</td>
					</td>
				<tr>
				<tr>
					<td align="RIGHT">
						<span class="pix10bold">any other comments</span>
					</td>
					<td align="left">
						<textarea name="OtherComments" cols="30" rows="3"></textarea>
					</td>
				<tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td colspan="2" align="center"><span class="pix10bold">you must complete all input areas marked with an asterisk *</span></td>
	<tr>
	<tr>
		<td colspan="2" align="center">
			<span class="pix13">
				<br>Thanks.....  from time to time we may email you with news about the #LeagueName# and developments in <i>football.mitoo.</i><br> 
				 You can <a href="mailto:INSERT_EMAIL_HERE?Subject=Please remove me from the #URLEncodedFormat(LeagueName)# mailing list"><u>remove yourself from the #LeagueName# mailing list</u></a> at any time.
			</span>
		</td>
	<tr>
	<tr>
		<td colspan="2" align="center">
		<INPUT TYPE="Submit" NAME="Operation" VALUE="Register">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<span class="pix10red">If you do not receive an automatic acknowledgement please check that you entered your email address correctly.</span>
		</td>
	</tr>
	
</table>
</cfoutput>
</FORM>
