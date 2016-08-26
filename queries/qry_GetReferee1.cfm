<!--- called by MtchDayOfficials.cfm --->

<cfquery name="GetReferee1" datasource="#request.DSN#">
	SELECT
		ID as RID,
	CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN LongCol
		WHEN LENGTH(TRIM(Forename)) = 0
		THEN Surname
		ELSE CONCAT(Surname, ", ", Forename )
		END
		as RefsFullName,
		(SELECT Available FROM refavailable ra WHERE ra.MatchDate = '#ThisDate#' AND ra.RefereeID = RID) as Available
	FROM
		referee 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	ORDER BY
		ShortCol, LongCol, Surname, Forename
</cfquery>
