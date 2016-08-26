<!--- called by SuspendPlayer.cfm --->
<cfquery name="QDelMatchBanHeader" datasource="#request.DSN#" > <!--- constraint says: cascade delete all children in matchban table --->
	DELETE FROM
		matchbanheader
	WHERE
		LeagueCode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND SuspensionID = #ThisSuspensionID#
</cfquery>
