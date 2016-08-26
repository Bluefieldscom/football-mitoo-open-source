<!---
<cfif NOT ListFind("Silver",request.SecurityLevel) > <!--- Julian only --->
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

--->



<!--- example... NOTE we need five columns even if last column is empty Notes. Make sure the name is the Team name only, without "Reserves" or other ordinal 
{BatchLoadFixtures}
2007-09-02,Prem,Walls Sports & Social Club,Newent Falcons,xxx
2007-09-02,Prem,Leonard Stanley,Rising Star,xxx
2007-09-02,Prem,Frampton CC,Prospect Bush,xxx
2007-09-02,Prem,Tuffley Tigers,Hardwicke (Sunday),xxx
2007-09-02,Prem,Gloucester Eagles,Pike & Musket,xxx
2007-09-09,Prem,Porkys,Leonard Stanley,xxx
2007-09-09,Prem,Pike & Musket,Walls Sports & Social Club,xxx
--->


<cfoutput>
	<!--- get the ID for a blank KORound --->
	<cfinclude template="queries/qry_QBatchLoadFixturesK.cfm">			
	<!--- get the ID for a blank referee  --->
	<cfinclude template="queries/qry_QBatchLoadFixturesR.cfm">			
	<!--- Posit no errors --->
	<cfset ErrorCount = 0 >
	<cfset request.NewFixtures = QueryNew("HomeID, AwayID, FixtureDate, KORoundID, RefereeID, AsstRef1ID, AsstRef2ID, FourthOfficialID, AssessorID, Fixturenotes, LeagueCode, MatchNumber, PitchAvailableID") >
	<cfloop index="I" from="2" to="2000" step="1">
		<cfset LineString = #Trim(GetToken(Form.BatchInput, I, CHR(10) )) #>
		<!--- Comma separated variables --->
		<cfif TRIM(LineString) IS "">
			<cfbreak>
		</cfif>
		<cfset DateString = ListGetAt(LineString,1) >
		<cfset DivisionString = ListGetAt(LineString,2) >
		<cfset HomeString = ListGetAt(LineString,3) >
		<cfset AwayString = ListGetAt(LineString,4) >
		<cfset NotesString = ListGetAt(LineString,5) >
		<cfif NOT QBatchLoadFixturesK.RecordCount IS 1>
			ERROR: QBatchLoadFixturesK<br />
			<cfdump var="#QBatchLoadFixturesK#">
			<cfabort>
		</cfif>
		<cfif NOT QBatchLoadFixturesR.RecordCount IS 1>
			ERROR: QBatchLoadFixturesR<br />
			<cfdump var="#QBatchLoadFixturesR#">
			<cfabort>
		</cfif>
		<cfinclude template="queries/qry_QBatchLoadFixturesH.cfm">		
		<cfif NOT QBatchLoadFixturesH.RecordCount IS 1>
			<cfset ErrorCount = ErrorCount + 1 >
			Home Team not found: #DateString# <strong>#HomeString#</strong> division: #DivisionString#<br />
		</cfif>
		<cfinclude template="queries/qry_QBatchLoadFixturesA.cfm">		
		<cfif NOT QBatchLoadFixturesA.RecordCount IS 1>
			<cfset ErrorCount = ErrorCount + 1 >
			Away Team not found: #DateString# <strong>#AwayString#</strong> division: #DivisionString#<br />
		</cfif>
		<cfset temp = QueryAddRow(request.NewFixtures, 1) >
		<cfset temp = QuerySetCell(request.NewFixtures, "HomeID", #QBatchLoadFixturesH.HomeID# )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "AwayID", #QBatchLoadFixturesA.AwayID# )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "FixtureDate", "#DateString#" )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "KORoundID", #QBatchLoadFixturesK.NullKORoundID# )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "RefereeID", #QBatchLoadFixturesR.NullRefereeID# )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "AsstRef1ID", #QBatchLoadFixturesR.NullRefereeID# )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "AsstRef2ID", #QBatchLoadFixturesR.NullRefereeID# )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "FourthOfficialID", #QBatchLoadFixturesR.NullRefereeID# )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "AssessorID", #QBatchLoadFixturesR.NullRefereeID# )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "Fixturenotes", "#NotesString#" )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "LeagueCode", "#request.filter#" )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "MatchNumber", 0 )  >
		<cfset temp = QuerySetCell(request.NewFixtures, "PitchAvailableID", 0 )  >
	</cfloop>
	

	<cfif ErrorCount IS 0 >
		<cfinclude template="queries/qry_QNewFixtures.cfm">		
		<cfdump var="#QNewFixtures#"><br /><br /><br />
		<cfloop query="QNewFixtures">
			<cfinclude template="queries/ins_QNewFixtures.cfm">		
		</cfloop>
		DONE............	
	<cfelse>
		errors found.........	
	</cfif>
				
</cfoutput>	


