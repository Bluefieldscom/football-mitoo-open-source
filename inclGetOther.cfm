<!--- called by TeamList.cfm --->
<cfoutput>
<cfif HA is "H">
	<cfset CurrentTeamID = QTeamName.HomeTeamID>
<cfelse>
	<cfset CurrentTeamID = QTeamName.AwayTeamID>
</cfif>
<cfinclude template="queries/qry_QGetOtherTeams.cfm">
<cfif QGetOtherTeams.RecordCount GT 0>
<td valign="top" bgcolor="#rowcolor#">
	<table border="1" cellspacing="0" cellpadding="1" >
		<cfloop query="QGetOtherTeams">
			<cfset SpecifiedTeamID = QGetOtherTeams.TeamID >
			<cfinclude template="queries/qry_QGetOtherAppearances.cfm">
			<cfif QGetOtherAppearances.TimesAppeared GT 0 >
				<tr>
					<td colspan="4" bgcolor="white"><span class="pix9">#QGetOtherTeams.LongCol#</span></td>
				</tr>
				<cfloop query="QGetOtherAppearances">
					<cfif KnockOutCompetition IS "Yes"> <!--- highlight players who may be cup tied --->
						<cfif QTeamName.DivisionName IS CompetitionName>
							<tr bgcolor="red">
								<td height="25"><span class="pix10boldwhite"><strong>&##8226;</strong> #CompName#</span></td>
								<td height="25" align="right"><span class="pix10boldwhite"><cfif TimesAppeared1 IS 0>&nbsp;<cfelse>#TimesAppeared1#</cfif></span></td>
								<td height="25" align="right" bgcolor="silver"><span class="pix10bold"><cfif TimesAppeared2 IS 0>&nbsp;<cfelse>#TimesAppeared2#</cfif></span></td>
								<td height="25" align="right" bgcolor="white"><span class="pix10bold"><cfif TimesAppeared3 IS 0>&nbsp;<cfelse>#TimesAppeared3#</cfif></span></td>
								
							</tr>
						<cfelse>
							<tr>
								<td><span class="pix9">#CompName#</span></td>
								<td align="right"><span class="pix9"><cfif TimesAppeared1 IS 0>&nbsp;<cfelse>#TimesAppeared1#</cfif></span></td>
								<td align="right" bgcolor="silver"><span class="pix9"><cfif TimesAppeared2 IS 0>&nbsp;<cfelse>#TimesAppeared2#</cfif></span></td>
								<td align="right" bgcolor="white"><span class="pix9"><cfif TimesAppeared3 IS 0>&nbsp;<cfelse>#TimesAppeared3#</cfif></span></td>
							</tr>
						</cfif>
					<cfelse>
						<cfif QTeamName.DivisionName IS CompetitionName>
							<tr>
								<td><span class="pix9"><strong>&##8226;</strong> #CompName#</span></td>
								<td align="right"><span class="pix9"><cfif TimesAppeared1 IS 0>&nbsp;<cfelse>#TimesAppeared1#</cfif></span></td>
								<td align="right" bgcolor="silver"><span class="pix9"><cfif TimesAppeared2 IS 0>&nbsp;<cfelse>#TimesAppeared2#</cfif></span></td>
								<td align="right" bgcolor="white"><span class="pix9"><cfif TimesAppeared3 IS 0>&nbsp;<cfelse>#TimesAppeared3#</cfif></span></td>
							</tr>
						<cfelse>
							<tr>
								<td><span class="pix9">#CompName#</span></td>
								<td align="right"><span class="pix9"><cfif TimesAppeared1 IS 0>&nbsp;<cfelse>#TimesAppeared1#</cfif></span></td>
								<td align="right" bgcolor="silver"><span class="pix9"><cfif TimesAppeared2 IS 0>&nbsp;<cfelse>#TimesAppeared2#</cfif></span></td>
								<td align="right" bgcolor="white"><span class="pix9"><cfif TimesAppeared3 IS 0>&nbsp;<cfelse>#TimesAppeared3#</cfif></span></td>
							</tr>
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
		</cfloop>
	</table>
</td>
</cfif>
</cfoutput>
