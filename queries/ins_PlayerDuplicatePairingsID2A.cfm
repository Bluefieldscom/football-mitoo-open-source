<!--- called by LUList.cfm --->
<cfquery name="InsertID2A" datasource="#request.DSN#" >
	INSERT INTO
		playerduplicatepairings  (PID, LeagueCode)
		(SELECT
		ID,
		LeagueCode
	FROM
		player
	WHERE
		LeagueCode = '#request.filter#'
	AND Forename = '#QSamePlayer2A.Forename#'
	AND MediumCol = '#DateFormat(QSamePlayer2A.mediumcol, "YYYY-MM-DD")#' )	
</cfquery>
