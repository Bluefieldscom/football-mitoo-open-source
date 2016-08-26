<!--- called by ShowNews.cfm, InclNewsTopSection --->
<!--- List of NewsItems but NOT the private "hidden" ones --->
<!--- in ascending sequence of importance --->
<CFQUERY NAME="QNews" datasource="#request.DSN#">
	SELECT
		longcol,
		cast(mediumcol as decimal) as mediumcol,
		notes
	FROM
		newsitem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND 
			(ShortCol IS NULL 
			OR 
			NOT (ShortCol = 'HIDE'))
	ORDER BY
		mediumcol
</CFQUERY>		
