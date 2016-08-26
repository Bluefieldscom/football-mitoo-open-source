<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings but to allow default values for Division etc--->
<cfset RefsHist = "No">
<cfinclude template="InclBegin.cfm">

<cfset IgnoreExternalCompetitions = "No">

<cfif StructKeyExists(url, "External")>
	<cfif url.External IS "N">
		<cfset IgnoreExternalCompetitions = "Yes">
	</cfif>
</cfif>

<cfif IgnoreExternalCompetitions IS "Yes">
	<cfinclude template="queries/qry_QMissingRefereesMarksX.cfm">
<cfelse>
	<cfinclude template="queries/qry_QMissingRefereesMarks.cfm">
</cfif>

<cfif QMissingRefereesMarks.RecordCount GT "0">
	<cfoutput>
	<cfif QMissingRefereesMarks.RecordCount GT "1">
		<span class="pix13bold"><BR><BR>There are <cfoutput>#QMissingRefereesMarks.RecordCount#</cfoutput> matches with missing referees' marks for games played before #DateFormat(CreateODBCDate(NOW()- 3 ), 'DDDD, DD MMMM YYYY')#</span>
	<cfelse>
		<span class="pix13bold"><BR><BR>There's only one match with missing referees' marks for games played before #DateFormat(CreateODBCDate(NOW()- 3 ), 'DDDD, DD MMMM YYYY')#</span>
	</cfif>
	<br><span class="pix13boldred">Put </span><span class="monopix12">IgnoreMissingRefereeMarks</span><span class="pix13boldred"> into PRIVATE Notes in Fixture to suppress.</span><br>
	</cfoutput>
	<table width="100%" border="0" cellpadding="2" cellspacing="2">
		<cfoutput query="QMissingRefereesMarks" group="FixtureDate">
			<tr><td align="left" bgcolor="silver"><span class="pix16bold">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></td></tr>
			<cfoutput group="RefsName">
				<tr><td align="left"><span class="pix13bold">#RefsName#</span></td></tr>
				<cfoutput group="DivName">
					<tr><td align="left"><span class="pix13">#DivName#</span></td></tr>
					<cfoutput>
						<tr><td align="left">
							<cfif IgnoreExternalCompetitions IS "Yes">
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MRX"><span class="pix13">#HomeTeam# #HomeOrdinal# &nbsp;#HomeGoals# v #AwayGoals#&nbsp; #AwayTeam# #AwayOrdinal#</span></a>
							<cfelse>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MR"><span class="pix13">#HomeTeam# #HomeOrdinal# &nbsp;#HomeGoals# v #AwayGoals#&nbsp; #AwayTeam# #AwayOrdinal#</span></a>
							</cfif>
							<cfif TRIM(#RoundName#)IS NOT "" >			<!--- e.g. [ Round 1 ] --->
								<span class="pix13">[ #RoundName# ]</span>
							</cfif>
							<cfif RefereeMarksH IS ""><span class="pix13boldred">&nbsp;H</span></cfif>
							<cfif RefereeMarksA IS ""><span class="pix13boldred">&nbsp;A</span></cfif>
							<cfif TRIM(#FixtureNotes#)IS NOT "" >
								<span class="pix10">#FixtureNotes#</span>
							</cfif>
						</td></tr>
					</cfoutput>
				</cfoutput>
			</cfoutput>
		</cfoutput>
	</table>
	
<cfelse>
		<br><span class="pix13bold">There are no matches with missing referees' marks.<br><br>Excellent!</span>
</cfif>	
