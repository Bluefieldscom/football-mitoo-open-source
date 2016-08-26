<!--- called by LogInHistory.cfm --->

<cfquery name="QLogInHistory" datasource="ZMAST" >
	SELECT
		UserName,
		Year(DateTimeStamp)  as YearNo,
		Month(DateTimeStamp) as MonthNo,
		Day(DateTimeStamp)   as DayNo,
		DateTimeStamp
	FROM
		loghistory
	WHERE
		Left(LeagueCode, (Length(TRIM(LeagueCode))-4)) = '#request.filter#' 
		AND Passwd != '*Supervisor*' 
		AND LoggedInOK = '1'
	ORDER BY
		DateTimeStamp DESC
		LIMIT 100
</cfquery>