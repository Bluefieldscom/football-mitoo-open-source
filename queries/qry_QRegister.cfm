<!--- called by CheckRule12SineDie.cfm --->
<cfquery Name="QRegister"  datasource="#request.DSN#" >
	SELECT
		r.TeamID,
		r.PlayerID,
		r.FirstDay,
		r.LastDay,
		IF(r.LastDay IS NULL,'Yes','No') as currentlyregistered,
		r.RegType,
		t.LongCol as TeamName
	FROM
		register r,
		team t
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.PlayerID = #QSurnamesDobs.ID#
		AND r.TeamID = t.ID
</cfquery>
