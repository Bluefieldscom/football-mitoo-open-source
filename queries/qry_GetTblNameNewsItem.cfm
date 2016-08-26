<!--- called by qry_GetTblName.cfm --->

<CFQUERY NAME="GetTblName" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol,
		MediumCol,
		ShortCol,
		Notes
	FROM
		newsitem as NewsItem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #URL.ID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
