<!--- called by MtchDay.cfm --->

<cfquery name="RefereesNotAppointed" datasource="#request.DSN#">
	SELECT CASE WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0 THEN LongCol ELSE CONCAT(Forename, " ", Surname) END as RefsName, shortcol as rsort from referee where leaguecode = '#request.filter#' AND ID NOT IN (#AppointedRIDList#) and LongCol IS NOT NULL and ShortCol IS NOT NULL ORDER BY rsort
</cfquery>
