<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QPlayerSuspensionAdd" datasource="#variables.dsn#" result="QPlayerSuspensionAdd_result">
	INSERT INTO 
		suspension 
		(playerID, firstDay, lastDay, numberOfMatches, leagueCode)
	VALUES
		(#arguments.player_id#, '#arguments.firstDay#', '#arguments.lastDay#',
		 #arguments.numberOfMatches#, '#arguments.leagueCode#')
</cfquery>
