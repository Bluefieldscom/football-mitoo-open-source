<cfquery name="FindFixture02" datasource="#request.DSN#" >
	SELECT
		f.ID as FID
	FROM
		fixture f,
		constitution c
	WHERE 
		f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND	f.FixtureDate = '#BookingDate#'
		AND f.PitchAvailableID = 0
		AND	c.TeamID = <cfqueryparam value = #TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c.OrdinalID = <cfqueryparam value = #OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND f.HomeID = c.ID
</cfquery>
