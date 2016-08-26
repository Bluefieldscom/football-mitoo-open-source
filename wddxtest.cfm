<cfsetting showdebugoutput="No">
<cfsilent>
<cfinclude template="queries/qry_QLeagueTableComponents.cfm">
<cfinclude template="queries/qry_QLeagueTableRows.cfm">
<cfwddx action="CFML2WDDX" input="#QLeagueTableRows#" output="QueryObject" usetimezoneinfo="no">
</cfsilent>
<cfoutput>#(QueryObject)#</cfoutput>

