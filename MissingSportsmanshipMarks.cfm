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
		<cfinclude template="queries/qry_QMissingSportsmanshipMarksX.cfm">
<cfelse>
		<cfinclude template="queries/qry_QMissingSportsmanshipMarks.cfm">
</cfif>

<cfif QMissingSportsmanshipMarks.RecordCount GT "0">
	<cfif QMissingSportsmanshipMarks.RecordCount GT "1">
		<span class="pix13bold"><BR><BR>There are <cfoutput>#QMissingSportsmanshipMarks.RecordCount#</cfoutput> matches with missing Sportsmanship marks.<br></span>
	<cfelse>
		<span class="pix13bold"><BR><BR>There's only one match with missing Sportsmanship marks!<br></span>
	</cfif>
	<span class="pix13boldred">Put </span><span class="monopix12">IgnoreMissingSportsmanshipMarks</span><span class="pix13boldred"> into PRIVATE Notes in Fixture to suppress.</span><br>
	
	<table width="100%" border="0" cellpadding="2" cellspacing="2">
	<cfoutput query="QMissingSportsmanshipMarks" group="FixtureDate">
		<tr><td align="left" bgcolor="silver"><span class="pix16bold">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></td></tr>
			
			<cfoutput group="DivName">
				<tr><td align="left"><span class="pix13bold">#DivName#</span></td></tr>
		<cfoutput group="RefsName">
			<tr><td align="left"><span class="pix13">#RefsName#<BR></span></td></tr>		
				
				<cfoutput>
					<tr><td align="left">
					
							<cfif IgnoreExternalCompetitions IS "Yes">
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MSX"><span class="pix13">#HomeTeam# #HomeOrdinal# &nbsp;#HomeGoals# v #AwayGoals#&nbsp; #AwayTeam# #AwayOrdinal#</span></a>
							<cfelse>
								<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MS"><span class="pix13">#HomeTeam# #HomeOrdinal# &nbsp;#HomeGoals# v #AwayGoals#&nbsp; #AwayTeam# #AwayOrdinal#</span></a>
							</cfif>
					<cfif TRIM(#RoundName#)IS NOT "" >			<!--- e.g. [ Round 1 ] --->
						<span class="pix13">[ #RoundName# ]</span>
					</cfif>
					</td></tr>
				</cfoutput>
			</cfoutput>
		</cfoutput>
	</cfoutput>
	</table>
<cfelse>
	<span class="pix13bold"><br>There are no matches with missing Sportsmanship marks.<br><br>Excellent!</span>
</cfif>	
