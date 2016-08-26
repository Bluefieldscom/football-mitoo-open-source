<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QSurnameDOB.cfm">
<table border="1" align="center" cellpadding="2" cellspacing="2">

<!--- WARNING - These players with surname "#URL.sname#" have the same date of birth --->
<tr>
	<td align="center"><span class="pix10bold"> </span></td>
	<td align="center"><span class="pix10bold">Surname</span></td>
	<td align="center"><span class="pix10bold">Forename(s)</span></td>
	<td align="center"><span class="pix10bold">Date of Birth</span></td>
	<td align="center"><span class="pix10bold">Reg. No.</span></td>
	<td align="center"><span class="pix10bold">Notes</span></td>
	<td align="center"><span class="pix10bold">Club</span></td>
	<td align="center"><span class="pix10bold">Appearances</span></td>
</tr>

	<cfoutput query="QSurnameDOB">
		<tr>
			<cfif QSurnameDOB.MediumCol IS URL.DOB>
				<td><span class="pix13boldred">*</span></td>
				<td><span class="pix13boldred"><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#">#surname#</a></span></td>
				<td><span class="pix13boldred">#forename#</span></td>
				<td><span class="pix13boldred">#Dateformat(MediumCol, 'DD MMM YYYY')#</span></td>
				<td><span class="pix13boldred">#ShortCol#</span></td>
				<td width="400"><span class="pix10boldred">#Notes#</span></td>
				<td><span class="pix10boldred">#TeamName#</span></td> 
				<td align="center"><span class="pix10boldred"><a href="PlayersHist.cfm?PI=#ID#&LeagueCode=#LeagueCode#">see</a></span></td>
			<cfelse>
				<td><span class="pix13"> </span></td>
				<td><span class="pix13bold"><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#">#surname#</a></span></td>
				<td><span class="pix13">#forename#</span></td>
				<td><span class="pix13">#Dateformat(MediumCol, 'DD MMM YYYY')#</span></td>
				<td><span class="pix13">#ShortCol#</span></td>
				<td width="400"><span class="pix10">#Notes#</span></td>
				<td><span class="pix10">#TeamName#</span></td>
				<td align="center"><span class="pix10"><a href="PlayersHist.cfm?PI=#ID#&LeagueCode=#LeagueCode#">see</a></span></td>
			</cfif>
		</tr>
	</cfoutput>
</table>
<cfinclude template="PlayerHint.htm">
