<!--- called by GatherTeamsUnderClubProcess2.cfm  --->
<cfquery name="DelClubInfo" datasource="zmast" >
	DELETE FROM clubinfo WHERE ID = #ClubInfoID#
</cfquery>
