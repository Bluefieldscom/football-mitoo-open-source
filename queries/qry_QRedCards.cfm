<!--- called by RedCardSuspensND.cfm --->

		<cfquery name="QRedCards" datasource="#request.DSN#" >
			SELECT
				p.ID as PID,
				CONCAT(p.Surname, " ", p.Forename) as PlayerName,
				p.Surname as PlayerSurname,
				p.Forename as PlayerForename,
				p.shortCol as PlayerNo,
				t.longCol as TeamName,
				a.FixtureID,
				a.HomeAway,
				f.FixtureDate,
				f.ID as FID
			FROM
				player AS p,
				appearance AS a,
				fixture AS f,
				constitution AS  c,
				team AS t
			WHERE
				 a.card > 2 AND p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND p.ID = #ListElement#
				AND ((a.HomeAway = 'H' AND f.HomeID = c.ID) OR (a.HomeAway = 'A' AND f.AwayID = c.ID))
				AND a.PlayerID = p.ID 
				AND f.ID = a.FixtureID 
				AND c.TeamID = t.ID
			ORDER BY
				FixtureDate
		</cfquery>
