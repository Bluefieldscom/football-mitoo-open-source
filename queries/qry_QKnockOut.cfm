<!--- called by 
Unsched.cfm 
LeagueTab.cfm
KOHist.cfm
Toolbar_1.cfm
--->

<CFQUERY NAME="QKnockOut" dbtype="query">
	SELECT
		CompetitionDescription, 
		CompetitionNotes as Notes
	FROM
		QCompetition
	WHERE
		CompetitionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>