<!--- e.g. LeagueTabTiny.cfm?DivisionID=33&LeagueCode=MDX2006 --->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<cfif StructKeyExists(url, "LeagueCode")>
	<cfoutput>
	<span class="pix10">#LeagueCode#</span>
	</cfoutput>
<cfelse>
	LeagueCode url parameter is missing. Aborting.
	<cfabort>
</cfif>
<cfif StructKeyExists(url, "DivisionID")>
	<cfoutput>
	<span class="pix10">#DivisionID#<br /></span>
	</cfoutput>
<cfelse>
	DivisionID url parameter is missing. Aborting.
	<cfabort>
</cfif>

	

<!---
Get all the specific League Information from the row in table LeagueInfo (in ZMAST database) 
which has matching LeagueCode
--->
<cfquery name="QLeagueCode" datasource="ZMAST" >	
	SELECT
		ID,
		CountiesList,
		Namesort,
		LeagueName,
		DefaultLeagueCode,
		LeagueCodePrefix,
		LeagueCodeYear,
		BadgeJpeg,
		WebsiteLink,
		DefaultDivisionID, 
		PointsForWin,
		PointsForDraw,
		PointsForLoss,
		LeagueTblCalcMethod,
		DefaultYouthLeague, 
		SeasonName,
		SeasonStartDate,
		SeasonEndDate, 
		DefaultNationalSystem, 
		DefaultRulesAndFines, 
		RandomPlayerRegNo ,
		RefMarksOutofHundred,
		DefaultGoalScorers,
		LeagueType,
		AltLeagueCodePrefix,
		Alert,
		VenueAndPitchAvailable,
		SuppressTeamSheetEntry
	FROM
		leagueinfo
	WHERE
		DefaultLeagueCode = <cfqueryparam value = '#url.LeagueCode#' cfsqltype="CF_SQL_VARCHAR" maxlength="9">
</cfquery>

<cfif QLeagueCode.RecordCount IS 0>
	<cfoutput>
	<span class="pix10">LeagueCode url parameter [#LeagueCode#] is invalid. Aborting.<br /></span>
	</cfoutput>
	<cfabort>
</cfif>

<cfset LeagueName = QLeagueCode.LeagueName >
<cfset SeasonStartDate = QLeagueCode.SeasonStartDate >
<cfset SeasonEndDate = QLeagueCode.SeasonEndDate >
<cfset SeasonName = QLeagueCode.SeasonName >


<cfset LeagueTblCalcMethod = QLeagueCode.LeagueTblCalcMethod >
<cfset DefaultLeagueCode = #LeagueCode# >
<cfset BadgeJpeg = QLeagueCode.BadgeJpeg >
<cfset WebsiteLink = QLeagueCode.WebsiteLink >
<cfset DefaultDivisionID = QLeagueCode.DefaultDivisionID >
<cfset CountiesList = QLeagueCode.CountiesList >
<cfset DefaultYouthLeague = QLeagueCode.DefaultYouthLeague >
<cfset DefaultNationalSystem = QLeagueCode.DefaultNationalSystem >
<cfset DefaultRulesAndFines = QLeagueCode.DefaultRulesAndFines >
<cfset DefaultGoalScorers = QLeagueCode.DefaultGoalScorers >
<cfset Alert = QLeagueCode.Alert >
<cfset VenueAndPitchAvailable = QLeagueCode.VenueAndPitchAvailable >
<cfset RandomPlayerRegNo = QLeagueCode.RandomPlayerRegNo >
<cfset request.LeagueID = QLeagueCode.ID >
<cfset LeagueCodePrefix = QLeagueCode.LeagueCodePrefix >
<cfset LeagueCodeYear = QLeagueCode.LeagueCodeYear >
<cfset LeagueType = QLeagueCode.LeagueType >
<cfset SuppressTeamSheetEntry = QLeagueCode.SuppressTeamSheetEntry >
		
<cfset PointsForWin  = QLeagueCode.PointsForWin >
<cfset PointsForDraw = QLeagueCode.PointsForDraw >
<cfset PointsForLoss = QLeagueCode.PointsForLoss >

<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.RefMarksOutOfHundred = QLeagueCode.RefMarksOutOfHundred >
	<cfset session.LeagueCodePrefix = QLeagueCode.LeagueCodePrefix >
	<cfset session.SeasonStartDate = QLeagueCode.SeasonStartDate >
	<cfset session.SeasonEndDate = QLeagueCode.SeasonEndDate >
	<cfset session.LeagueType = QLeagueCode.LeagueType >
	<cfset session.LeagueID = request.LeagueID >
	<cfif NOT session.LoggedInLeague IS DefaultLeagueCode>
		<cfset session.LoggedIn = "No" >
		<cfset session.LeagueReports = "No" >
	</cfif>
</cflock>

<cfset CounterText = "">
<cfset SiteType = "league">
<!--- all counter data now on a single table in fmpagecount (MySQL) --->
<cfinclude template="queries/upd_QUpdateCounter.cfm">
<cfinclude template="queries/qry_QReadCounter.cfm">

<cfset CounterText = "#NumberFormat(QReadCounter.CounterValue, '999,999,999')# page requests for this #SiteType# since #DateFormat(QReadCounter.CounterStartDateTime, 'DD MMMM YYYY')#">

<CFQUERY NAME="QCompetition" datasource="#request.DSN#">
	SELECT 
		ID        as CompetitionID,
		LongCol    as CompetitionDescription,
		MediumCol  as CompetitionSortOrder,
		ShortCol   as CompetitionCode,
		Notes     as CompetitionNotes
	FROM
		division
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</CFQUERY>



	<cfoutput>
		<title>
		football.mitoo 
		</title>
	</cfoutput>
</head>
<body>



<CFPARAM NAME="LeagueCode" DEFAULT="#DefaultLeagueCode#" >
<!--- I've fixed it so that the default Division is shown --->
<CFPARAM NAME="DivisionID" DEFAULT="#DefaultDivisionID#" >
<CFPARAM NAME="TeamID" DEFAULT=0 >
<CFPARAM NAME="HomeID" DEFAULT=0 >
<CFPARAM NAME="AwayID" DEFAULT=0 >
<CFPARAM NAME="OrdinalID" DEFAULT=0 >
<CFPARAM NAME="ThisMatchNoID" DEFAULT=0 >
<CFPARAM NAME="NextMatchNoID" DEFAULT=0 >
<CFPARAM NAME="MDate" DEFAULT=0 >
<CFPARAM NAME="CI" DEFAULT=0 >
<table width="400" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td align="center" valign="middle" ><img src="fmtiny.jpg" border=0></td>
	</tr>
</table>


<!--- cfinclude template="Toolbar2.cfm" --->


<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition
If it is, then we'll jump over to Knock Out History instead
--->
<CFPARAM name="KO" default="No">

<CFQUERY NAME="QKnockOut" dbtype="query">
	SELECT
		CompetitionNotes as Notes
	FROM
		QCompetition
	WHERE
		CompetitionID = <cfqueryparam value = #url.DivisionID# cfsqltype="CF_SQL_INTEGER" maxlength="6">
</CFQUERY>


<cflock scope="session" timeout="10" type="readonly">
	<cfset request.fmTeamID = session.fmTeamID>
</cflock>

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
<cfif Find( "SuppressTable", QKnockOut.Notes )>
	<cfset SuppressTable = "Yes">
<cfelse>
	<cfset SuppressTable = "No">
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

<cfinclude template="queries/qry_QGetPointsAdjust.cfm">


<cfif NoOfMeetings IS 1>
	<table width="400" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other once only</span></td>
		</tr>
	</table>
<cfelseif NoOfMeetings IS 3>
	<table width="400" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other three times</span></td>
		</tr>
	</table>
<cfelseif NoOfMeetings IS 4>
	<table width="400" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other four times</span></td>
		</tr>
	</table>
<cfelse>

</cfif>

<cfif HideGoals IS "Yes">
	<table width="400" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Goals For, Goals Against and Goal Difference columns have been hidden at the League's request</span></td>
		</tr>
	</table>
</cfif>

<cfif SuppressTable IS "Yes">
	<table width="400" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">This has been suppressed at the League's request</span></td>
		</tr>
	</table>
	<CFABORT>
</cfif>
	
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.fmTeamID = session.fmTeamID>
</cflock>
<cfset ThisDivisionID = DivisionID >
<cfinclude template="queries/qry_QNewLeagueTable.cfm">
<cfif QNewLeagueTable.RecordCount IS 0 >
	<cfinclude template="RefreshLeagueTable.cfm">
	<!---    <cfinclude template="InclAdjustNewLeagueTableRows.cfm">    Re-Order rows where maximum played and same number of points and same goal difference --->
	<cfinclude template="queries/qry_QNewLeagueTable.cfm">
</cfif>

<!--- cfinclude template="InclNewLeagueTable.cfm">   Display the League Table --->

<table width="400" border="0" cellspacing="2" cellpadding="0" >
<!---																		****************************************************************
																			* This chunk of code produces the league table column headings *
																			****************************************************************
--->
		<tr>
			<td ><span class="pix10">&nbsp;<cfoutput>#QNewLeagueTable.RecordCount#</cfoutput> Teams</span></td>
			<td align="center"><span class="pix10">P</span></td>
			<td align="center"><span class="pix10">W</span></td>
			<td align="center"><span class="pix10">D</span></td>
			<td align="center"><span class="pix10">L</span></td>
			<cfif HideGoals IS "No">  <!--- otherwise hide next three columns: Goals For, Goals Against and  Goal Difference (or Average) --->
				<td align="center"><span class="pix10">F</span></td>
				<td align="center"><span class="pix10">A</span></td>
				<cfif LeagueTblCalcMethod IS "No Method" >
				<cfelseif LeagueTblCalcMethod IS "Goal Average">
					<td align="center"><span class="pix10">GA</span></td>
				<cfelse>
					<td align="center"><span class="pix10">GD</span></td>
				</cfif>
			</cfif>
			<td align="center"><span class="pix10">Pts</span></td>
		</tr>		
	<cfoutput query="QNewLeagueTable">
	<!--- 
																			*****************************************************
																			* This chunk of code produces the league table rows *
																			*****************************************************
	--->
		<cfif request.fmTeamID IS TeamID AND CurrentRow LE PromotedRows >
			<cfset ClassType = "HiLitePromoted">
		<cfelseif request.fmTeamID IS TeamID AND CurrentRow GE (QNewLeagueTable.RecordCount-RelegatedRows+1) >
			<cfset ClassType = "HiLiteRelegated">
		<cfelseif CurrentRow LE PromotedRows >
			<cfset ClassType = "Promoted">
		<cfelseif CurrentRow GE (QNewLeagueTable.RecordCount-RelegatedRows+1) >
			<cfset ClassType = "Relegated">
		<cfelseif request.fmTeamID IS TeamID >
			<cfset ClassType = "HiLite">
		<cfelse>
			<cfset ClassType = "">
		</cfif>
		<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
		
			<td  align="left" class="#ClassType#" ><span class="pix10">#Name#</span></td>
			<td align="center" width="5%"  class="#ClassType#"><span class="pix10">#HomeGamesPlayed+AwayGamesPlayed#</span></td><!--- Games Played --->
			<td align="center" width="5%"  class="#ClassType#"><span class="pix10">#HomeGamesWon+AwayGamesWon#</span></td><!--- Games Won --->
			<td align="center" width="5%"  class="#ClassType#"><span class="pix10">#HomeGamesDrawn+AwayGamesDrawn#</span></td><!--- Games Drawn --->
			<td align="center" width="5%"  class="#ClassType#"><span class="pix10">#HomeGamesLost+AwayGamesLost#</span></td><!--- Games Lost --->
			<cfset GoalsFor = HomeGoalsFor+AwayGoalsFor >
			<cfset GoalsAgainst = HomeGoalsAgainst+AwayGoalsAgainst >
			<cfset GoalDiff = GoalsFor - GoalsAgainst >
			<cfset Points = HomePoints + AwayPoints >
			<cfset PointsAdjust = HomePointsAdjust + AwayPointsAdjust + PointsAdjustment >
			<cfif HideGoals IS "No">  <!--- otherwise hide next three columns: Goals For, Goals Against and  Goal Difference (or Average) --->
				<td align="center" width="5%"  class="#ClassType#"><span class="pix10">#GoalsFor#</span></td><!--- Goals For --->
				<td align="center" width="5%"  class="#ClassType#"><span class="pix10">#GoalsAgainst#</span></td><!--- Goals Against --->
				<cfif LeagueTblCalcMethod IS "No Method" >
				<cfelseif LeagueTblCalcMethod IS "Goal Average">
					<cfif GoalsAgainst IS 0 >
						<cfset GoalAverage = 9999999 >
					<cfelse>
						<cfset GoalAverage = GoalsFor / GoalsAgainst >
					</cfif>
					<td align="center" width="5%"  class="#ClassType#"><cfif GoalAverage GT 99.9999><span class="pix10">99.9999</span><cfelse><span class="pix10">#NumberFormat( GoalAverage, "99.9999")#</span></cfif></td>
				<cfelse>
					<cfif Len(Trim(Special)) GT 0 > 
						<cfset ClassType = "bg_suspend" >
					</cfif>			
					<td align="center" width="5%"  class="#ClassType#"><span class="pix10">#NumberFormat( GoalDiff, "L+999999^")#</span></td>
				</cfif>
			</cfif>
			<!--- Points --->
			<cfif Len(Trim(Special)) GT 0 >  
				<cfset ClassType = "bg_suspend" >
			</cfif>			
			<td align="center" width="5%"  class="#ClassType#"><cfif PointsAdjust IS 0><span class="pix10">#Points#</span><cfelse><span class="pix10boldnavy">#Points+PointsAdjust#</span></cfif></td>
		</tr>		
	</cfoutput>
</table>









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

<!--- Now, underneath the League Table, in small font, let's display all the Awarded games --->
<table  border="0" cellspacing="2" cellpadding="0" >
	<cfoutput query="QGetPointsAdjust">
	  	<cfset Highlight = "No">
		<cfif request.fmTeamID IS HomeTeamID>
			<cfset Highlight = "Yes">
		</cfif>
		<cfif request.fmTeamID IS AwayTeamID>
			<cfset Highlight = "Yes">
		</cfif>
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

