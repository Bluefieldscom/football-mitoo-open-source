<!--- called by GatherTeamsUnderClub.cfm  --->
<cfquery name="QTeamLongCol" datasource="fm#ThisLeagueCodeYear#">
	SELECT LongCol FROM team WHERE ID = #fmTeamID#
</cfquery>
