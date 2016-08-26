<!--- called by MtchDay.cfm  --->
<cfquery name="QTeamLongCol" datasource="#request.DSN#">
	SELECT LongCol FROM team WHERE ID = #request.fmTeamID#
</cfquery>
