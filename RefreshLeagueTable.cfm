<!--- called by Action.cfm (X14), TeamList.cfm (X2) , InclBatchUpdate2.cfm (X1), TransferTeamToMisc.cfm (X2)  --->

<!--- added next 6 lines Sept 2009 for immediate creation of leaguetable rows after deletion --->
<!--- get LeagueTblCalcMethod  and Point values --->
<cfinclude template="queries/qry_QLeagueCode.cfm">
<cfset PointsForWin  = QLeagueCode.PointsForWin >
<cfset PointsForDraw = QLeagueCode.PointsForDraw >
<cfset PointsForLoss = QLeagueCode.PointsForLoss >
<cfset LeagueTblCalcMethod = QLeagueCode.LeagueTblCalcMethod >

<cftransaction>
	<!--- delete the leaguetable rows  --->
	<cfinclude template="queries/del_LeagueTable.cfm">
	<!--- immediate creation of new leaguetable rows  --->
	<cfinclude template="inclCreateNewLeagueTableRows.cfm">
</cftransaction>

<!--- remind the Administrator to update Match Bans if they have any suspensions of this type by highlighting the Match Bans link in red --->
<cfinclude template="queries/qry_GetSuspensions.cfm">
<cfif QGetSuspensions.MBCount GT 0>
	<cfset MBRValue = 1 >
	<cfset request.LeagueID = QLeagueCode.ID >
	<cfinclude template="queries/upd_LeagueInfo3.cfm">
</cfif>

<!--- added 11th February 2013 --->
<cfinclude template="queries/create_UmbrellaView.cfm">

