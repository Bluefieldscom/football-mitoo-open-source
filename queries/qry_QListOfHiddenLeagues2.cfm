<!--- called by ListOfHiddenLeague.cfm --->

<cfquery name="QListOfHiddenLeagues2" datasource="ZMAST">	
	SELECT 
		NameSort as FullLeagueName
	FROM
		leagueinfo
	WHERE
		DefaultLeagueCode = '#AltPrefix##Year0#'
</cfquery>
