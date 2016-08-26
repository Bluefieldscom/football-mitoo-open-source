<!--- called by ShowNews.cfm --->
<!--- List of ALL the NewsItems, including the private "hidden" ones --->
<!--- in ascending sequence of importance --->
<CFQUERY NAME="QNews" datasource="#request.DSN#">
	SELECT
		longcol,
		cast(mediumcol as decimal) as mediumcol,
		shortcol,
		notes
	FROM
		newsitem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		mediumcol
</CFQUERY>
