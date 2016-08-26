<!--- called by QLeagueTable_query2 & QFixtures_query2  and QLeaguePosition_query2 --->

<CFQUERY NAME="QKnockOut" datasource="#variables.dsn#" >
	SELECT
		d.Notes,
		d.LongCol AS CompetitionDescription
	FROM
		division d
		JOIN zmast.lk_division lkd ON d.id = lkd.#idcolumn#
	WHERE
		lkd.ID = <cfqueryparam value = #arguments.division_id# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
