<!--- called by BatchUpdate.cfm --->

<CFQUERY NAME="QThisFixture" datasource="#request.DSN#">
	SELECT
		ID, HomeID, AwayID, MatchNumber, FixtureDate, HomeGoals, AwayGoals,
		Result, Attendance, RefereeMarksH, RefereeMarksA 	
	FROM
		fixture 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #BFixtureID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
