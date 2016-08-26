<!--- called from SearchClubForm.cfm --->
<!--- this will create (eventually) codes like MDX1999, MDX2004 etc. --->
<CFQUERY NAME="QLeagueCodes" datasource="ZMAST">
	SELECT 
		DefaultLeagueCode as DLC,
		LeagueName as LN,
		SeasonName as SN
	FROM
		leagueinfo
	ORDER BY
		LeagueName, SeasonName DESC
</CFQUERY>
