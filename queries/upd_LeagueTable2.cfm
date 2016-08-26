<!--- called by InclAdjustNewLeagueTableRows.cfm --->

<cfquery name="UpdLeagueTable2" datasource="#request.DSN#">
	UPDATE
		leaguetable
	SET
		Rank = '#QAdjustRows200.Rank#'
	WHERE
		DivisionID = #ThisDivisionID# AND ConstitutionID = #ListGetAt(CIDList,QAdjustRows200.CurrentRow)#
</cfquery>
