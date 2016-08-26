<!--- called by InclConstit02.cfm, InclPitchAvailable01.cfm --->

<CFQUERY NAME="GetOrdinalInfo" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol
	FROM
		ordinal as Ordinal
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		LongCol
</CFQUERY>

