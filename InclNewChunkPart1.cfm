<cfinclude template="queries/qry_QLeagueTableComponents.cfm">
<cfinclude template="queries/qry_QLeagueTableRows.cfm">
<cfinclude template="queries/qry_QNeverDefeated.cfm">
<cfset NeverDefeatedList = ValueList(QNeverDefeated.CIdentity)>
<cfif QNeverDefeated.RecordCount IS 0 >
	<cfset NeverDefeatedList = ListAppend(NeverDefeatedList,0)>
</cfif>

