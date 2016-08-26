<!--- Called by RefereesAvailability2.cfm --->

<cfquery name="QRefereesAvailability2" datasource="#request.DSN#" >
SELECT
	CASE
	WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
	THEN r.LongCol
	ELSE CONCAT(r.Forename, " ", r.Surname)
	END
	as RefsName ,
	ra.Available,
	ra.MatchDate,
	DATE_FORMAT(ra.MatchDate, '%Y') as MatchYear,
	DATE_FORMAT(ra.MatchDate, '%M') as MatchMonth,
	ra.Notes
FROM
	referee AS r,
	refavailable as ra
WHERE
	ra.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND (ra.Available = 'Yes' OR ra.Available = 'No')
	AND ra.refereeID = r.ID
ORDER BY
	 r.ShortCol, r.LongCol, ra.MatchDate
</cfquery>

