<!--- called by 5 programs:
InclEmailFixturesAndResults.cfm
LeagueTab.cfm
MtchDay.cfm
--->

<cfinclude template="queries/qry_QEmailAddress.cfm">
<cfif QEmailAddress.RecordCount IS 0 >
	<cfinclude template="queries/ins_EmailAddress.cfm">
</cfif>
