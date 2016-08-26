<!--- called by Counties.cfm --->

<cfquery name="QGetLeagues" datasource="ZMAST" cachedWithin=#CreateTimeSpan(0,1,0,0)#>	
	SELECT
		NameSort,LeagueName,NameSort,
		DefaultLeagueCode,BadgeJpeg,SeasonName,
		LeagueBrand
	FROM
		leagueinfo
	WHERE
		CountiesList LIKE '%#County#%'
	ORDER BY
		NameSort, SeasonName DESC
</cfquery>
