<!---
called by UnschedAction.cfm

Get the names of the Home & Away teams (again!) in the desired fixture
--->

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>



<cfinclude template="queries/qry_QDesired.cfm">

<cfif QDesired.HomeMatchNumber IS NOT QDesired.AwayMatchNumber>
	<cfoutput>
		InclInsrtGroupOfFixtures.cfm - Serious problem: Home #QDesired.HomeMatchNumber# v Away #QDesired.AwayMatchNumber# : Match numbers disagree.
		<CFABORT>
	</cfoutput>
</cfif>
<cfinclude template="queries/qry_GetDivision_v2.cfm">
<cfinclude template="queries/qry_QFixtureOK1.cfm">

<!---   
Set the desired date of the fixture....
--->
<cfset DesiredDate = MatchDate>

<cfif Left(GetDivision.Notes,2) IS "P1">
	<cfinclude template="queries/qry_QFixtureOK_H.cfm">
	<cfinclude template="queries/qry_QFixtureOK_A.cfm">
	<cfif QFixtureOK_H.HomeCount GE 1 OR QFixtureOK_A.AwayCount GE 1 >
		<cfoutput query="QDesired">
			<span class="pix24boldred">#HomeTeam# #HomeOrdinal# can only meet #AwayTeam# #AwayOrdinal# once...<BR><BR>
					<cfoutput>Please <a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(DesiredDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">click here</a> to continue ....</cfoutput>
			</span>
		</cfoutput>
		<CFABORT>
	</cfif>		
<cfelseif Left(GetDivision.Notes,2) IS "P3">
	<cfinclude template="queries/qry_QFixtureOK_H.cfm">
	<cfinclude template="queries/qry_QFixtureOK_A.cfm">
	<cfif  (QFixtureOK_H.HomeCount GE 2) OR ((QFixtureOK_H.HomeCount + QFixtureOK_A.AwayCount) GE 3) >
		<cfoutput query="QDesired">
			<span class="pix24boldred">#HomeTeam# #HomeOrdinal# can only meet #AwayTeam# #AwayOrdinal# three times<BR>
			and only twice at home or twice away...<BR><BR>
					<cfoutput><cfoutput>Please <a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(DesiredDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">click here</a> to continue ....</cfoutput></cfoutput>
			</span>
		</cfoutput>
		<CFABORT>
	</cfif>		
<cfelseif Left(GetDivision.Notes,2) IS "P4">
	<cfinclude template="queries/qry_QFixtureOK_H.cfm">
	<cfif QFixtureOK_H.HomeCount GE 2 >
		<cfoutput query="QDesired">
			<span class="pix24boldred">#HomeTeam# #HomeOrdinal# and #AwayTeam# #AwayOrdinal# can only meet twice at home and twice away...<BR><BR>
					<cfoutput>Please <a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(DesiredDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">click here</a> to continue ....</cfoutput>
			</span>
		</cfoutput>
		<CFABORT>
	</cfif>		
</cfif>
<cfif (Left(GetDivision.Notes,2) IS NOT "P1") AND (Left(GetDivision.Notes,2) IS NOT "P3") AND (Left(GetDivision.Notes,2) IS NOT "P4") AND (QFixtureOK1.RecordCount IS NOT 0) >
	<span class="pix24boldred"><cfoutput>#GetDivision.DesiredDivisionName# - #DateFormat( DesiredDate , "DDDD, DD MMMM YYYY")#</cfoutput><BR><BR></span>
	<cfoutput query="QDesired">
		<span class="pix18boldred">You want #HomeTeam# #HomeOrdinal# to play #AwayTeam# #AwayOrdinal#</em> on this date<BR><BR>but<BR><BR></span>
	</cfoutput>
	<cfoutput query="QFixtureOK1">
		<span class="pix18boldred">#HomeTeam# #HomeOrdinal# plays #AwayTeam# #AwayOrdinal# on #DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#<BR><BR></span>
		<span class="pix24boldred">
					<cfoutput>Please <a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(DesiredDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">click here</a> to continue ....</cfoutput>
		</span>
	</cfoutput>
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.CurrentDate = DesiredDate >
	</cflock>
	<CFABORT>
</cfif>

<!---
Looking across all the dates in the season.........
and looking at ALL "Divisions" .............
Check to see if the desired fixture doesn't clash
One of the teams in the desired fixture may already be busy that day!

Exception:
DOUBLE HEADERs is when Team A plays Team B for an hour then Team B plays Team A for an hour on the same day.
This is to relieve fixture congestion towards the end of the season. A v B would be put in first and this
would indicate that the game is at A's ground, then B v A will
be entered and "Double Header at A's ground" will appear after the team names.

--->

<!--- Firstly, get the Constitution.TeamID and Constitution.OrdinalID for our desired HomeID --->
<cfinclude template="queries/qry_QHomeID.cfm">
<cfoutput query="QHomeID">
	<cfset HomeTeamID = #TeamID#>
	<cfset HomeOrdinalID = #OrdinalID#>
</cfoutput>
<!--- Then, get the Constitution.TeamID and Constitution.OrdinalID for our desired AwayID --->
<cfinclude template="queries/qry_QAwayID.cfm">
<cfoutput query="QAwayID">
	<cfset AwayTeamID = #TeamID#>
	<cfset AwayOrdinalID = #OrdinalID#>
</cfoutput>
<cfinclude template="queries/qry_QFixtureOK2.cfm">
<CFPARAM name="DoubleHeader" default="No">
<cfif QFixtureOK2.RecordCount IS NOT 0 >
<!---
							*****************************
							*  Check for Double Header  *
							*****************************
--->
  	<cfif #HomeID# IS #QFixtureOK2.aID# AND
	      #AwayID# IS #QFixtureOK2.hID# >
		<cfset DoubleHeader = "Yes">
		
	<cfelseif Find( "MultipleMatches", GetDivision.Notes ) >
		<!--- ignore the check to see if a team plays more than once on any single date --->
		
	<cfelse>
		<cfoutput>
		<span class="pix24boldred">#GetDivision.DesiredDivisionName# - #DateFormat( DesiredDate , "DDDD, DD MMMM YYYY")#<BR><BR></span>
		</cfoutput>
		<cfoutput query="QDesired">
			<span class="pix18boldred">You want #HomeTeam# #HomeOrdinal# to play #AwayTeam# #AwayOrdinal# <BR><BR></span>
		</cfoutput>
		<span class="pix18boldred">but on this date<BR><BR></span>
		<cfoutput query="QFixtureOK2">
			<span class="pix18boldred">#HomeTeam# #HomeOrdinal# plays #AwayTeam# #AwayOrdinal# in #CompareDivisionName# <BR><BR></span>
		</cfoutput>
		<span class="pix24boldred">
					<cfoutput>Please <a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(DesiredDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#">click here</a> to continue ....</cfoutput>
		</span>
		<CFABORT>
	</cfif>
</cfif>

<!--- include a check for invalid combination of KO Round and Competition type--->
<cfinclude template="InclCheckKORound.cfm">

<!--------- FINALLY! Do the insert............ --->
<cfinclude template="queries/ins_Fixture.cfm">
		
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.CurrentDate = DesiredDate >
</cflock>
