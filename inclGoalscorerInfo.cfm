<cfsilent>
	<cfset FIDList = ValueList(QFixtures.FID)>
	<cfinclude template="queries/qry_QAllHomeGoalscorers.cfm">
	<cfinclude template="queries/qry_QAllAwayGoalscorers.cfm">
</cfsilent>
