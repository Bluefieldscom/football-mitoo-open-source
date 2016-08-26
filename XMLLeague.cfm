<!--- e.g. XMLLeague.cfm?County=Herts --->
<cfif NOT StructKeyExists(url, "County") >
	County parameter missing
	<cfabort>
</cfif>
<cfsilent>
<cfquery name="QListOfLeagues" datasource="ZMAST">	
	SELECT 
		CountiesList,
		DefaultLeagueCode,
		DefaultYouthLeague,
		SeasonName,
		LeagueCodeYear,		
		LeagueName,
 		NameSort,
 		LeagueBrand
	FROM
		leagueinfo
	WHERE
		CountiesList LIKE '%#County#%'
		AND LEFT(CountiesList,4) <> 'TEST'
		AND LENGTH(LeagueName) > 8
	ORDER BY
		NameSort, SeasonName DESC
</cfquery>
</cfsilent>
<xml>
<cfoutput query="QListOfLeagues" group="NameSort">
	<league name="#ReplaceList(NameSort, '<BR>,<br>,<br />,<BR />',' , , , ,')#">
		<cfoutput>
		<season name=#SeasonName#>
			<SeasonYear>#LeagueCodeYear#</SeasonYear>
			<LeagueCode>#DefaultLeagueCode#</LeagueCode>
			<LeagueBrand>#LeagueBrand#</LeagueBrand>
			<YouthLeague>#DefaultYouthLeague#</YouthLeague>
		</season>
		 </cfoutput>
	</league>
</cfoutput>                           
</xml>