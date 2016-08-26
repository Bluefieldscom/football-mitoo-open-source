<!--- called by InclBatchTempRegNonContract.cfm --->
<cfquery name="QRegisterF" datasource="#request.DSN#" >
	SELECT
		r.id,
		t.longcol as TeamName
	FROM
		register r,
		team t
	WHERE
		r.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.playerid=#QTempPlayerRegNo.id#
		AND r.RegType='F'
		AND r.teamid=t.id
</cfquery>
			
