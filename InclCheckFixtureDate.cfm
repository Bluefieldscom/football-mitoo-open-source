<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<link href="fmstyle.css" rel="stylesheet" type="text/css">
<!---
Get the names of the Home & Away teams (again!) in the desired fixture
--->
<cfinclude template="queries/qry_QCheckFixtureDate.cfm">


<cfif QCheckFixtureDate.HomeMatchNumber IS NOT QCheckFixtureDate.AwayMatchNumber>
	<cfoutput>
		Serious problem: Home #QCheckFixtureDate.HomeMatchNumber# v Away #QCheckFixtureDate.AwayMatchNumber# : Match numbers disagree.
		<cfabort>
	</cfoutput>
</cfif>
<cfinclude template="queries/qry_GetDivision_v2.cfm">
<!---
Looking across all the dates in the season.........
Looking at one "Division" only.............
Do not allow the same fixture to be played more than once
e.g. A.E.C. v. Kodak Harrow Saturday can't be played more than once in a season in Division One

This same fixture may arise, on a different date of course, in a Cup competition (different "Division")
and would be allowed.

Errors will arise when people play with the Back button on the browser.
They might insert the same fixture on more than one date in this stupid way!
--->
<cfinclude template="queries/qry_QFixtureOK1.cfm">
<!---
Set the desired date of the fixture....
--->
<cfset DesiredDate = MatchDate>

<cfif (Left(GetDivision.Notes,2) IS NOT "P1") AND (Left(GetDivision.Notes,2) IS NOT "P3") AND (Left(GetDivision.Notes,2) IS NOT "P4") AND (QFixtureOK1.RecordCount IS NOT 1) >
	<cfoutput>
		<span class="pix24boldred">#GetDivision.DesiredDivisionName# - #DateFormat( DesiredDate , "DDDD, DD MMMM YYYY")#<BR><BR></span>
	</cfoutput>
	<cfoutput query="QCheckFixtureDate">
		<span class="pix13">You want <strong>#HomeTeam# #HomeOrdinal#</strong> to play <strong>#AwayTeam# #AwayOrdinal#</strong> on this date<BR><BR>
		 but<BR><BR></span>
	</cfoutput>
	<cfif QFixtureOK1.RecordCount IS 0>
			<span class="pix13"><strong>this fixture has been deleted</strong><BR><BR></span>
			<span class="pix24boldred">Press the Back button on your browser.....</span>
	<cfelse>
		<cfoutput query="QFixtureOK1">
			<span class="pix13"><strong>#HomeTeam# #HomeOrdinal#</strong> plays <strong>#AwayTeam# #AwayOrdinal#</strong> 
			on #DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#<BR><BR></span>
			<span class="pix24boldred">Press the Back button on your browser.....</span>
		</cfoutput>
	</cfif>
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.CurrentDate = DesiredDate >
	</cflock>
	<cfabort> <!--- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> --->
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
<cfif QFixtureOK2.RecordCount IS NOT 0>
<!---
							*****************************
							*  Check for Double Header  *
							*****************************
--->
  	<cfif #HomeID# IS #QFixtureOK2.aID# AND
	      #AwayID# IS #QFixtureOK2.hID# >
		<cfset DoubleHeader = "Yes">
<!---
							***********************************
							*  They have ticked the checkbox  *
							* to suppress any warning message * 
							* and force through the update    *
							***********************************
--->
	<cfelseif DateChange IS "Yes" AND StructKeyExists(form, "DateCheckSuppress" ) > 
	<cfelse>
		<link href="fmstyle.css" rel="stylesheet" type="text/css">
		<cfoutput>
			<span class="pix24boldred">#GetDivision.DesiredDivisionName# - #DateFormat( DesiredDate , "DDDD, DD MMMM YYYY")#<BR><BR></span>
		</cfoutput>
		<cfoutput query="QCheckFixtureDate">
			<span class="pix13">You want <strong>#HomeTeam# #HomeOrdinal#</strong> to play <strong>#AwayTeam# #AwayOrdinal#</strong> but on this date<BR><BR></span>
		</cfoutput>
		<cfoutput query="QFixtureOK2">
				<span class="pix13"><strong>#HomeTeam# #HomeOrdinal#</strong> plays <strong>#AwayTeam# #AwayOrdinal#</strong> in #CompareDivisionName# <BR><BR></span>
		</cfoutput>
		<span class="pix24boldred">Press the Back button on your browser.....</span>
		<!---
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.CurrentDate = DesiredDate >
		</cflock>
		--->
		<cfabort> <!--- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> --->
	</cfif>
</cfif>

<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.CurrentDate = DesiredDate >
</cflock>

