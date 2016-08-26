<!--- called by TeamList.cfm --->
<cfquery name="QGetCountAppearances" datasource="#request.DSN#">
	SELECT
		COUNT(a.id) as AppearedCount
	FROM
		appearance a,
		fixture f,
		player p
	WHERE 
		f.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND f.FixtureDate='#DateFormat(QFixtureDate.FixtureDate,"YYYY-MM-DD")#'
		AND p.shortcol > 0
		AND p.id = #ThisPlayerID#
		AND a.fixtureid=f.id 
		AND a.playerid=p.id 
</cfquery>
