<!--- Called by LUList.cfm --->

<!--- Find the Player record that corresponds to "Own Goal" it should have Player Number zero --->

<cfquery name="QRegNos0" datasource="#request.DSN#" >
	SELECT
		shortCol as RegNo
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND shortCol = 0
</cfquery>
