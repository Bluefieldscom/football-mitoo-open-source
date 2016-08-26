<!--- called by News.cfm --->
<cfquery name="QSuspectGuestTeams" datasource="#request.DSN#">
	SELECT LongCol FROM team WHERE 
	id NOT IN (SELECT id FROM team WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND notes LIKE '%noscore%') AND
	id NOT IN (SELECT id FROM team WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND shortcol='guest') AND
	id IN
	(SELECT teamid FROM constitution WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND divisionid IN (
	SELECT id FROM division WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND Left(notes,2)='KO')) AND id NOT IN
	(SELECT teamid FROM constitution WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND divisionid NOT IN (
	SELECT id FROM division WHERE leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">  AND Left(notes,2)='KO'))
	ORDER BY LongCol
</cfquery>

