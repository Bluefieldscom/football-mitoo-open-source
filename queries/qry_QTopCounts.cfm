<!--- called as a block from TopCounts.cfm  --->

<cfquery name="QLeagues" datasource="ZMAST">	
	SELECT
		NameSort,
		DefaultLeagueCode,
		SeasonName
	FROM
		leagueinfo
	WHERE
		LeagueCodeYear = '#url.Year#'
</cfquery>


<cfquery name="QReadCounter" datasource="FMPageCount" >
	SELECT
		CounterLeagueCode,
		CounterValue ,
		CounterStartDateTime
	FROM
		pagecounter
	WHERE
		RIGHT(CounterLeagueCode,4) = '#url.Year#'
	ORDER BY 
		CounterValue DESC 
	LIMIT 50
</cfquery>


<cfquery name="QCounter" dbtype="query"  >
	SELECT
		CounterLeagueCode,
		CounterValue ,
		CounterStartDateTime,
		NameSort,
		SeasonName
	FROM
		qleagues,
		qreadcounter
	WHERE
		CounterLeagueCode=DefaultLeagueCode
	ORDER BY
		CounterValue DESC
</cfquery>
