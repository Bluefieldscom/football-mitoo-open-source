<!---
																					***************
																					* 2nd time in *
																					***************
--->
<cfif StructKeyExists(form, "Button")>
	<cfif Form.Button IS "Classic">
		<cfset request.fmView = "Classic" >
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.fmView = request.fmView >
		</cflock>
	<cfelseif Form.Button IS "Drop Down">
		<cfset request.fmView = "DropDown" >
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.fmView = request.fmView >
		</cflock>
	<cfelse>
		aborting.....1.....ViewChange.cfm
		<cfabort> 
	</cfif>
	<CFLOCATION URL="ViewChange.cfm?LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!--- ====================================================================================================================================================== --->


<cfform name="ViewChange" action="ViewChange.cfm" >
	<cfoutput>
		<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
		<input type="Hidden" name="ID" value="#QLeagueCode.ID#">
	</cfoutput>

	<table width="100%" border="0" cellspacing="0" align="CENTER">
<!---
	<cfif StructKeyExists(session, "fmView")>
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.fmView = session.fmView >
		</cflock>
	</cfif>
--->	
	<cfif request.fmView IS "Classic">
				<tr align="CENTER">
					<td height="200" ><span class="pix13bold">You are currently viewing <em>football.mitoo</em> in "Classic" mode.<br /><br />
					Please click on <input type="Submit" name="Button" value="Drop Down"> to change the view to "Drop Down" mode.</span>
					</td>
				</tr>
	<cfelseif request.fmView IS "DropDown">
				<tr align="CENTER">
					<td height="200" ><span class="pix13bold">You are currently viewing <em>football.mitoo</em> in "Drop Down" mode.<br /><br />
					Please click on <input type="Submit" name="Button" value="Classic"> to change the view to "Classic" mode.</span>
					</td>
				</tr>
	<cfelse>
		aborting.....2.....ViewChange.cfm
		<cfabort> 
	</cfif>
	</table>
</cfform>
