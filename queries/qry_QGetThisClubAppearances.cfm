<!--- called by inclGetSame.cfm --->
<cfquery name="QGetThisClubAppearances" datasource="#request.DSN#">
SELECT
		SUM(IF(a.Activity=1,1,0)) as TimesAppeared1,
		SUM(IF(a.Activity=2,1,0)) as TimesAppeared2,
		SUM(IF(a.Activity=3,1,0)) as TimesAppeared3,		
		a.FixtureID,
		a.HomeAway,
		t.id,
		d.LongCol as CompetitionName,
		d.ShortCol as CompName,
		CASE
		WHEN LEFT(d.notes,2) = 'KO'
		THEN 'Yes'
		ELSE 'No'
		END
		as KnockOutCompetition
	FROM
		appearance a,
		fixture f,
		constitution c,
		division d ,
		team t
	WHERE 
		a.playerid = #ThisPlayerID#
		AND f.fixturedate <= '#DateFormat(QTeamName.FixtureDate,"YYYY-MM-DD")#'
		AND t.id = #CurrentTeamID#
		AND c.TeamID = t.ID
		AND a.FixtureID = f.id
		AND ((a.HomeAway = 'H' AND c.ID = f.HomeID) 
		OR  (a.HomeAway = 'A' AND c.ID = f.AwayID)) 
		AND d.id = c.DivisionID
GROUP BY 
	d.LongCol
ORDER BY
	d.MediumCol
	
</cfquery>
