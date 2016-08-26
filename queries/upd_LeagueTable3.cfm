<!--- called by InclAdjustNewLeagueTableRows.cfm --->

<cfquery name="UpdLeagueTable3" datasource="#request.DSN#">
	UPDATE
		leaguetable
	SET
		Name = '#QAdjustRows300.Name#&nbsp;&nbsp;&nbsp;[GD #QAdjustRows200.GoalDiff#, GF #QAdjustRows200.GoalsFor#]'
	WHERE
		DivisionID = #ThisDivisionID# AND ConstitutionID = #QAdjustRows200.ConstitutionID#
</cfquery>
