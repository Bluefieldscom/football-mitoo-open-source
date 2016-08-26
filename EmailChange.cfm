<!---
																					***************
																					* 2nd time in *
																					***************
--->
<cfif StructKeyExists(form, "Button")>
	<cfif Form.Button IS "Web Based">
		<cfset request.fmEmail = "Web" >
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.fmEmail = request.fmEmail >
		</cflock>
	<cfelseif Form.Button IS "Desktop Based">
		<cfset request.fmEmail = "Desktop" >
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.fmEmail = request.fmEmail >
		</cflock>
	<cfelse>
		aborting.....1.....EmailChange.cfm
		<cfabort> 
	</cfif>
	<CFLOCATION URL="EmailChange.cfm?LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!--- ====================================================================================================================================================== --->


<cfform name="EmailChange" action="EmailChange.cfm" >
	<cfoutput>
		<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
		<input type="Hidden" name="ID" value="#QLeagueCode.ID#">
	</cfoutput>

	<table width="100%" border="0" cellspacing="0" align="CENTER">

		<cfif request.fmEmail IS "Web">
					<tr align="CENTER">
						<td height="200" ><span class="pix13bold">You currently use "Web Based" email.<br /><br />
						Please click on <input type="Submit" name="Button" value="Desktop Based"> to change to "Desktop Based".</span>
						</td>
					</tr>
		<cfelseif request.fmEmail IS "Desktop">
					<tr align="CENTER">
						<td height="200" ><span class="pix13bold">You currently use "Desktop Based" email.<br /><br />
						Please click on <input type="Submit" name="Button" value="Web Based"> to change to "Web Based".</span>
						</td>
					</tr>
		<cfelse>
			aborting.....2.....EmailChange.cfm
			<cfabort> 
		</cfif>

		<tr align="CENTER">
			<td height="20" ><span class="pix13bold">Examples of Desktop Mail Clients: Outlook, Outlook Express, Thunderbird</span></td>
		</tr>
	
		<tr align="CENTER">
			<td height="20" ><span class="pix13bold">Examples of Webmail: Gmail, Hotmail</span></td>
		</tr>
	
		<tr align="CENTER">
			<td height="20" ><span class="pix10">If you have problems (e.g. with the <strong>cc</strong> or <strong>subject</strong> or <strong>body</strong> of the mail) with your emails when using the envelope icon then please contact us</span></td>
		</tr>

	</table>
</cfform>
 