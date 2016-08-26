<cfsilent>
	<cfset FIDList = ValueList(QFixtures.FID)>
	<cfinclude template="queries/qry_QHomeStarPlayer.cfm">
	<cfinclude template="queries/qry_QAwayStarPlayer.cfm">
</cfsilent>