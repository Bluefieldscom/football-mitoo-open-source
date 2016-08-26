<!--- Need to be logged in to see this report --->
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif StructKeyExists(URL, "TID") AND StructKeyExists(URL, "OID") >
	<cfset ThisTID = url.TID>
	<cfset ThisOID = url.OID>
<cfelseif StructKeyExists(form, "TID") AND StructKeyExists(form, "OID") >
	<cfset ThisTID = form.TID>
	<cfset ThisOID = form.OID>
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- This combination of LeagueCode, TeamID and OrdinalID MUST have at least one corresponding Constitution record --->
<cfinclude template="queries/qry_TID_OID.cfm">
<cfif QTID_OID.RecordCount IS 0>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>

<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfif ThisTID IS NOT "#request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>

<title>Team Details</title>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<!---
																					***************
																					* 2nd time in *
																					***************
--->
<cfset EmailErrorCount = 0 >
<cfloop from="1" to="3" step="1" index="IndexA">
	<cfloop from="1" to="2" step="1" index="IndexB">
		<cfset TestEmail = "Contact#IndexA#Email#IndexB#">
		<cfset FormTestEmail = "form.#TestEmail#">
		<cfif StructKeyExists(form, "#TestEmail#") AND Len(Trim(#Evaluate(FormTestEmail)#)) GT 0 >
			<cfif REFind("^[_a-z0-9-]+(\.[_a-z'0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name))$",#Evaluate(FormTestEmail)#) IS NOT 1>
				<!--- I got this expression from http://cookbooks.adobe.com/post_Validating_an_Email_Address_with_a_Regular_Express-16661.html --->
				<cfif IndexB IS 1>
					<cfset EmailMsg = "Home Email">
				<cfelse>
					<cfset EmailMsg = "Work Email">
				</cfif>
				<cfset EmailErrorCount = EmailErrorCount + 1 >
				<cfoutput><span class="pix18boldred">Contact #IndexA# #EmailMsg# </span><span class="monopix18blue"> <b>#Evaluate(FormTestEmail)#</b> </span><span class="pix18boldred"> is invalid.</span><br><span class="pix13boldred">It may be because you have CAPITAL letters in the email address, or spaces in front or after the email address. Please change these to lower case and try again.</span></cfoutput>
				<br>
			</cfif>
		</cfif>
	</cfloop>
</cfloop>
<cfif EmailErrorCount GT 0>
	<cfoutput><br><br><span class="pix18boldred">Please click on the Back button of your browser ... </span></cfoutput>
	<cfabort>
</cfif>

<cfset ContactErrorCount = 0 >
<cfloop from="1" to="3" step="1" index="IndexA">
	<cfset TestContact = "Contact#IndexA#Name">
	<cfset TestContactText = "Contact #IndexA# Name">
 <!--- Contact1JobDescrContact1AddressContact1TelNo1Contact1TelNo1DescrContact1TelNo2Contact1TelNo2DescrContact1TelNo3Contact1TelNo3Descr	--->
	<cfset FormTestContact = "form.#TestContact#">
	<cfif StructKeyExists(form, "#TestContact#") AND Len(Trim(#Evaluate(FormTestContact)#)) GT 0 >
		<cfif Len(Trim(#Evaluate(FormTestContact)#)) LT 3>
			<cfset ContactErrorCount = ContactErrorCount + 1 >
			<cfoutput><span class="pix18boldred">#TestContactText#</span><span class="monopix18blue"> <b>#Evaluate(TestContact)#</b> </span><span class="pix18boldred"> is invalid.</span></cfoutput>
			<br>
		</cfif>
	</cfif>
</cfloop>
<cfif ContactErrorCount GT 0>
	<cfoutput><br><br><span class="pix18boldred">Please click on the Back button of your browser ... </span></cfoutput>
	<cfabort>
</cfif>
<cfset ContactErrorCount = 0 >
<cfloop from="1" to="3" step="1" index="IndexA">
	<cfset TestContact = "Contact#IndexA#JobDescr">
	<cfset TestContactText = "Contact #IndexA# Job Description">
 <!--- Contact1JobDescrContact1AddressContact1TelNo1Contact1TelNo1DescrContact1TelNo2Contact1TelNo2DescrContact1TelNo3Contact1TelNo3Descr	--->
	<cfset FormTestContact = "form.#TestContact#">
	<cfif StructKeyExists(form, "#TestContact#") AND Len(Trim(#Evaluate(FormTestContact)#)) GT 0 >
		<cfif Len(Trim(#Evaluate(FormTestContact)#)) LT 3>
			<cfset ContactErrorCount = ContactErrorCount + 1 >
			<cfoutput><span class="pix18boldred">#TestContactText#</span><span class="monopix18blue"> <b>#Evaluate(TestContact)#</b> </span><span class="pix18boldred"> is invalid.</span></cfoutput>
			<br>
		</cfif>
	</cfif>
</cfloop>
<cfif ContactErrorCount GT 0>
	<cfoutput><br><br><span class="pix18boldred">Please click on the Back button of your browser ... </span></cfoutput>
	<cfabort>
</cfif>
<cfset ContactErrorCount = 0 >
<cfloop from="1" to="3" step="1" index="IndexA">
	<cfset TestContact = "Contact#IndexA#Address">
	<cfset TestContactText = "Contact #IndexA# Address">
 <!--- AddressContact1TelNo1Contact1TelNo1DescrContact1TelNo2Contact1TelNo2DescrContact1TelNo3Contact1TelNo3Descr	--->
	<cfset FormTestContact = "form.#TestContact#">
	<cfif StructKeyExists(form, "#TestContact#") AND Len(Trim(#Evaluate(FormTestContact)#)) GT 0 >
		<cfif Len(Trim(#Evaluate(FormTestContact)#)) LT 3>
			<cfset ContactErrorCount = ContactErrorCount + 1 >
			<cfoutput><span class="pix18boldred">#TestContactText#</span><span class="monopix18blue"> <b>#Evaluate(TestContact)#</b> </span><span class="pix18boldred"> is invalid.</span></cfoutput>
			<br>
		</cfif>
	</cfif>
</cfloop>
<cfif ContactErrorCount GT 0>
	<cfoutput><br><br><span class="pix18boldred">Please click on the Back button of your browser ... </span></cfoutput>
	<cfabort>
</cfif>

<cfset ContactErrorCount = 0 >
<cfloop from="1" to="3" step="1" index="IndexA">
	<cfloop from="1" to="3" step="1" index="IndexB">
		<cfset TestContact = "Contact#IndexA#TelNo#IndexB#">
		<cfset TestContactText = "Contact #IndexA# Telephone No #IndexB#">
		<cfset FormTestContact = "form.#TestContact#">
		<cfif StructKeyExists(form, "#TestContact#") AND Len(Trim(#Evaluate(FormTestContact)#)) GT 0 >
			<cfif Len(Trim(#Evaluate(FormTestContact)#)) LT 10>
				<cfset ContactErrorCount = ContactErrorCount + 1 >
				<cfoutput><span class="pix18boldred">#TestContactText#</span><span class="monopix18blue"> <b>#Evaluate(TestContact)#</b> </span><span class="pix18boldred"> is invalid.</span></cfoutput>
				<br>
			</cfif>
		</cfif>
	</cfloop>
</cfloop>
<cfif ContactErrorCount GT 0>
	<cfoutput><br><br><span class="pix18boldred">Please click on the Back button of your browser ... </span></cfoutput>
	<cfabort>
</cfif>

<cfif StructKeyExists(form, "Button")>
	<cfif Form.Button IS "Update">
		<cfset ThisTeamID = form.TID >
		<cfset ThisOrdinalID = form.OID >
		<cfinclude template="queries/upd_TeamDetails.cfm">
		<CFLOCATION URL="TeamDetailsUpdate.cfm?LeagueCode=#form.LeagueCode#&TID=#form.TID#&OID=#form.OID#"	ADDTOKEN="NO">
	</cfif>
	<!---
	<cfif Form.Button IS "Preview">
		<cfset ThisTeamID = form.TID >
		<cfset ThisOrdinalID = form.OID >
		<CFLOCATION URL="ClubList.cfm?LeagueCode=#form.LeagueCode#&fmTeamID=#form.TID#"	ADDTOKEN="NO">
	</cfif>
	--->
	<cfif Form.Button IS "Quit">
		<cfif SuppressTeamDetailsEntry IS "Yes" AND ListFind("Yellow",request.SecurityLevel) >
			<CFLOCATION URL="News.cfm?LeagueCode=#form.LeagueCode#"	ADDTOKEN="NO">
		<cfelse>
			<CFLOCATION URL="UpdateForm.cfm?TblName=Team&ID=#form.TID#&LeagueCode=#form.LeagueCode#"	ADDTOKEN="NO">
		</cfif>
	</cfif>
</cfif>
<!--- ====================================================================================================================================================== --->
<cfset ThisTeamID = URL.TID >
<cfset ThisOrdinalID = URL.OID >
<!--- Get the corresponding TeamDetails record for this LeagueCode, TeamID and OrdinalID. There should only be one record. --->
<cfinclude template="queries/qry_TeamDetails.cfm">
<!--- if there is no TeamDetails record for this LeagueCode, TeamID and OrdinalID we need to insert a new record --->
<cfif QTeamDetails.RecordCount IS 0 >
	<!--- create a NEW TeamDetails record for this TeamID and OrdinalID --->
	<cfinclude template="queries/ins_TeamDetails.cfm">
	<!--- Get the NEW TeamDetails record we have just inserted for this TeamID and OrdinalID --->
	<cfinclude template="queries/qry_TeamDetails.cfm">
</cfif>
<!--- Get the corresponding TeamDetails record for this LeagueCode, TeamID and OrdinalID. There should only be one record. --->
<cfif QTeamDetails.RecordCount IS 1 >
	<!--- Show the contents of this TeamDetails record --->
<cfelse>
	ERROR in TeamDetailsUpdate.cfm - aborting
	<cfabort>
</cfif>

<cfform name="TeamDetailsUpdate" action="TeamDetailsUpdate.cfm">
<cfoutput>
	<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
	<input type="Hidden" name="TID" value="#URL.TID#">
	<input type="Hidden" name="OID" value="#URL.OID#">
</cfoutput>
<table border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="Beige">
	<cfoutput query="QTeamDetails" >
		<cfif Len(Trim(TeamNotes)) GT 0 >
			<tr>
				<td>
					<table width="50%" border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="silver">
						<tr>
							<td><span class="pix10">#TeamNotes#</span></td>
						</tr>
					</table>
				</td>
			</tr>
		</cfif>
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
			<tr>
				<td>
					<table border="0" align="center" cellpadding="2" cellspacing="0" >
						<tr>
							<td align="center"><span class="pix10">Go to #TeamName# <a href="UpdateForm.cfm?TblName=Team&ID=#TID#&LeagueCode=#LeagueCode#"><u>main screen</u></a></span></td>
						</tr>
					</table>
				</td>
			</tr>
		</cfif>
		<cfif SuppressTeamDetailsEntry IS "Yes" AND ListFind("Yellow",request.SecurityLevel) >
			<tr>
				<td height="40" align="center" bgcolor="white"><span class="pix18boldred">If you want to change any of the details below please contact the league</span></td>
			</tr>
		</cfif>
		
		<cfinclude template="inclTeamDetailsSection.cfm">
	</cfoutput>
</table>
	
<cfoutput>
<table width="100%" border="0" cellspacing="0"  align="CENTER">
	<cfif SuppressTeamDetailsEntry IS "Yes" AND ListFind("Yellow",request.SecurityLevel) >
		<tr>
			<td height="40" colspan="2" align="center">
				<input type="Submit" name="Button" value="Quit">
			</td>
		</tr>
	<cfelse>
		<tr>
			<td height="40" align="CENTER">
				<input type="Submit" name="Button" value="Update">
			</td>
			<!---
			<td height="40" align="CENTER">
				<input type="Submit" name="Button" value="Preview">
			</td>
			--->
		</tr>
	</cfif>
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
		<tr>
			<td height="40" colspan="2" align="center">
				<input type="Submit" name="Button" value="Quit">
			</td>
		</tr>
	</cfif>
	<cfset ThisPA = "Team">
	<cfinclude template="queries/qry_TeamDetails.cfm">
	<cfif QTeamDetails.RecordCount GT 0>
	<cfset AllEmailString = "">
	
		<tr bgcolor="beige">
			<td>
				<table border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="beige">
					<cfloop query="QTeamDetails">
						<cfinclude template="TeamDetailsLoop.cfm">
					</cfloop>
				</table>
			</td>
		</tr>
	</cfif>
</table>
</cfoutput>
</cfform>
