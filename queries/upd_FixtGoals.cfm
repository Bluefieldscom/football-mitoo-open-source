<!--- called by InclUpdtGoals.cfm --->

<cfquery name="FixtGoals" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET
		HomeGoals = <cfqueryparam value = #Form.HomeGoals# cfsqltype="CF_SQL_INTEGER" maxlength="3"> ,
		AwayGoals = <cfqueryparam value = #Form.AwayGoals# cfsqltype="CF_SQL_INTEGER" maxlength="3">
		<cfif Len(Trim(Form.Attendance)) GT 0>
			, Attendance = <cfqueryparam value = #Form.Attendance# cfsqltype="CF_SQL_INTEGER" maxlength="7">
		</cfif>
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #id# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

