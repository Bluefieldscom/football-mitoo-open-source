<!--- called by Joma.cfm --->

<cfquery name="JomaSurvey" datasource="survey">
	INSERT INTO survey_joma 
		(LeagueCode, dtstamp)
	VALUES 
		(
	<cfqueryparam value="#LeagueCode#" cfsqltype="CF_SQL_VARCHAR" maxlength="7">,
	<cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP">
		)
</cfquery>
