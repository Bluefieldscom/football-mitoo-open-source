<cflock scope="session" timeout="10" type="readonly">
	<CFSET request.Hdr1 = session.Hdr1 >
</cflock>
<cfoutput>
	<CFIF request.Hdr1 IS "Unscheduled Matches">
		<cflocation url="Unsched.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
	<cfelseif request.Hdr1 IS "Fixtures & Results">
		<cflocation url="FixtRes.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
	<cfelseif request.Hdr1 IS "League Table">
		<cflocation url="LeagueTab.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
	<cfelseif request.Hdr1 IS "Knock Out History">
		<cflocation url="KOHist.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
	<cfelse>
		<cflocation url="News.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
	</CFIF>
</cfoutput>
