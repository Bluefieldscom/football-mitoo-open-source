<!--- Called by LUList.cfm --->

<CFQUERY NAME="DivisionList" datasource="#request.DSN#">
	SELECT 
		ID,
		LongCol,
		MediumCol,
		ShortCol,
		Notes
	FROM
		division
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		 MediumCol
</CFQUERY>
