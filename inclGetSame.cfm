<!--- called by TeamList.cfm --->
<cfif HA is "H">
	<cfset CurrentTeamID = QTeamName.HomeTeamID>
<cfelse>
	<cfset CurrentTeamID = QTeamName.AwayTeamID>
</cfif>

<cfoutput>
<cfinclude template="queries/qry_QGetThisClubAppearances.cfm">
<cfif QGetThisClubAppearances.RecordCount GT 0>
	<td valign="top" bgcolor="#rowcolor#">
		<table border="1" cellspacing="0" cellpadding="1">
		<!---
			<tr>
				<td colspan="2" bgcolor="aqua"><span class="pix9">#ThisClubName#</span></td>
			</tr>
		--->
			<cfloop query="QGetThisClubAppearances">
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
			</cfloop>
		</table>
	</td>
</cfif>
</cfoutput>
