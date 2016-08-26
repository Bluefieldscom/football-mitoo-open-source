<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QPlayerSuspensionDelete" datasource="#variables.dsn#" result="QPlayerSuspensionDelete_result">
	DELETE FROM 
		suspension 
	WHERE
		id = #arguments.SID# 
		AND leaguecode = '#arguments.leagueCode#'
</cfquery>
