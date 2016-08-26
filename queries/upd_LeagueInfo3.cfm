<!--- called by RefreshleagueTable.cfm --->

<cfquery name="QUpdate" datasource="ZMAST" >
	UPDATE
		leagueinfo
	SET
		MatchBanReminder = #MBRValue#
	WHERE
		ID = <cfqueryparam value = #request.LeagueID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
