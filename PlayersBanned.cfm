<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">


<cfinclude template="queries/qry_PlayersBanned.cfm">

<table width="75%" border="0" align="center" cellpadding="3" cellspacing="0" class="loggedinScreen">
	<tr>
		<td align="center"><span class="pix13bold">Matches<br>Banned</span></td>
		<td align="left"><span class="pix13bold">Surname</span></td>
		<td align="left"><span class="pix13bold">Forenames</span></td>
		<td align="center"><span class="pix13bold">Reg. No.</span></td>
		<td align="center"><span class="pix13bold">Appearances</span></td>
	</tr>
	
	<cfoutput query="PlayersBanned">
		<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
			<td align="center"><span class="pix13">#MatchCount#</span></td>
			<td align="left"><span class="pix13">#Surname#</span></td>
			<td align="left"><span class="pix13">#Forename#</span></td>
			<td align="right"><span class="pix13">#RegNo#</span></td>
			<td align="center"><span class="pix13"><a href="PlayersHist.cfm?PI=#PID#&LeagueCode=#LeagueCode#">see</a></span></td>
		</tr>
	</cfoutput>
</table>
