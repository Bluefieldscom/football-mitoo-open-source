<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings but to allow default values for Division etc--->
<cfset RefsHist = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QMissingHospitalityMarks.cfm">
<cfif QMissingHospitalityMarks.RecordCount GT "0">
	<cfif QMissingHospitalityMarks.RecordCount GT "1">
		<span class="pix13bold"><BR><BR>There are <cfoutput>#QMissingHospitalityMarks.RecordCount#</cfoutput> matches with missing Hospitality marks.<br></span>
	<cfelse>
		<span class="pix13bold"><BR><BR>There's only one match with missing Hospitality marks!<br></span>
	</cfif>
	<table width="100%" border="0" cellpadding="2" cellspacing="2">
		<cfoutput query="QMissingHospitalityMarks" group="FixtureDate">
			<tr><td align="left" bgcolor="silver"><span class="pix16bold">#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span></td></tr>
				<cfoutput group="DivName">
					<tr><td align="left"><span class="pix13bold">#DivName#</span></td></tr>
					<cfoutput>
						<tr><td align="left">
						<a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#HomeID#&AwayID=#AwayID#&LeagueCode=#LeagueCode#&Whence=MS">
						<span class="pix13"><u>#HomeTeam# #HomeOrdinal# &nbsp;#HomeGoals# v #AwayGoals#&nbsp; #AwayTeam# #AwayOrdinal#</u></span></a>
						<cfif TRIM(#RoundName#)IS NOT "" >			<!--- e.g. [ Round 1 ] --->
							<span class="pix13">[ #RoundName# ]</span>
						</cfif>
						</td></tr>
					</cfoutput>
				</cfoutput>
		</cfoutput>
	</table>
<cfelse>
	<span class="pix13bold"><br>There are no matches with missing Hospitality marks.<br><br>Excellent!</span>
</cfif>	
