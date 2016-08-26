<!--- called by ThisRefsHistory.cfm --->
<cfquery name="ThisRefsHist" datasource="#request.DSN#">
	SELECT TeamID, OrdinalID FROM constitution WHERE id=#ThisID#
</cfquery>
