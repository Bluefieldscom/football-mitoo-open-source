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
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=PrivateComments.xls">

<cfset TeamID = request.DropDownTeamID>
<cfinclude template = "queries/qry_QRegistD.cfm">
<cfif QRegistD.RecordCount GT 0 >
	<cfoutput>
	<table border="0" cellpadding="5" cellspacing="5" >
		<tr> <td colspan="3" align="center"><font size="+2">#SeasonName#</font></td></tr>
		<tr> <td colspan="3" align="center"><font size="+2">#LeagueName#</font></td></tr>
		<tr> <td colspan="3" align="center"><font size="+4">#QRegistD.ClubName#</font></td></tr>
		<tr align="center" bgcolor="silver"> 
			<td width="85" height="30">RegNo</td>
			<td width="450" height="30">Name</td>
			<td width="80">Date of Birth</td>
		</tr>
	</cfoutput>
	<cfoutput query="QRegistD" group="RPID">
		<tr>	
		<!---
			*******************
			* Player's Reg No *
			*******************
			--->
			<td>#PlayerRegNo#</td>
		<!---
			******************
			* Player's name  *
			******************
			--->
			<td><strong>#GetToken(PlayerName,1)#</strong> #GetToken(PlayerName,2)# #GetToken(PlayerName,3)# #GetToken(PlayerName,4)# #GetToken(PlayerName,5)#</td>
		<!---
			******************
			* Date of Birth  *
			******************
			--->
			<cfif PlayerDOB IS "">
				<td>&nbsp;</td>
			<cfelse>
				<td>#DateFormat( PlayerDOB , 'DD/MM/YY')#</td>
			</cfif>
		</tr>		

		<cfif LEN(TRIM(PlayerNotes)) GT 0 >
			<tr>
			<!---
				*********
				* Notes *
				*********
				--->
				<td></td>
				<td colspan="2">#PlayerNotes#</td>
			</tr>
		</cfif>
		
		<tr>
			<td colspan="3"><br>Amendments:<br><br>Signature:<br><br><hr></td>
		</tr>		
	</cfoutput>
</cfif>