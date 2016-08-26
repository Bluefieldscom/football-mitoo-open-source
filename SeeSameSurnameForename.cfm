<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QSurnameForename.cfm">

<table border="1" align="center" cellpadding="2" cellspacing="2">

<!--- WARNING - These players have the same Surname and Forenames --->

<tr>
	<td align="center"><span class="pix10bold"> </span></td>
	<td align="center"><span class="pix10bold">Surname</span></td>
	<td align="center"><span class="pix10bold">Forename(s)</span></td>
	<td align="center"><span class="pix10bold">Date of Birth</span></td>
	<td align="center"><span class="pix10bold">Reg. No.</span></td>
	<td align="center"><span class="pix10bold">Notes</span></td>
	<td align="center"><span class="pix10bold">Club</span></td>
	<td align="center"><span class="pix10bold">Appearances</span></td>
	<cfif ListFind("Silver",request.SecurityLevel) >
		<td align="center"><span class="pix10bold">PlayerID</span></td>
	</cfif> 
</tr>
	<cfset PlayerIDList = ''>
	<cfset RegNoList = ''>
	<cfoutput query="QSurnameForename">
		<tr>
			<cfif QSurnameForename.Forename IS URL.fname>
				<td><span class="pix13boldred">*</span></td>
				<td><span class="pix13boldred"><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#">#surname#</a></span></td>
				<td><span class="pix13boldred">#forename#</span></td>
				<td><span class="pix13boldred">#Dateformat(MediumCol, 'DD MMM YYYY')#</span></td>
				<td><span class="pix13boldred">#ShortCol#</span></td>
				<td width="400"><span class="pix10boldred">#Notes#</span></td>
				<td><span class="pix10boldred">#TeamName#</span></td> 
				<td align="center"><span class="pix10boldred"><a href="PlayersHist.cfm?PI=#ID#&LeagueCode=#LeagueCode#">see</a></span></td>
				<cfif ListFind("Silver",request.SecurityLevel) >
					<td align="center">
					<span class="pix10">
					#ID# 
					<cfset PlayerIDList = ListAppend(PlayerIDList,ID)>
					<cfset RegNoList = ListAppend(RegNoList,ShortCol)>
					</span></td>
				</cfif> 

			<cfelse>
				<td><span class="pix13"> </span></td>
				<td><span class="pix13bold"><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#">#surname#</a></span></td>
				<td><span class="pix13">#forename#</span></td>
				<td><span class="pix13">#Dateformat(MediumCol, 'DD MMM YYYY')#</span></td>
				<td><span class="pix13">#ShortCol#</span></td>
				<td width="400"><span class="pix10">#Notes#</span></td>
				<td><span class="pix10">#TeamName#</span></td> 
				<td align="center"><span class="pix10"><a href="PlayersHist.cfm?PI=#ID#&LeagueCode=#LeagueCode#">see</a></span></td>
				<cfif ListFind("Silver",request.SecurityLevel) >
					<td align="center"><span class="pix10bold">&nbsp;</span></td>
				</cfif> 
			</cfif>
		</tr>
	</cfoutput>
</table>

<cfif ListLen(PlayerIDList) GE 2>
	<cfoutput>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td><span class="pix13">Merge #ListGetAt(PlayerIDList,1)# into #ListGetAt(PlayerIDList,2)# &nbsp;&nbsp;<a href="PlayerMerge.cfm?ID1=#ListGetAt(PlayerIDList,1)#&ID2=#ListGetAt(PlayerIDList,2)#&RegNo1=#ListGetAt(RegNoList,1)#&RegNo2=#ListGetAt(RegNoList,2)#&LeagueCode=#LeagueCode#">Do it</a></span></td>
		</tr>
		<tr>
			<td><span class="pix13">Merge #ListGetAt(PlayerIDList,2)# into #ListGetAt(PlayerIDList,1)# &nbsp;&nbsp;<a href="PlayerMerge.cfm?ID1=#ListGetAt(PlayerIDList,2)#&ID2=#ListGetAt(PlayerIDList,1)#&RegNo1=#ListGetAt(RegNoList,2)#&RegNo2=#ListGetAt(RegNoList,1)#&LeagueCode=#LeagueCode#">Do it</a></span></td>
		</tr>
	</table>
	</cfoutput>
</cfif>
<br />
<cfinclude template="PlayerHint.htm">
