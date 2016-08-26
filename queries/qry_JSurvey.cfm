<!--- called by JomaSurvey.cfm --->

<cfquery name="JSurvey" datasource="survey">
	SELECT
		LeagueCode
	FROM
		survey_joma
</cfquery>
