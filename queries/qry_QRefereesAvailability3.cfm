<!--- Called by InclLookUp.cfm.cfm --->

<cfquery name="QRefereesAvailability3" datasource="#request.DSN#" >
SELECT
	ra.Available,
	ra.MatchDate,
	DATE_FORMAT(ra.MatchDate, '%Y') as MatchYear,
	DATE_FORMAT(ra.MatchDate, '%c') as MatchMonth
FROM
	referee AS r,
	refavailable as ra
WHERE
	ra.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	AND r.ID = #ID#
	AND ra.refereeID = r.ID
ORDER BY
	 ra.MatchDate
</cfquery>

