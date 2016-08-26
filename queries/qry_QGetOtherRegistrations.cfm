<!--- called by RegisterPlayer.cfm --->

<cfquery name="QGetOtherRegistrations" datasource="#request.DSN#" >
	SELECT 
		t.LongCol as ClubName,
		r.ID as RegisterID,
		r.TeamID,
		CASE
			WHEN FirstDay IS NULL
			THEN '1900-01-01'
			ELSE FirstDay 
		END  as Day1,
		CASE
			WHEN LastDay IS NULL
			THEN '2999-12-31'
			ELSE LastDay 
		END as Day2
	FROM 
		register r,
		player p,
		team t
	WHERE 
		p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ShortCol = #Form.RegNo#
		AND r.TeamID IS NOT NULL
		AND r.ID <> #Form.RID#
		AND p.ID = r.PlayerID
		AND t.ID = r.TeamID
	ORDER BY
		FirstDay
</cfquery>
