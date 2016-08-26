<!--- called by ListOfLeagues.cfm --->

<cfquery name="QListOfLeagues" datasource="ZMAST">	
	SELECT 		
		li.CountiesList,
		li.DefaultLeagueCode,
		li.DefaultYouthLeague,
		li.SeasonName,		
		li.LeagueName,
 		li.NameSort,
 		li.LeagueBrand,
		CASE
		WHEN m.MitooDotComID IS NULL
		THEN 0
		ELSE m.MitooDotComID
		END
		as MitooDotComID,
		CASE
		WHEN m.DefaultDID IS NULL
		THEN 0
		ELSE m.DefaultDID
		END
		as DefaultDID
	FROM
		leagueinfo li LEFT JOIN migration2 m ON ( m.LeagueCodePrefix = li.LeagueCodePrefix)
	WHERE
		RIGHT(DefaultLeagueCode,4) = #Year1#
		AND LEFT(CountiesList,4) <> 'TEST'
		AND LENGTH(LeagueName) > 8
		AND HideThisSeason = 0
	ORDER BY
		NameSort,DefaultLeagueCode
</cfquery>
