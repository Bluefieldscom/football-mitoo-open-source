<!--- Called by LUList.cfm --->

<CFQUERY NAME="KORoundList" datasource="#request.DSN#">
	SELECT 
		ID,
		LongCol,
		MediumCol,
		ShortCol,
		Notes
	FROM
		koround as KORound
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol IS NOT NULL
	ORDER BY
		 MediumCol
</CFQUERY>
