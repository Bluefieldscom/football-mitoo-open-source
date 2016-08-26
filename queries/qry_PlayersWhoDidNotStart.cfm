<!--- called from StartingLineUpList.cfm --->
<cfquery NAME="QPlayersWhoDidNotStart" datasource="#request.DSN#">
SELECT
	p.Surname as PlayerSurname,
	p.Forename as PlayerForename,
	p.MediumCol as PlayerDOB ,	
	p.ShortCol as PlayerRegNo ,
	p.ID as PlayerID ,
	CASE
		WHEN a.Activity = 1 THEN 'Started'
		WHEN a.Activity = 2 THEN 'SubUsed'
		WHEN a.Activity = 3 THEN 'SubNotUsed'
		ELSE 'ERROR'
	END
	as AppearanceType,
	
	a.ID as AppearanceID,
	a.GoalsScored as GoalsScored ,
	a.Card as Card ,
		<!--- this subselect may return a NULL if there is no register record within the FirstDay/LastDay range --->
		(SELECT RegType FROM register r, fixture f 
		WHERE r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.PlayerID = p.ID
		AND a.FixtureID = f.ID
		AND f.fixturedate
		BETWEEN
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
		) 
		as RegType
FROM
	player AS p, 
	appearance AS a
WHERE
	p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND a.FixtureID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	AND	p.shortcol > 0 <!--- ignore own goal --->
	AND a.HomeAway = '#HA#' 
	AND
	<cfif QPlayersWhoStarted.RecordCount GT 0>
		p.ID NOT IN (#PlayerIDList#) AND
	</cfif>
	a.PlayerID = p.ID
	
ORDER BY
	Activity, PlayerSurname, PlayerForename
</cfquery>

