<!--- called by LUList.cfm --->
<cfquery name="InsertID2B" datasource="#request.DSN#" >
	INSERT INTO
		playerduplicatepairings  (PID, LeagueCode)
		(SELECT
		ID,
		LeagueCode
	FROM
		player
	WHERE
		LeagueCode = '#request.filter#'
	AND Surname = '#QSamePlayer2B.Surname#'
	AND MediumCol = '#DateFormat(QSamePlayer2B.mediumcol, "YYYY-MM-DD")#' )	
</cfquery>
