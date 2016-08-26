<!--- called by GatherTeamsUnderClub.cfm  --->
<cfquery name="QInTheSameCounty" dbtype="query">
	SELECT QCounty.County FROM QCounty, QCountiesList WHERE QCounty.County = QCountiesList.County
</cfquery>
