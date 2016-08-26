<!--- called from getAnnouncementNotes method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QAnnouncement_query" datasource="#variables.dsn#">
	SELECT
		Notes
	FROM
		newsitem
	WHERE
		LeagueCode = '#arguments.leaguecode#' 
		AND LongCol='Notice' AND MediumCol='' AND ShortCol=''
	LIMIT 1
</cfquery>

<cfset Notes = #QAnnouncement_query.Notes#>