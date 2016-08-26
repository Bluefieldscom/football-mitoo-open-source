<!--- called by inclShowJABOnly.cfm --->
<cfquery name="QBadGuests" datasource="#request.DSN#">
SELECT
	t.longcol as teamname,
	t.id as TID,
	count(t.id)
FROM
	constitution c, 
	team t 
WHERE
	c.leaguecode=  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND c.divisionid IN (SELECT id FROM division WHERE leaguecode='HCH' AND notes  LIKE '%External%')
	AND teamid IN (SELECT id FROM team WHERE leaguecode='HCH' AND shortcol<>'Guest')
	AND teamid NOT IN (SELECT distinct teamid FROM constitution WHERE divisionid IN (SELECT id FROM division WHERE leaguecode='HCH' AND notes NOT LIKE '%External%'))
	AND c.teamid=t.id 
GROUP BY 
	t.id
ORDER BY
	teamname
</cfquery>