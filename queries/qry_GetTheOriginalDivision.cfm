<!--- called from RestorBackFromMisc.cfm --->

<CFQUERY NAME="GetTheOriginalDivision" datasource="#request.DSN#">
	SELECT
		ID, longcol, mediumcol, shortcol, notes, LeagueCode
	FROM
		division
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol IS NOT NULL 
		AND NOT LongCol = 'Miscellaneous'
		AND ID NOT IN
			(SELECT ID FROM division WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND LEFT(Notes,2) = 'KO')
	ORDER BY MediumCol
</CFQUERY>
