<!--- called by DateRange.cfm --->
<cfquery Name="RegisteredPlayersByDate" datasource="#request.DSN#">
	SELECT
		t.LongCol as ClubName,
		p.Surname as Surname,
		p.Forename as Forename,
		p.ShortCol as RegNo,
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			AddressLine1,
			AddressLine2,
			AddressLine3,
			Postcode,
		</cfif>
		p.Notes as PNotes,
		p.MediumCol as DOB,
		FirstDay,
		LastDay,
		RegType
	FROM
		register r,
		team t,
		player p
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND r.FirstDay IS NOT NULL
		AND	(r.FirstDay BETWEEN '#request.Date001#' AND '#request.Date002#')
		AND r.TeamID = t.ID
		AND r.PlayerID = p.ID
	ORDER BY r.FirstDay, ClubName, Surname, Forename
</cfquery>
