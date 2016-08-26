<!--- called by RegistListText.cfm --->
<cfquery name="QGetAllTeams" datasource="#request.DSN#">
SELECT
	DISTINCT
		r.teamID,
		t.LongCol
	FROM
		register r,
		team t
	WHERE
		r.playerid=#ThisPlayerID#
		AND r.teamID = t.id
	ORDER BY
		t.LongCol
</cfquery>
