<!--- called by GatherTeamsUnderClub.cfm  --->
<cfquery name="DelTeamInfo" datasource="zmast" >
	DELETE FROM teaminfo WHERE ID = #TeamInfoID#
</cfquery>
