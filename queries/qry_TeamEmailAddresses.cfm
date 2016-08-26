<!--- called by LUList.cfm for Team output --->
<cfquery name="QTeamEmailAddresses" datasource="#request.DSN#">
	SELECT DISTINCT
		Contact1Email1 AS emailaddr,
		t.longcol as TName
	FROM
		teamdetails td,
		team t
	WHERE 
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND length(trim(Contact1Email1)) <> '' 
		AND td.TeamID = t.ID
	UNION
	SELECT DISTINCT
		Contact1Email2 AS emailaddr,
		t.longcol as TName
	FROM
		teamdetails td,
		team t
	WHERE 
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND length(trim(Contact1Email2)) <> ''  
		AND td.TeamID = t.ID
	UNION
	SELECT DISTINCT
		Contact2Email1 AS emailaddr,
		t.longcol as TName
	FROM
		teamdetails td,
		team t
	WHERE 
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND length(trim(Contact2Email1)) <> ''  
		AND td.TeamID = t.ID
	UNION
	SELECT DISTINCT
		Contact2Email2 AS emailaddr,
		t.longcol as TName
	FROM
		teamdetails td,
		team t
	WHERE 
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND length(trim(Contact2Email2)) <> ''  
		AND td.TeamID = t.ID
	UNION
	SELECT DISTINCT
		Contact3Email1 AS emailaddr,
		t.longcol as TName
	FROM
		teamdetails td,
		team t
	WHERE 
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND length(trim(Contact3Email1)) <> ''  
		AND td.TeamID = t.ID
	UNION
	SELECT DISTINCT
		Contact3Email2 AS emailaddr,
		t.longcol as TName
	FROM
		teamdetails td,
		team t
	WHERE 
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND length(trim(Contact3Email2)) <> '' 
		AND td.TeamID = t.ID 
	ORDER BY
		emailaddr
</cfquery>
