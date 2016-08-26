<!--- called by InclAdjustNewLeagueTableRows.cfm --->

<cfquery name="UpdLeagueTable1" datasource="#request.DSN#">
	UPDATE
		leaguetable
	SET
		Special = '#CIDList#'
	WHERE
		DivisionID = #ThisDivisionID#
		AND Rank IN (#NList#)
</cfquery>
