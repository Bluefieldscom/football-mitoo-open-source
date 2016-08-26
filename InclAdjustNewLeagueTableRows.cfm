	<!--- check to see if there are any  "Special Situation"  groups of teams in this table.
	A special group is a collection of two or more adjacent teams which share all of the following:
	have played the maximum number of games possible for their division
	have the same number of points
	have the same goal difference --->
<cfinclude template="queries/qry_QAdjustRows.cfm">
<cfset MaxRows = QAdjustRows.RecordCount >
<cfset MaxGames = ( MaxRows - 1 ) * NoOfMeetings >
<cfset ConstitutionIDList = ValueList(QAdjustRows.ConstitutionID) >
<cfset GamesPlayedList = ValueList(QAdjustRows.GamesPlayed) > 
<cfset PointsList = ValueList(QAdjustRows.Points) > 
<cfset GoalsForList = ValueList(QAdjustRows.GoalsFor) >
<cfset GoalsAgainstList = ValueList(QAdjustRows.GoalsAgainst) > 
<cfset GroupStart = "No">
<cfset n = 1 >
<cfloop condition="n LT MaxRows">
	<cfset NonSpecialCount = 0 >
	<cfloop condition = "n LT MaxRows AND NOT (ListGetAt(GamesPlayedList,n) IS MaxGames 
						AND ListGetAt(GamesPlayedList,n) IS ListGetAt(GamesPlayedList,n+1)
						AND (ListGetAt(GoalsForList,n)-ListGetAt(GoalsAgainstList,n)) IS (ListGetAt(GoalsForList,n+1)-ListGetAt(GoalsAgainstList,n+1)) 
						AND ListGetAt(PointsList,n) IS ListGetAt(PointsList,n+1))">
		<cfset n = n + 1>
		<cfset NonSpecialCount = NonSpecialCount + 1 >
	</cfloop>
	<cfset SpecialCount = 0 >
	<cfset NList = "" >	
	<cfloop condition = "n LT MaxRows AND (ListGetAt(GamesPlayedList,n) IS MaxGames 
						AND ListGetAt(GamesPlayedList,n) IS ListGetAt(GamesPlayedList,n+1)
						AND (ListGetAt(GoalsForList,n)-ListGetAt(GoalsAgainstList,n)) IS (ListGetAt(GoalsForList,n+1)-ListGetAt(GoalsAgainstList,n+1)) 
						AND ListGetAt(PointsList,n) IS ListGetAt(PointsList,n+1))">
		<cfset NList = ListAppend(NList, n) >
		<cfset n = n + 1>
		<cfset SpecialCount = SpecialCount + 1 >
	</cfloop>
	<cfif SpecialCount GT 0 >
		<cfset NList = ListAppend(NList, n) >
		<cfset CIDList = "">
		<cfloop from="1" to="#ListLen(NList)#" step="1" index="i">
			<cfset x = ListGetAt(NList,i) >
			<cfset CIDList = ListAppend(CIDList, ListGetAt(ConstitutionIDList,x)) >
		</cfloop>
		<cfinclude template="queries/qry_QAdjustRows100.cfm">
		<cfinclude template="queries/qry_QAdjustRows200.cfm">
		<cfinclude template="queries/upd_LeagueTable1.cfm">
		<cfoutput query="QAdjustRows200">
			<cfinclude template="queries/upd_LeagueTable2.cfm">
			<cfinclude template="queries/qry_QAdjustRows300.cfm">
			<cfinclude template="queries/upd_LeagueTable3.cfm">
		</cfoutput>
	</cfif>
</cfloop>
