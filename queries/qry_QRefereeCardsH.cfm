<!--- called by RefsHist.cfm, MatchCard.cfm --->

<cfquery name="QRefereeCardsH" datasource="#request.DSN#">
	SELECT
		a.Card,
		CONCAT(Left(p.Forename,1),'. ',p.Surname) as PlayerName,
		CONCAT(p.Forename,' ',p.Surname) as PlayerFullName,
		a.PlayerID as PID
	FROM
		appearance a,
		player p
	WHERE
		a.FixtureID = #FID#
		AND a.HomeAway = 'H'
		AND a. Card > 0
		AND a.PlayerID = p.ID
	ORDER BY
		p.Surname, p.Forename
</cfquery>
