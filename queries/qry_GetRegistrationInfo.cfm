<!--- called from LUList.cfm --->

<cfquery name="GetRegistrationInfo" datasource="#request.DSN#">
	SELECT
		r.ID as RID,
		r.TeamID as TeamID,
		r.PlayerID as PlayerID,
		CASE
			WHEN r.FirstDay IS NULL
			THEN '1900-01-01'
			ELSE r.FirstDay
			END
		AS FirstDay,
		CASE
			WHEN r.LastDay IS NULL
			THEN '2999-12-31'
			ELSE r.LastDay
			END
		AS LastDay,
		t.longcol as ClubName,
		t.ID as TID
	FROM
		register r, 
		player p,
		team t
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID = <cfqueryparam value = #ThisPID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND p.ID = r.PlayerID
		AND t.ID = r.TeamID
	ORDER BY
		FirstDay
		<!---
	AND CURDATE() BETWEEN 
			CASE
			WHEN r.FirstDay IS NULL
			THEN '1900-01-01'
			ELSE r.FirstDay
			END
		AND 
			CASE
			WHEN r.LastDay IS NULL
			THEN '2999-12-31'
			ELSE r.LastDay
			END
			--->
</cfquery>

 
<cfquery name="GetAppearanceInfo" datasource="#request.DSN#">
		SELECT
			COUNT(*) as NumberOfAppearances
		FROM
			appearance
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND PlayerID = <cfqueryparam value = #ThisPID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
