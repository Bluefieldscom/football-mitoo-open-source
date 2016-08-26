
<!--- e.g. XMLCompetition.cfm?LeagueCode=MDX2007 --->

<cfif NOT StructKeyExists(url, "LeagueCode") >
	LeagueCode parameter missing
	<cfabort>
</cfif>
<cfsilent>
<cfset datasourcename = "fm#right(URL.LeagueCode,4)#">
<cfset LeagueCodePrefix = "#Left(URL.LeagueCode,(Len(URL.LeagueCode)-4))#">
<cfquery name="QCompetitions" datasource="#datasourcename#">
SELECT 	
	longcol as CompetitionName,
	mediumcol as SortOrder,
	shortcol as CompetitionCode,
	notes,
	CASE
	WHEN Notes LIKE '%External%'
	THEN '1'
	ELSE '0'
	END
	as External
FROM 
	division
WHERE
	LeagueCode = '#LeagueCodePrefix#'
ORDER BY
	mediumcol, longcol
</cfquery>
</cfsilent>

<xml>
<competition>
<cfoutput query="QCompetitions">
<code>#CompetitionCode#</code>
<name>#ReplaceList(CompetitionName, '<BR>,<br>,<br />,<BR />',' , , , ,')#</name>
<cfif Left(Notes,2) IS "KO"><type>Knock Out</type><cfelse><type>Division</type></cfif>
<cfif Left(Notes,2) IS "KO">
<meetings>0</meetings>
<cfelseif Left(Notes,2) IS "P1">
<meetings>1</meetings>
<cfelseif Left(Notes,2) IS "P3">
<meetings>3</meetings>
<cfelseif Left(Notes,2) IS "P4">
<meetings>4</meetings>
<cfelse>
<meetings>2</meetings></cfif>
<external>#external#</external>
</cfoutput>   
</competition >
</xml>
