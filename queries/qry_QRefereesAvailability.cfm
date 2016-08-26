<!--- Called by RefereesAvailability.cfm --->

<cfquery name="QRefereesAvailability" datasource="#request.DSN#" >
SELECT
	CASE
	WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
	THEN r.LongCol
	ELSE CONCAT(r.Forename, " ", r.Surname)
	END
	as RefsName ,
	ra.Available,
	ra.MatchDate,
	ra.Notes
FROM
	referee AS r,
	refavailable as ra
WHERE
	ra.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND ra.MatchDate >= CURRENT_DATE() 
	AND ra.refereeID = r.ID
ORDER BY
	ra.MatchDate, r.ShortCol, r.LongCol
</cfquery>

