<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfset CutOffDate1 = "#LeagueCodeYear#-12-31">
<cfset MaxCardCount1 = 5 >
<cfset CutOffDate2 = "#LeagueCodeYear+1#-04-10">
<cfset MaxCardCount2 = 10 >
<cfset CutOffDate3 = "#LeagueCodeYear+1#-05-31">
<cfset MaxCardCount3 = 15 >

<cfinclude template="queries/qry_CautionThresholdsPI.cfm">

<cfif CautionThresholds1.RecordCount GT 0>
	<table width="100%" border="1" cellspacing="0" cellpadding="5" class="loggedinScreen">	
		<cfoutput>
		<tr>
			<td height="40" colspan="4"><span class="pix18boldred">#MaxCardCount1# or more cautions [#CautionThresholds1.totalcard#] between the first day of the season and #DateFormat(CutOffDate1, 'DD MMMM')#</span></td>
		</tr>
		</cfoutput>
	</table>
</cfif>
<cfif CautionThresholds2.RecordCount GT 0>
	<table width="100%" border="1" cellspacing="0" cellpadding="5" class="loggedinScreen">	
		<cfoutput>
		<tr>
			<td height="40" colspan="4"><span class="pix18boldred">#MaxCardCount2# or more cautions [#CautionThresholds2.totalcard#] between the first day of the season and #DateFormat(CutOffDate2, 'DD MMMM')#</span></td>
		</tr>
		</cfoutput>
	</table>
</cfif>
<cfif CautionThresholds3.RecordCount GT 0>
	<table width="100%" border="1" cellspacing="0" cellpadding="5" class="loggedinScreen">	
		<cfoutput>
		<tr>
			<td height="40" colspan="4"><span class="pix18boldred">#MaxCardCount3# or more cautions [#CautionThresholds3.totalcard#] between the first day of the season and #DateFormat(CutOffDate3, 'DD MMMM')#</span></td>
		</tr>
		</cfoutput>
	</table>
</cfif>
