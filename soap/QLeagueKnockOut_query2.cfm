<!--- called by QLeagueFixtures_query2 --->

<CFQUERY NAME="QLeagueKnockOut" datasource="#variables.dsn#" >
	SELECT
		lkd.ID, d.Notes
	FROM
		division d
		JOIN zmast.lk_division lkd ON d.id = lkd.#idcolumn#
	WHERE d.leaguecode = '#arguments.league_code#'
	<cfif ListLen(#arguments.division_id_list#) GT 0>
		AND
		lkd.ID IN (<cfqueryparam value = #arguments.division_id_list# 
						cfsqltype="CF_SQL_VARCHAR" list="yes">)				
	</cfif>
</CFQUERY>

