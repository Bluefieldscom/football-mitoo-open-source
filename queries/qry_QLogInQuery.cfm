<!--- called by JLogInQuery.cfm --->

<cfquery name="QLogInQuery" datasource="ZMAST" >
SELECT
	li.NameSort,
	lh.ID,
	lh.LeagueCode,
	lh.UserName,
	lh.LoggedInOK,
	lh.Passwd,
	lh.DateTimeStamp,
	DAY(lh.DateTimeStamp) as DateX
FROM
	loghistory lh,
	leagueinfo li
WHERE
	lh.LeagueCode = li.DefaultLeagueCode
ORDER BY
	lh.ID DESC
LIMIT 200
</cfquery>

