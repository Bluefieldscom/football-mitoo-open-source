<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">

<cfset CutOffDate1 = "#LeagueCodeYear#-12-31">
<cfset MaxCardCount1 = 5 >
<cfset CutOffDate2 = "#LeagueCodeYear+1#-04-10">
<cfset MaxCardCount2 = 10 >
<cfset CutOffDate3 = "#LeagueCodeYear+1#-05-31">
<cfset MaxCardCount3 = 15 >

<cfinclude template="queries/qry_CautionThresholds.cfm">

<cfif CautionThresholds1.RecordCount GT 0>
	<table width="75%" border="0" cellpadding="3" cellspacing="0" class="loggedinScreen">
		<cfoutput>
		<tr>
			<td height="40" colspan="4"><span class="pix13bold">Players with #MaxCardCount1# or more cautions between the first day of the season and #DateFormat(CutOffDate1, 'DD MMMM')#</span></td>
		</tr>
		</cfoutput>
		<tr>
			<td><span class="pix13bold">Surname</span></td>
			<td><span class="pix13bold">Forenames</span></td>
			<td align="center"><span class="pix13bold">Appearances</span></td>
			<td><span class="pix13bold">Cautions</span></td>
		</tr>
		
		<cfoutput query="CautionThresholds1">
			<tr>
				<td><span class="pix13">#Surname#</span></td>
				<td><span class="pix13">#Forename#</span></td>
				<td align="center"><span class="pix13"><a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#">see</a></span></td>
				<td><span class="pix13">#totalcard#</span></td>
			</tr>
		</cfoutput>
	</table>
</cfif>
<cfif CautionThresholds2.RecordCount GT 0>
	<table width="75%" border="0" cellpadding="3" cellspacing="0" class="loggedinScreen">
		<cfoutput>
		<tr>
			<td height="40" colspan="4"><span class="pix13bold">Players with #MaxCardCount2# or more cautions between the first day of the season and #DateFormat(CutOffDate2, 'DD MMMM')#</span></td>
		</tr>
		</cfoutput>
		<tr>
			<td><span class="pix13bold">Surname</span></td>
			<td><span class="pix13bold">Forenames</span></td>
			<td align="center"><span class="pix13bold">Appearances</span></td>
			<td><span class="pix13bold">Cautions</span></td>
		</tr>
		
		<cfoutput query="CautionThresholds2">
			<tr>
				<td><span class="pix13">#Surname#</span></td>
				<td><span class="pix13">#Forename#</span></td>
				<td align="center"><span class="pix13"><a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#">see</a></span></td>
				<td><span class="pix13">#totalcard#</span></td>
			</tr>
		</cfoutput>
	</table>
</cfif>
<cfif CautionThresholds3.RecordCount GT 0>
	<table width="75%" border="0" cellpadding="3" cellspacing="0" class="loggedinScreen">
		<cfoutput>
		<tr>
			<td height="40" colspan="4"><span class="pix13bold">Players with #MaxCardCount3# or more cautions between the first day of the season and #DateFormat(CutOffDate3, 'DD MMMM')#</span></td>
		</tr>
		</cfoutput>
		<tr>
			<td><span class="pix13bold">Surname</span></td>
			<td><span class="pix13bold">Forenames</span></td>
			<td align="center"><span class="pix13bold">Appearances</span></td>
			<td><span class="pix13bold">Cautions</span></td>
		</tr>
		
		<cfoutput query="CautionThresholds3">
			<tr>
				<td><span class="pix13">#Surname#</span></td>
				<td><span class="pix13">#Forename#</span></td>
				<td align="center"><span class="pix13"><a href="PlayersHist.cfm?PI=#PlayerID#&LeagueCode=#LeagueCode#">see</a></span></td>
				<td><span class="pix13">#totalcard#</span></td>
			</tr>
		</cfoutput>
	</table>
</cfif>
