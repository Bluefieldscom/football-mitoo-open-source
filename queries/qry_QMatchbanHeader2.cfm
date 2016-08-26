<!--- called by SuspendPlayer.cfm --->
<cfquery name="QMatchbanHeader2" datasource="#request.DSN#" > <!--- get the HeaderID --->
	SELECT ID FROM matchbanheader
	WHERE
		LeagueCode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND SuspensionID = #ThisSuspensionID#
</cfquery>
