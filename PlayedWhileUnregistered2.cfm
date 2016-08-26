<cfinclude template="queries/qry_PlayedWhileUnregistered2.cfm">
<cfif PlayedWhileUnregistered2.RecordCount GT "0">
	<table border="0" align="center" cellpadding="3" cellspacing="1">
		<cfoutput query="PlayedWhileUnregistered2" group="PlayerDescription">
		<tr>
			<td height="20" valign="bottom" >
			<span class="pix18boldred">WARNING: #PlayerDescription# appeared in these matches while unregistered</span></a>
			</td>
		</tr>
		<!---    <a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#">see Team Sheet</a> --->
		<cfoutput>
			<cfif CurrentRow Mod 2 IS 0 >
				<tr>
					<cfif HomeAway IS 'H'>
						<td colspan="2"><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - <strong>#HomeTeam# #HomeOrdinal#</strong> v #AwayTeam# #AwayOrdinal# </span></td>
					<cfelse>
						<td colspan="2"><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - #HomeTeam# #HomeOrdinal# v <strong>#AwayTeam# #AwayOrdinal#</strong> </span></td>
					</cfif>	
				</tr>	
			<cfelse>
				<tr>
					<cfif HomeAway IS 'H'>
						<td colspan="2"><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - <strong>#HomeTeam# #HomeOrdinal#</strong> v #AwayTeam# #AwayOrdinal# </span></td>
					<cfelse>
						<td colspan="2"><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')# - #HomeTeam# #HomeOrdinal# v <strong>#AwayTeam# #AwayOrdinal#</strong> </span></td>
					</cfif>	
				</tr>	
			</cfif>
		</cfoutput>
		
		</cfoutput>
	</table>
</cfif>	


