<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">


<cfinclude template = "queries/qry_ShortLoanAppearances.cfm">
<cfif ShortLoanAppearances.RecordCount GT 0>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td colspan="2"><span class="pix13boldred">Too many Short Loan players on team sheet. Max. 2 allowed.</span></td>
		</tr>
		<cfoutput query="ShortLoanAppearances">
			<tr>
				<td><span class="pix10">#dateformat(fixturedate, 'DD MMM YYYY')#</span></td>
				<cfif HomeAway IS "H">
					<td><span class="pix10bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">#HomeTeam#</a></span><span class="pix10"> v #AwayTeam#</span></td>
				<cfelse>
					<td><span class="pix10">#HomeTeam# v </span><span class="pix10bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">#AwayTeam#</a></span></td>
				</cfif>
			</tr>
		</cfoutput>
	</table>
<cfelse>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td height="40" colspan="2"><span class="pix13bold">Short Loan players checked O.K.</span></td>
		</tr>
	</table>
</cfif>

<cfinclude template = "queries/qry_LongLoanAppearances.cfm">
<cfif LongLoanAppearances.RecordCount GT 0>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td colspan="2"><span class="pix13boldred">Too many Long Loan players on team sheet. Max. 2 allowed.</span></td>
		</tr>
		<cfoutput query="LongLoanAppearances">
			<tr>
				<td><span class="pix10">#dateformat(fixturedate, 'DD MMM YYYY')#</span></td>
				<cfif HomeAway IS "H">
					<td><span class="pix10bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">#HomeTeam#</a></span><span class="pix10"> v #AwayTeam#</span></td>
				<cfelse>
					<td><span class="pix10">#HomeTeam# v </span><span class="pix10bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">#AwayTeam#</a></span></td>
				</cfif>
			</tr>
		</cfoutput>
	</table>
<cfelse>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td height="40" colspan="2"><span class="pix13bold">Long Loan players checked O.K.</span></td>
		</tr>
	</table>
</cfif>


<cfinclude template = "queries/qry_WorkExperienceAppearances.cfm">
<cfif WorkExperienceAppearances.RecordCount GT 0>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td colspan="2"><span class="pix13boldred">Too many Work Experience players on team sheet. Max. 2 allowed.</span></td>
		</tr>
		<cfoutput query="WorkExperienceAppearances">
			<tr>
				<td><span class="pix10">#dateformat(fixturedate, 'DD MMM YYYY')#</span></td>
				<cfif HomeAway IS "H">
					<td><span class="pix10bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">#HomeTeam#</a></span><span class="pix10"> v #AwayTeam#</span></td>
				<cfelse>
					<td><span class="pix10">#HomeTeam# v </span><span class="pix10bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">#AwayTeam#</a></span></td>
				</cfif>
			</tr>
		</cfoutput>
	</table>
<cfelse>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td height="40" colspan="2"><span class="pix13bold">Work Experience players checked O.K.</span></td>
		</tr>
	</table>
</cfif>

<cfinclude template = "queries/qry_SLLLWEAppearances.cfm">
<cfif SLLLWEAppearances.RecordCount GT 0>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td colspan="2"><span class="pix13boldred">Too many Short Loan, Long Loan or Work Experience players on team sheet. Max. 5 allowed.</span></td>
		</tr>
		<cfoutput query="SLLLWEAppearances">
			<tr>
				<td><span class="pix10">#dateformat(fixturedate, 'DD MMM YYYY')#</span></td>
				<cfif HomeAway IS "H">
					<td><span class="pix10bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">#HomeTeam#</a></span><span class="pix10"> v #AwayTeam#</span></td>
				<cfelse>
					<td><span class="pix10">#HomeTeam# v </span><span class="pix10bold"><a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">#AwayTeam#</a></span></td>
				</cfif>
			</tr>
		</cfoutput>
	</table>
<cfelse>
	<table border="0" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td height="40" colspan="2"><span class="pix13bold">Sum of Short Loan, Long Loan and Work Experience checked O.K.</span></td>
		</tr>
	</table>
</cfif>
