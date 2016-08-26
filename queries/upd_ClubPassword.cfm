<!--- called by ChangeClubPassword.cfm --->
<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfquery name="upd_Register" datasource="#request.DSN#" >
	UPDATE register SET teamid=#NewTeamID# WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND teamid=#OldTeamID#
</cfquery>

<cfquery name="upd_Constitution" datasource="#request.DSN#" >
	UPDATE constitution SET teamid=#NewTeamID# WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND teamid=#OldTeamID#
</cfquery>

<cfquery name="upd_TeamDetails" datasource="#request.DSN#" >
	UPDATE teamdetails SET teamid=#NewTeamID# WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND teamid=#OldTeamID#
</cfquery>

<cfquery name="upd_TeamFreeDate" datasource="#request.DSN#" >
	UPDATE teamfreedate SET teamid=#NewTeamID# WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND teamid=#OldTeamID#
</cfquery>

<cfquery name="upd_PitchAvailable" datasource="#request.DSN#" >
	UPDATE pitchavailable SET teamid=#NewTeamID# WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND teamid=#OldTeamID#
</cfquery>

<cfquery name="upd_MatchBanHeader" datasource="#request.DSN#" >
	UPDATE matchbanheader SET teamid=#NewTeamID# WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND teamid=#OldTeamID#
</cfquery>

<!--- lk_xxxxx now redundant 
<cfset NewYearString = #url.NewYearString# >
<cfquery name="Q8Old" datasource="zmast" > <!--- old team --->
SELECT id from lk_team WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND #NewYearString#id=#OldTeamID#
</cfquery>
<cfquery name="Q8New" datasource="zmast" > <!--- new team --->
SELECT id from lk_team WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND #NewYearString#id=#NewTeamID#
</cfquery>
<cfquery name="del_lk_team" datasource="zmast" >
	DELETE FROM lk_team WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND id=#Q8New.id#
</cfquery>
<cfquery name="upd_lk_team" datasource="zmast" >
	UPDATE lk_team SET #NewYearString#id=#NewTeamID# WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND id=#Q8Old.id#
</cfquery>
----->
