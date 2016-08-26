<!--- Called by LUList.cfm --->

<!--- Get all the Player Registration numbers --->

<cfquery name="QRegNos" datasource="#request.DSN#" >
	SELECT
		shortcol as RegNo
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND shortcol <> 0
	ORDER BY
		RegNo <!--- shortcol --->
</cfquery>
