<cfif StructKeyExists(form, "InputEmailAddr")>
	<cfset request.EmailAddr = "#InputEmailAddr#" >
<cfelse>
	<cfset request.EmailAddr = "" >
</cfif>
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.EmailAddr = request.EmailAddr >	
</cflock>

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
	<FORM name="mailing" id="mailing" ACTION="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#" METHOD="POST" onSubmit = "return myValidate();">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" >
			<tr align="CENTER">
				<td colspan="2"><span class="pix10">Please enter your email address</span></td>
			</tr>
			<tr>
				<td align="CENTER" colspan="2">
				<input type="Text" name="InputEmailAddr" value="#request.EmailAddr#" size="30" maxlength="50">
				<input type="Submit" name="SubmitButton" value="OK" >
				</td>
			</tr>
			<tr align="CENTER">
				<td colspan="2"><span class="pix10"><cfif Len(Trim(request.EmailAddr)) GT 0 ><BR>Automatic emails are now switched ON and they will be sent to <b>#request.EmailAddr#</b><BR>Please clear the field above and click on OK if you want to switch off automatic emails<cfelse><BR>Automatic emails are currently switched OFF</td></span></cfif>
			</tr>
		</table>
		<input type="Hidden" NAME="LeagueCode" VALUE="#LeagueCode#">
	</FORM>
</cfoutput>