<!--- Need to be logged in to see this  --->
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!---
<cfdump var="#request#">
--->
<cfinclude template="InclBegin.cfm">
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfset fmTeamID = request.DropDownTeamID >
<cfelse>
	<cfset fmTeamID = url.TID >
	<cfset request.DropDownTeamID = fmTeamID >
</cfif>	

<table border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="beige" >
	<tr>
		<td>
			<cfinclude template="InclTeamDetails.cfm">		
		</td>
	</tr>
		<tr>
			<cfoutput>
			<td align="center">
				<table border="1" cellpadding="5" cellspacing="0">
					<tr>
						<td bgcolor="white"><span class="pix18boldnavy">#QClubStuff.ClubName#</span></td>
					</tr>
				</table>
			</td>
			</cfoutput>
		</tr>
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

</table>
