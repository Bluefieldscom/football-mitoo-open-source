<!--- called by InclUpdtRefMarks.cfm --->

<cfquery name="FixtRefMarks" datasource="#request.DSN#" >
	UPDATE
		fixture
	SET
		RefereeMarksH = <cfqueryparam value = #Form.RefereeMarksH# cfsqltype="CF_SQL_INTEGER" maxlength="3"> ,
		RefereeMarksA = <cfqueryparam value = #Form.RefereeMarksA# cfsqltype="CF_SQL_INTEGER" maxlength="3">
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #id# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

