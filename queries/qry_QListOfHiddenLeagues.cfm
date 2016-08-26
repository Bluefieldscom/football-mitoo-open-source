<!--- called by ListOfHiddenLeagues.cfm --->

<cfquery name="QListOfHiddenLeagues" datasource="ZMAST">	
	SELECT 
		CountiesList,
		DefaultLeagueCode,
		DefaultYouthLeague,
		SeasonName,		
		LeagueName,
 		NameSort,
 		LeagueBrand,
		HideThisSeason,
		LeagueCodePrefix
	FROM
		leagueinfo
	WHERE
		LeagueCodeYear=2013
	ORDER BY
		NameSort
</cfquery>
<cfquery name="QListOfPreviousLeagues" datasource="ZMAST">	
	SELECT 
		CountiesList,
		DefaultLeagueCode,
		DefaultYouthLeague,
		SeasonName,		
		LeagueName,
 		NameSort,
 		LeagueBrand,
		HideThisSeason,
		LeagueCodePrefix
	FROM
		leagueinfo
	WHERE
		LeagueCodeYear=2012 
		AND LeagueCodePrefix NOT IN(SELECT LeagueCodePrefix	FROM leagueinfo	WHERE LeagueCodeYear=2013)
	ORDER BY
		LeagueCodePrefix
</cfquery>
