<!--- called by inclGetOther.cfm --->
<cfquery name="QGetOtherAppearances" datasource="#request.DSN#">
SELECT
		COUNT(d.id) as TimesAppeared,
		SUM(IF(a.Activity=1,1,0)) as TimesAppeared1,
		SUM(IF(a.Activity=2,1,0)) as TimesAppeared2,
		SUM(IF(a.Activity=3,1,0)) as TimesAppeared3,		
		a.FixtureID,
		a.HomeAway,
		t.longcol as ClubName,
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
		team t,
		division d
	WHERE
		a.PlayerID=#ThisPlayerID#
		AND t.ID = #SpecifiedTeamID#
		AND f.fixturedate <= '#DateFormat(QTeamName.FixtureDate,"YYYY-MM-DD")#'
		AND a.FixtureID = f.ID
		AND ((a.HomeAway = 'H' AND c.ID = f.HomeID) 
		OR  (a.HomeAway = 'A' AND c.ID = f.AwayID)) 
		AND c.TeamID = t.ID
		AND c.DivisionID = d.ID
	GROUP BY
		d.ID
		ORDER BY 
		d.MediumCol
				
</cfquery>
