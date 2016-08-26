<!--- called by AdministrationReportsMenu.cfm --->
<cfset TheInterval = "400 DAY">
<cfquery name="QAllUpdateLog" datasource="#request.DSN#">	
	SELECT 
		1 as SortOrder,
		TableName, 
		TStamp,
		Date(TStamp) as Changedate,
		ID, 
		FieldName, 
		BeforeValue, 
		AfterValue, 
		LeagueCode,
		SecurityLevel,
		(SELECT LongCol FROM team t, teamdetails td WHERE t.ID = td.TeamID AND td.ID = updatelog.ID) as TeamName,
		(SELECT LongCol FROM ordinal o, teamdetails td WHERE o.ID = td.OrdinalID AND td.ID = updatelog.ID) as OrdinalName,
		(SELECT CONCAT(TeamName," ",IFNULL(OrdinalName,"")))  as TheLongCol
	FROM 
		updatelog 
	WHERE
		TableName = 'teamdetails'
		AND LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TStamp BETWEEN DATE_SUB(NOW(), INTERVAL #TheInterval#) AND NOW()
UNION ALL
	SELECT 
		2 as SortOrder,
		TableName, 
		TStamp,
		Date(TStamp) as Changedate,
		ID, 
		FieldName, 
		BeforeValue, 
		AfterValue, 
		LeagueCode,
		SecurityLevel,
		(SELECT " ") as TeamName,
		(SELECT " ") as OrdinalName,
		(SELECT LongCol FROM referee r WHERE r.ID = updatelog.ID) as TheLongCol
	FROM 
		updatelog 
	WHERE
		TableName = 'referee'
		AND LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TStamp BETWEEN DATE_SUB(NOW(), INTERVAL #TheInterval#) AND NOW()
UNION ALL
	SELECT 
		3 as SortOrder,
		TableName, 
		TStamp,
		Date(TStamp) as Changedate,
		ID, 
		FieldName, 
		BeforeValue, 
		AfterValue, 
		LeagueCode,
		SecurityLevel,
		(SELECT " ") as TeamName,
		(SELECT " ") as OrdinalName,
		(SELECT ID FROM refavailable ra WHERE ra.ID = updatelog.ID) as TheLongCol
	FROM 
		updatelog 
	WHERE
		TableName = 'refavailable'
		AND LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TStamp BETWEEN DATE_SUB(NOW(), INTERVAL #TheInterval#) AND NOW()
	ORDER BY
		SecurityLevel, SortOrder, TStamp, TheLongCol, FieldName DESC
</cfquery>

