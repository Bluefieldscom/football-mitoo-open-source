<!--- called by JomaSurvey.cfm --->

<cfquery name="JomaSurvey" datasource="survey">
	SELECT
		COUNT(LeagueCode) as JCount,
		date(dtstamp) as JDate,
		dtstamp
	FROM
		survey_joma
	GROUP BY
		JDate
	ORDER BY
		JDate 
</cfquery>
