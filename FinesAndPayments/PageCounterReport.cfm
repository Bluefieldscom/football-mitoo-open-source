
<!--- Get all the League Codes also League Name and Season description ... --->
<CFQUERY NAME="QLeagueCodes" datasource="ZMAST">
	SELECT 
		DefaultLeagueCode as DLC,
		LeagueName as LN
	FROM
		LeagueInfo
	WHERE
		RIGHT(DefaultLeagueCode,2) = '03' AND
		ID NOT IN (SELECT ID FROM LeagueInfo WHERE CountiesList LIKE '%NOT ON SYSTEM%')
</CFQUERY>

<CFQUERY NAME="QLeagueCodes2" dbtype="query">
	SELECT 
		DLC,
		LN
	FROM
		QLeagueCodes
</CFQUERY>

<cfloop query="QLeagueCodes2" startrow="1" endrow="500">
	<cfoutput><font size="+2">#DLC# #LN#</font></cfoutput><BR>
	<cfquery name="Q#DLC#" datasource="#DLC#">
	SELECT 
		[Long] as PositionOnCommittee,
		[Medium] as PersonName,
		Notes
	FROM
		Committee
	ORDER BY
		[Short]
	
	</cfquery>
	<cfoutput query="Q#DLC#">
	#PositionOnCommittee# #PersonName# #Notes#<BR><BR>
	</cfoutput>
</cfloop>
<CFABORT>
