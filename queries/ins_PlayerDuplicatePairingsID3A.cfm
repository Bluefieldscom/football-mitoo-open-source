<!--- called by LUList.cfm --->
<cfquery name="InsertID3" datasource="#request.DSN#" >
	INSERT INTO
		playerduplicatepairings  (PID, LeagueCode)
		(SELECT
		ID,
		LeagueCode
	FROM
		player
	WHERE
		LeagueCode = '#request.filter#'
	AND Surname = '#QSamePlayer3.Surname#'
	AND Forename = '#QSamePlayer3.Forename#'
	AND MediumCol IS NULL )	
</cfquery>
