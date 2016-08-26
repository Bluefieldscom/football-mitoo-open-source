<!--- Reverse fixture and swap Home and Away values - JAB Only --->
<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists (url, "SwapFixtureID") >
	<cfoutput>
		Julian, put the FixtureID parameter into the url and try again........be careful!
		<cfabort>
	</cfoutput>
</cfif>

<cfif url.SwapFixtureID IS 0 >
	<cfoutput>
		Julian, put the FixtureID parameter into the url and try again........be careful!
		<cfabort>
	</cfoutput>
</cfif>
<cfinclude template="queries/qry_Q10001.cfm">
<cfinclude template="queries/qry_Q10002.cfm">
<cfinclude template="queries/qry_Q10003.cfm">
<cfloop query="Q10003">
	<cfinclude template="queries/qry_Q10004.cfm">
</cfloop>
<cflocation url="UpdateForm.cfm?TblName=Matches&id=#Q10001.ID#&DivisionID=#Q10001.DivisionID#&HomeID=#Q10001.AwayID#&AwayID=#Q10001.HomeID#&LeagueCode=#LeagueCode#&Whence=MD">
