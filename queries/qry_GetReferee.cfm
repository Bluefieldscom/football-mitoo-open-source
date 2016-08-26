<!--- called by InclSchedule01.cfm --->
<cfquery name="GetReferee" datasource="#request.DSN#">
	SELECT
		r.ID ,
	CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Surname, ", ", r.Forename )
		END
		as LongCol,
		(SELECT Available FROM refavailable ra WHERE ra.MatchDate = f.FixtureDate AND ra.RefereeID = r.ID) as Available
	FROM
		referee r, fixture f
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND f.ID = #FID#
	ORDER BY
		r.ShortCol, r.LongCol, r.Surname, r.Forename
</cfquery>
