
<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfscript>
	leagueTblCalcMethod 	= getLeagueYear.leagueTblCalcMethod;
	pointsForWin 			= getLeagueYear.pointsForWin;
	pointsForDraw 			= getLeagueYear.pointsForDraw;
	pointsForLoss 			= getLeagueYear.pointsForLoss;

	divisionID 				= arguments.mitoo_division_id;
	leagueCode 				= arguments.leagueCode;
	request.DSN 			= variables.dsn;
	request.filter 			= arguments.leagueCode;
	request.securitylevel 	= 'white';
	request.fmteamid 		= 0;
</cfscript>

<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition
If it is, then we'll jump over to Knock Out History instead
--->

<cfinclude template="../queries/qry_QCompetition.cfm">

<cfparam name="KO" default="No">

<cfinclude template="../queries/qry_QKnockOut.cfm">

<cfif Left(QKnockOut.Notes,2) IS "KO" >
	Cannot produce a result grid for Knockout competitions
	<cfabort>
</cfif>

<cfif     Left(QKnockOut.Notes,2) IS "P1" > 
	<cfset NoOfMeetings = 1>
<cfelseif Left(QKnockOut.Notes,2) IS "P3" >
	<cfset NoOfMeetings = 3>
<cfelseif Left(QKnockOut.Notes,2) IS "P4" >
	<cfset NoOfMeetings = 4>
<cfelse>
	<cfset NoOfMeetings = 2> <!--- "Normal" teams play each other twice a season, home and away --->
</cfif>

<!--- HideGoals will suppress Goals For, Goals Against and Goal Difference columns --->
<cfif Find( "HideGoals", QKnockOut.Notes )>
	<cfset HideGoals = "Yes">
<cfelse>
	<cfset HideGoals = "No">
</cfif>
<!--- HideGoalDiff will suppress Goal Difference columns --->
<cfif Find( "HideGoalDiff", QKnockOut.Notes )>
	<cfset HideGoalDiff = "Yes">
<cfelse>
	<cfset HideGoalDiff = "No">
</cfif>
<!--- HideDivision will suppress everything for this Division --->
<cfif Find( "HideDivision", QKnockOut.Notes )>
	<cfset HideDivision = "Yes">
<cfelse>
	<cfset HideDivision = "No">
</cfif>
<cfif Find( "SuppressTable", QKnockOut.Notes )>
	<cfset SuppressTable = "Yes">
<cfelse>
	<cfset SuppressTable = "No">
</cfif>

<cfif QKnockOut.CompetitionDescription IS "Miscellaneous" OR QKnockOut.CompetitionDescription IS "Friendly" >
	<cfset SuppressLeagueTable = "Yes">
<cfelse>
	<cfset SuppressLeagueTable = "No">
</cfif>

<!--- find out the number of rows to highlight at the top and bottom of a league table thereby indicating teams in a promotion/relegation positions
only a single digit is allowed, this should be plenty for every type of league, typically it will be one, two or three --->

<cfset PromotedRows = 0 >
<cfset RelegatedRows = 0 >

<cfset p = FindNoCase("Promoted=",QKnockOut.Notes) >
<cfif p GT 0 >
	<cfset PromotedRows = Mid(QKnockOut.Notes, (p+9), 1) >
	<cfif NOT IsNumeric(PromotedRows)>
		<cfset PromotedRows = 0 >
	</cfif>
</cfif>
<cfset r = FindNoCase("Relegated=",QKnockOut.Notes) >
<cfif r GT 0 >
	<cfset RelegatedRows = Mid(QKnockOut.Notes, (r+10), 1) >
	<cfif NOT IsNumeric(RelegatedRows)>
		<cfset RelegatedRows = 0 >
	</cfif>
</cfif>

<cfinclude template="../queries/qry_QGetPointsAdjust.cfm">


<cfset i = 1>

<cfif NoOfMeetings IS 1>
	<cfset QLeagueTable[#i#] = StructNew()>
	<cfset QLeagueTable[#i#].frequency = 'Teams play each other once only'>
<cfelseif NoOfMeetings IS 3>
	<cfset QLeagueTable[#i#] = StructNew()>
	<cfset QLeagueTable[#i#].frequency = 'Teams play each other three times'>
<cfelseif NoOfMeetings IS 4>
	<cfset QLeagueTable[#i#] = StructNew()>
	<cfset QLeagueTable[#i#].frequency = 'Teams play each other four times'>
<cfelse>
	<!--- blank --->
	<cfset QLeagueTable[#i#] = StructNew()>
	<cfset QLeagueTable[#i#].frequency = ''>
</cfif>

<cfset QLeagueTable[#i#].message = ''>

<cfif HideGoals IS "Yes">
	<cfset QLeagueTable[#i#].message = QLeagueTable[#i#].message & "Goals For, Goals Against and Goal Difference columns have been hidden at the League's request. ">
</cfif>

<cfif HideGoalDiff IS "Yes">
	<cfset QLeagueTable[#i#].message = QLeagueTable[#i#].message & " Goal Difference column has been hidden at the League's request.">
</cfif>

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND SuppressTable IS "Yes">
	<cfset QLeagueTable[#i#].message = QLeagueTable[#i#].message & " League table has been suppressed at the League's request.">
<!---	<cfabort> --->
</cfif>
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND SuppressLeagueTable IS "Yes">
	<cfset QLeagueTable[#i#].message = QLeagueTable[#i#].message & " League Table has been suppressed.">
<!---	<cfabort> --->
</cfif>
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND HideDivision IS "Yes"  >
	<cfset QLeagueTable[#i#].message = QLeagueTable[#i#].message & " League Table is not published.">
<!---	<cfabort> --->
</cfif>
<!---
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.fmTeamID = session.fmTeamID>
</cflock>
--->

<cfif NOT ListFind("Silver,Skyblue", request.SecurityLevel) 
		AND NOT SuppressTable IS "Yes"
		AND NOT SuppressLeagueTable IS "Yes"
		AND NOT HideDivision IS "Yes">

	<cfset ThisDivisionID = DivisionID >
	<cfinclude template="../queries/qry_QNewLeagueTable.cfm">
	<cfif QNewLeagueTable.RecordCount IS 0 >
		<cfinclude template="CreateNewLeagueTableRows.cfm">
	</cfif>	

	<cfinclude template="QLeagueTable_query.cfm">
</cfif>
<!---<cfinclude template="NewLeagueTable.cfm">--->

<!---

<!--- Now, underneath the League Table, in small font, let's display any team's non-match-specific points adjustment --->
<table  border="0" cellspacing="2" cellpadding="0" >
	<cfoutput query="QNewLeagueTable">
		<cfif PointsAdjustment IS 0 >
		<cfelse>
			<tr bgcolor="White">
				<td align="LEFT" >
					<span class="pix10">
						#Name# [#NumberFormat(PointsAdjustment,"+9")# points]
					</span>
				</td>
			</tr>
		</cfif>
	</cfoutput>
</table>

<!--- underneath the League Table - display all the Awarded games --->
<table  border="0" cellspacing="2" cellpadding="0" >
	<cfoutput query="QGetPointsAdjust">
	  	<cfset Highlight = "No">
		<cflock scope="session" timeout="10" type="readonly">
			<cfif session.fmTeamID IS HomeTeamID>
				<cfset Highlight = "Yes">
			</cfif>
			<cfif session.fmTeamID IS AwayTeamID>
				<cfset Highlight = "Yes">
			</cfif>
		</cflock>
		<tr bgcolor="White">
			<td align="LEFT" <cfif Highlight>class="bg_highlight"</cfif> >
			<span class="pix10">
				#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#:
				<cfif HomePointsAdjust IS NOT 0>[#NumberFormat(HomePointsAdjust,"+9")# <cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>point<cfelse>points</cfif>]</cfif> #HomeTeamName# #HomeOrdinal#
				     #HomeGoals# v #AwayGoals#
				#AwayTeamName# #AwayOrdinal# <cfif AwayPointsAdjust IS NOT 0>[#NumberFormat(AwayPointsAdjust,"+9")# <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>point<cfelse>points</cfif>]</cfif>
				<cfif AwardedResult IS "H" >
					- Home Win was awarded
				<cfelseif AwardedResult IS "A" >
					- Away Win was awarded
				<cfelseif AwardedResult IS "D" >
					- Draw was awarded
				<cfelse>
				</cfif>
			</span>
			</td>
		</tr>
	</cfoutput>
</table>
--->

