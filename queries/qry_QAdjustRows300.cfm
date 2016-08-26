<!--- called by InclAdjustNewLeagueTableRows.cfm --->

<cfquery name="QAdjustRows300" datasource="#request.DSN#">
	SELECT
		Name
	FROM
		leaguetable
	WHERE
		DivisionID = #ThisDivisionID# AND ConstitutionID = #QAdjustRows200.ConstitutionID#
</cfquery>
