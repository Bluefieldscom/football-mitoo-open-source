<!--- Need to be logged in to see this report --->
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode#EntireLeague" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>

<cfinclude template="InclLeagueInfo.cfm">
<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfinclude template = "queries/qry_QAllRegistn.cfm">
<table width="100%" border="1" cellspacing="0" cellpadding="3" >
	<cfoutput>
	<tr> 
		<td height="50" colspan="7" align="CENTER"> <span class="pix13bold">
		#SeasonName#<BR>#LeagueName#</span>
		</td>
	</tr>
	<tr>
		<td colspan="7" align="center"><span class="pix13bold">Player Registrations as at #DateFormat(Now(), 'DDDD, DD MMMM YYYY')#</span></td>
	</tr>
	<tr>
		<td colspan="7" align="center"><span class="pix10">A=Non-Contract; B=Contract; C=On Loan; D=Long Loan; E=Work Experience; G=Lapsed; F=Temporary</span></td>
	</tr>
	<title>Player Registrations</title>
	
	</cfoutput>
	<cfoutput query="QAllRegistn" group="Alpha">
		<tr>
			<td colspan="7" bgcolor="Floralwhite"><span class="pix13bold">#Alpha#</span></td>
		</tr>
		<tr>
			<td><span class="pix10bold">Surname</span></td>
			<td><span class="pix10bold">Forename</span></td>
			<td align="center"><span class="pix10bold">DOB</span></td>
			<td><span class="pix10bold">Club</span></td>
			<td><span class="pix10bold">&nbsp;</span></td>
			<td align="center"><span class="pix10bold">From</span></td>
			<td align="center"><span class="pix10bold">To</span></td>
		</tr>
		<cfoutput>
			<tr>
				<td><span class="pix10">#Surname#</span></td>
				<td><span class="pix10">#Forename#</span></td>
				<td align="center"><span class="pix10">#DateFormat(PlayerDOB, 'DD/MM/YY')#</span></td>
				<td><span class="pix10">#ClubName#</span></td>
				<td><span class="pix10">#RegType#</span></td>
				<cfif FirstDayOfRegistration IS "">
					<td align="center"><span class="pix10">&nbsp;</span></td>
				<cfelse>
					<td align="center"><span class="pix10">#DateFormat(FirstDayOfRegistration, 'DD/MM/YY')#</span></td>
				</cfif>
				<cfif LastDayOfRegistration IS "">
					<td align="center"><span class="pix10">&nbsp;</span></td>
				<cfelse>
					<td align="center"><span class="pix10">#DateFormat(LastDayOfRegistration, 'DD/MM/YY')#</span></td>
				</cfif>
			</tr>
		</cfoutput>
	</cfoutput>	
</table>
