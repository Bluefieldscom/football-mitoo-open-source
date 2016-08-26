<link href="fmstyle.css" rel="stylesheet" type="text/css">
<table border="1" align="center" cellpadding="2" cellspacing="0">
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
		<cfset ThisColSpan =5 >
	<cfelse>
		<cfset ThisColSpan = 4 >
	</cfif>
	<cfinclude template="queries/qry_QSuspensions.cfm">
	<cfoutput>
	<tr>
		<td colspan="#ThisColSpan#" align="center"><cfoutput><span class="pix18bold">Players Suspended for #DateFormat(ThisDate, 'DD MMMM YYYY')#</span></cfoutput></td>
	</tr>
	<tr>
		<td colspan="#ThisColSpan#" align="center"><cfoutput><span class="pix10red">Warning - this information may be incomplete or inaccurate</span></cfoutput></td>
	</tr>
	
	<tr>
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
		<td rowspan="2" bgcolor="lightblue"><span class="pix10bold">&nbsp;</span></td>
	</cfif>
	
		<td colspan="2" align="center"><span class="pix10bold">Player</span></td>
		<td colspan="2" align="center"><span class="pix10bold">Suspended</span></td>
		
	</tr>
	<tr>
		<td rowspan="2"><span class="pix10bold">Reg No</span></td>
		<td rowspan="2"><span class="pix10bold">Name</span></td>
		<td align="center"><span class="pix10bold">From</span></td>
		<td align="center"><span class="pix10bold">To</span></td>
	</tr>
	</cfoutput>
	<cfoutput query="QSuspensions" group="ClubName">
		<tr>
		</tr>
		<tr>
			<td colspan="#ThisColSpan#" bgcolor="silver"><span class="pix13bold">#ClubName#</span></td>
		</tr>
		<cfoutput>
			<tr>
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<td align="right" valign="top" bgcolor="lightblue"><span class="pix10"><a href="PlayersHist.cfm?PI=#QSuspensions.PlayerID#&LeagueCode=#LeagueCode#" target="_blank">see</a></span></td>
			</cfif>
				<td align="right" valign="top"><span class="pix10">#RegNo#</span></td>
				<td valign="top"><span class="pix10"> #Left(GetToken(Forename,1),1)# #Surname#</span></td>
				<td valign="top"><span class="pix10">#DateFormat(suspended_from, 'DD MMMM YYYY')#</span></td>
				<td valign="top"><cfif DateFormat(suspended_to, 'YYYY-MM-DD') IS '2999-12-31'><span class="pix10boldred">ongoing</span><cfelse><span class="pix10">#DateFormat(suspended_to, 'DD MMMM YYYY')#</span></cfif>
				<cfif NumberOfMatches GT 0><br><center><span class="pix10bold">#NumberOfMatches# match ban</span></center></cfif></td>
			</tr>
		</cfoutput>
	</cfoutput>

</table>



