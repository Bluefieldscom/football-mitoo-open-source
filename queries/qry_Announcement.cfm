<!--- called by Announcement.cfm --->
<cfquery name="QAnnouncement" datasource="#request.DSN#">
	SELECT
		ID as NID,
		Notes,
		mediumcol,
		shortcol
	FROM
		newsitem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol = 'NOTICE' 
</cfquery>

