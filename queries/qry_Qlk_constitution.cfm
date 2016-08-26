<!--- called by News.cfm  - get rid of any GUEST teams, 'League' or 'Withdrawn' teams from lk_constitution  
<cfquery name="Qlk_constitution" datasource="#request.DSN#" >
	SELECT 
		z.id ,
		IF(t.shortcol ='GUEST', concat(t.longcol,' (GUEST)'), t.longcol) as TeamName,
		d.longcol as divisionname,
		d.leaguecode as leaguecode
	FROM
		zmast.lk_constitution z,
		fm#leaguecodeyear#.constitution c, 
		fm#leaguecodeyear#.team t,
		fm#leaguecodeyear#.division d
	WHERE
		(d.longcol LIKE '%friendl%' OR t.longcol LIKE '%withdrawn%' OR t.longcol LIKE '%league%' OR t.shortcol ='GUEST')
		AND z.#leaguecodeyear#id = c.id
		AND c.teamid = t.id
		AND c.divisionid = d.id
	ORDER BY 
		leaguecode, divisionname, TeamName
	LIMIT 200		
</cfquery>
--->
