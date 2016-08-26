<!--- Need to be logged in to see this report --->
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>

<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<cfset TeamID = request.DropDownTeamID>

<cfinclude template = "queries/qry_QRegistDPDF.cfm">
<cfif QRegistDPDF.RecordCount IS 0 >
	No Players
	<cfabort>
</cfif>


<!--- Get Notes from newsitem table for this league where longcol is 'RegistListPDF' --->
<cfinclude template="queries/qry_QRegistListPDF.cfm">
<cfif QRegistListPDF.RecordCount IS 1>
	<cfset ThisText = Trim(QRegistListPDF.Notes) >
<cfelse>
	<cfset ThisText = 'I confirm that etc.... (please contact INSERT_EMAIL_HERE to set up correct wording for this league)' >
</cfif>
<cfdocument format="PDF" pageType="A4" marginTop="1.5" marginBottom="1.5" orientation = "landscape" scale="80">
	<cfdocumentitem type="header" scale="80">
		<cfoutput>
			<font color="black" face="Verdana, Arial, Helvetica, sans-serif">
				<table width="100%" border="0" cellpadding="2" cellspacing="2"  >
					<tr><td colspan="7" align="center" ><br><br>#Namesort#</td></tr>
					<tr><td colspan="7" align="center" ><strong>#QRegistDPDF.ClubName# - Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</strong></td></tr>
					<tr><td colspan="7" align="center" >To play open age football the player must have achieved the age of 16.</td></tr>
					<tr>
						<td width="5%" align="left" valign="top">RegNo&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td valign="top" align="left" width="15%">Surname</td>
						<td valign="top" align="left" width="15%">Forenames</td>
						<td valign="top" align="left" width="5%">Date of Birth</td>
						<td valign="top" align="left" width="30%">Address</td>
						<td width="30%" align="right" valign="top">Player's Signature & Date</td>
					</tr>
				</table>
			</font>
		</cfoutput>
	</cfdocumentitem>
	
	<cfdocumentitem type="footer" scale="80"  >
		<cfoutput>
			<font color="black" face="Verdana, Arial, Helvetica, sans-serif">
				<table width="100%" border="0" cellpadding="2" cellspacing="2"  >
					<tr>
						<td width="80%" align="left" valign="top"  >#ThisText#</td>
						<td width="20%" valign="top" align="left" ><strong>Secretary's Signature & Date:</strong><br><br><br>____________________________________________
						</td>
					</tr>
				</table>
			</font>
		</cfoutput>
	</cfdocumentitem>
	
	<cfoutput query="QRegistDPDF">
		<font color="black" face="Verdana, Arial, Helvetica, sans-serif">
		<table width="100%" border="0" cellpadding="10" cellspacing="2"  >
			<tr>
				<td align="left"width="8%" valign="top">#PlayerRegNo#</td>
				<td align="left" valign="top" width="15%"  ><strong>#Surname#</strong></td>
				<td align="left" valign="top" width="10%" >#Forename#</td>
				<cfif PlayerDOB IS "">
					<td align="left" valign="top" width="5%">&nbsp;</td>
				<cfelse>
					<td align="left" valign="top" width="5%">#DateFormat(PlayerDOB , 'DD/MM/YY')#</td>
				</cfif>
				<!--- applies to season 2012 onwards only --->
				<cfif RIGHT(request.dsn,4) GE 2012>
					<cfif Len(Trim(AddressLine1)) IS 0 AND Len(Trim(AddressLine2)) IS 0 AND Len(Trim(AddressLine3)) IS 0 AND Len(Trim(Postcode)) IS 0>
						<td align="left" width="40%" valign="top">#PlayerNotes#</td>
					<cfelse>
						<td align="left" width="40%" valign="top">#AddressLine1#<br>#AddressLine2#<br>#AddressLine3#<br>#Postcode#</td>
					</cfif>
				<cfelse>
					<td align="left" width="40%" valign="top">#PlayerNotes#</td>
				</cfif>
				<td width="22%" align="right"  valign="bottom">_________________________</td>
			</tr>
		</table>
		</font>
	</cfoutput>
</cfdocument>
