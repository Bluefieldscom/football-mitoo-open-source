<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QPlayerSuspensionUpdate" datasource="#variables.dsn#" result="QPlayerSuspensionUpdate_result">
	UPDATE 
		suspension 
	SET
		firstDay = '#arguments.firstDay#',
		lastDay  = '#arguments.lastDay#',
		numberOfMatches = #arguments.numberOfMatches#
	WHERE
		id = #arguments.SID# 
		AND leaguecode = '#arguments.leagueCode#'
		AND playerID = #arguments.player_id#
</cfquery>
