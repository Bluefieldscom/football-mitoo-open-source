<!--- called by InclTblChooseTeam.cfm --->

<CFQUERY NAME="GetVenue" datasource="#request.DSN#">
	SELECT	
		ID,
		LongCol as VenueName
	FROM 	
		venue as Venue
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		VenueName
</CFQUERY>

