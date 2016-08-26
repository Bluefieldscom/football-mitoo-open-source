<!---  called by InclCreateNewLeagueTableRows.cfm  --->
<cfquery name="DeleteLeagueTable" datasource="#request.DSN#">
	DELETE FROM
		leaguetable 
	WHERE
		DivisionID = #ThisDivisionID#
</cfquery>
