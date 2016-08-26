<!--- called from ToolBar1.cfm --->
<cfparam name="LeagueCode" default="MDX2004">

<cfquery name="QNameSort" datasource="ZMAST">
		SELECT
			SeasonName,
			DefaultLeagueCode
		FROM
			leagueinfo
		WHERE
			NameSort = (SELECT NameSort FROM leagueinfo WHERE DefaultLeagueCode = '#LeagueCode#')
			<!--- AND NOT (DefaultLeagueCode = '#LeagueCode#') --->
		ORDER BY
			SeasonName Desc
</cfquery>
<!--- <cfdump var="#QNameSort#"> --->