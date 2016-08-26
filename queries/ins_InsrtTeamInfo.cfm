<!--- called by GatherTeamsUnderClub.cfm --->
<cftry>
	<cfquery name="InsrtTeamInfo" datasource="zmast" >
		INSERT INTO teaminfo (fmTeamID, LeagueInfoID, ClubInfoID ) VALUES ( #fmTeamID# , #LeagueInfoID#, #ClubInfoID# )
	</cfquery>
	<cfcatch type="Database">
		<cfif cfcatch.NativeErrorCode IS "1062">
			<!--- duplicate values on Leaguecode,Shortcol(unique ID) - Check --->
				<cfmodule template="../dberrorpage.cfm" source="clubinfo" errortype="duplicatekey" message="indexno">
		</cfif>
	</cfcatch>
</cftry>
