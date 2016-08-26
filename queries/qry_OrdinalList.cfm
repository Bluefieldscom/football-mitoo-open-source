<!--- Called by LUList.cfm --->

<CFQUERY NAME="OrdinalList" datasource="#request.DSN#">
	SELECT 
		ID,
		LongCol,
		MediumCol,
		ShortCol,
		Notes
	FROM
		ordinal as Ordinal
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol IS NOT NULL
	ORDER BY
		 LongCol
</CFQUERY>
