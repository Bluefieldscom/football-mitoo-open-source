<!--- Called by LUList.cfm --->

<CFQUERY NAME="NewsItemList" datasource="#request.DSN#">
	SELECT 
		ID,
		LongCol,
		cast(MediumCol as decimal) as MediumCol,
		ShortCol,
		Notes
	FROM
		newsitem as NewsItem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol IS NOT NULL
	ORDER BY
		 MediumCol, Longcol
</CFQUERY>
