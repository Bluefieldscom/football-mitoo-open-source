<!--- called by TeamList.cfm --->
<!--- adds a link to add or upd/del suspension (for fully logged in and zmast.leagueinfo.MatchBasedSuspensions is 1 --->
<cfoutput>
<cfif ListFind("Silver,Skyblue",request.SecurityLevel) and MatchBasedSuspensions IS "1">
	<cfset ThisSDate = Dateformat(DateAdd('D', SuspensionStartsAfter, FixtureDate),'YYYY-MM-DD')>
	<cfinclude template = "queries/qry_QCheckThisSuspension.cfm">
	<!--- see if there are any suspensions for this PlayerID AND FirstDay = ThisSDate --->
	<cfif QCheckThisSuspension.RecordCount IS 0> <!--- add suspension --->
		<tr bgcolor="#rowcolor#">
			<td colspan="8" valign="top"><span class="pix10">&nbsp;</span></td>
			<td colspan="3" align="right" class="bg_suspend"><img src="gif/animatedredcard.gif"> <span class="pix10"><a href="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&PI=#ThisPlayerID#&FID=#FID#&SDate=#ThisSDate#">add</a> suspension</span></td>
		</tr>
	<cfelseif QCheckThisSuspension.RecordCount IS 1> <!--- upd/del suspension --->
		<tr bgcolor="#rowcolor#">
			<td colspan="8" valign="top"><span class="pix10">&nbsp;</span></td>
			<td colspan="3" align="right" class="bg_suspend"><img src="gif/animatedredcard.gif"> <span class="pix10"><a href="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&SI=#QCheckThisSuspension.ID#&FID=#FID#">upd/del</a> suspension</span></td>
		</tr>
	</cfif>
</cfif>
</cfoutput>
