<!--- Called by LUList.cfm --->

<!--- check for duplicate player names --->

<cfquery name="QSameSurnameDOB" datasource="#request.DSN#" >
	SELECT
		surname,
		forename,
		MediumCol
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ShortCol <> 0
		AND MediumCol IS NOT NULL
		AND ID NOT IN (SELECT ID FROM player WHERE LeagueCode = LeagueCode AND NOTES LIKE '%p=p%')
	GROUP BY
		surname, MediumCol 
	HAVING
		COUNT(*) >= 2 
</cfquery>
