<!--- called by SuspendPlayer.cfm --->
<cftry>

<cfquery name="UpdSuspension" datasource="#request.DSN#" >
	UPDATE
		suspension
	SET
		FirstDay = '#url.SDate#',
		LastDay = '2999-12-31',
		NumberOfMatches = 1 
	WHERE
		ID = <cfqueryparam value = #QGetNewSuspension.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND LeagueCode=	<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>

	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="suspension"><cfabort>
	</cfcatch>


</cftry>