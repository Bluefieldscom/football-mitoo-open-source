<cfquery name="QMigration" datasource="zmast">
	SELECT
		LeagueCodePrefix,
		GRpngName,
		FMpngName,
		GoalRunId
	FROM
		migration
	ORDER BY
		LeagueCodePrefix
</cfquery>

<!---
<cfset x = StructDelete(session, "MigrationLeagueList") > 
<cfset x = StructDelete(session, "GRpngNameList") > 
<cfset x = StructDelete(session, "FMpngNameList") > 
<cfset x = StructDelete(session, "GoalRunIdList") > 
--->


<cfset LeagueCodePrefixList = ValueList(QMigration.LeagueCodePrefix)>
<cfset GRpngNameList = ValueList(QMigration.GRpngName)>
<cfset FMpngNameList = ValueList(QMigration.FMpngName)>
<cfset GoalRunIdList = ValueList(QMigration.GoalRunId)>
<cfset Findex = ListFindNoCase(LeagueCodePrefixList,request.filter)>

<cfif Findex GT 0 >
	<cfif RIGHT(request.LeagueCode,4) IS "2009">
		<cfset ThisGRpngName = ListGetAt(GRpngNameList, Findex) >
		<cfset ThisFMpngName = ListGetAt(FMpngNameList, Findex) >
		<cfset ThisGoalRunId = ListGetAt(GoalRunIdList, Findex) >
		<cfif StructKeyExists(session, "MigrationLeagueList")>
			<cflock scope="session" timeout="10" type="readonly" >
				<cfset MigrationLeagueList = session.MigrationLeagueList >
			</cflock>
			<cfif ListFindNoCase(MigrationLeagueList,request.filter)>
				<!--- go straight to mitoo --->
			<cfelse>
				<cfset MigrationLeagueList = ListAppend(MigrationLeagueList,request.filter) >
				<cflock scope="session" timeout="10" type="exclusive">
					<cfset session.MigrationLeagueList = MigrationLeagueList >
				</cflock>
				<cflocation url="MigrationSplash.cfm?LeagueCode=#request.LeagueCode#&LeagueCodePrefix=#request.filter#&ThisGRpngName=#ThisGRpngName#&ThisFMpngName=#ThisFMpngName#&ThisGoalRunID=#ThisGoalRunID#" addtoken="no">
				<cfabort>
			</cfif>
		<cfelse>
			<cfset MigrationLeagueList = request.filter >
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.MigrationLeagueList = MigrationLeagueList >
			</cflock>
			<cflocation url="MigrationSplash.cfm?LeagueCode=#request.LeagueCode#&LeagueCodePrefix=#request.filter#&ThisGRpngName=#ThisGRpngName#&ThisFMpngName=#ThisFMpngName#&ThisGoalRunID=#ThisGoalRunID#" addtoken="no">
			<cfabort>
		</cfif>
	</cfif>
</cfif>