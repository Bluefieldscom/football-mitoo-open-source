<!--- called by inclGetOther.cfm --->
<cfquery name="QGetOtherTeams" datasource="#request.DSN#">
SELECT
	DISTINCT
		r.teamID,
		t.LongCol
	FROM
		register r,
		team t
	WHERE
		r.playerid=#ThisPlayerID#
		AND r.teamID <> #CurrentTeamID#
		AND r.teamID = t.id
</cfquery>
