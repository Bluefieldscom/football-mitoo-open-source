<!--- called by LeagueTab.cfm --->

				<!--- Allow the user to send a plain old email of the league table.
				Of course, only do all the extra processing if he has opted to receive stuff
				 Firstly, get the longest team name. --->

<cfoutput>
<cfset Longest = 1>
<cfloop query="QNewLeagueTable">
	<cfset ThisLength = Len(QNewLeagueTable.Name)>
	<cfif ThisLength GT Longest>
		<cfset Longest = ThisLength>
	</cfif>
</cfloop>
<!--- Building up LgTblText, the body of the email message is the league table! --->
<cfset HdrText = "#CJustify(SeasonName, 100)##CHR(10)##CJustify(LeagueName, 100)##CHR(10)##CJustify(DivisionName, 100)##CHR(10)##CHR(10)#">
<cfset ColHdrText = "#LJustify(" ", Longest)##CHR(9)#  P#CHR(9)#  W#CHR(9)#  D#CHR(9)#  L#CHR(9)#">
<cfif HideGoals IS "No">
	<cfset ColHdrText = "#ColHdrText#  F#CHR(9)#  A#CHR(9)#">
<cfelse>
	<cfset ColHdrText = "#ColHdrText#Pts#CHR(10)#" >	
</cfif>
<cfif HideGoals IS "No">
	<CFSWITCH expression="#LeagueTblCalcMethod#">
		<CFCASE VALUE = "Goal Difference" >
			<cfif HideGoalDiff IS "No">
				<cfset ColHdrText = "#ColHdrText#  GD#CHR(9)#Pts#CHR(10)#" >
			<cfelse>
				<cfset ColHdrText = "#ColHdrText#Pts#CHR(10)#" >
			</cfif>
		</CFCASE>
		<CFCASE VALUE = "Goal Average" >
			<cfif HideGoalDiff IS "No">
				<cfset ColHdrText = "#ColHdrText# GA#CHR(9)#Pts#CHR(10)#" >
			<cfelse>
				<cfset ColHdrText = "#ColHdrText#Pts#CHR(10)#" >
			</cfif>
		</CFCASE>
		<CFCASE VALUE = "No Method" >		
			<cfset ColHdrText = "#ColHdrText#Pts#CHR(10)#" >
		</CFCASE>
		<CFCASE VALUE = "Two Points for a Win" >
			<cfif HideGoalDiff IS "No">
				<cfset ColHdrText = "#ColHdrText#  GD#CHR(9)#Pts#CHR(10)#" >
			<cfelse>
				<cfset ColHdrText = "#ColHdrText#Pts#CHR(10)#" >
			</cfif>
		</CFCASE>
		<CFDEFAULTCASE>		
			<!--- Should never reach here! --->
			Reached default case in LeagueTab (678) - Aborting....
			<CFABORT>
		</CFDEFAULTCASE>
	 </CFSWITCH>
</cfif>
<cfset LgTblText = "#HdrText##ColHdrText#">
<cfloop query="QNewLeagueTable">
	<cfset ColTeamDesc = LJustify(QNewLeagueTable.Name, Longest)>
	<cfset GamesPlayed = HomeGamesPlayed + AwayGamesPlayed >
	<cfset ColPlayed = "#CHR(9)##NumberFormat(GamesPlayed, "999")#">
	<cfset GamesWon = HomeGamesWon + AwayGamesWon >
	<cfset ColGamesWon = "#CHR(9)##NumberFormat(GamesWon, "999")#">
	<cfset GamesDrawn = HomeGamesDrawn + AwayGamesDrawn >
	<cfset ColGamesDrawn = "#CHR(9)##NumberFormat(GamesDrawn, "999")#">
	<cfset GamesLost = HomeGamesLost + AwayGamesLost >
	<cfset ColGamesLost = "#CHR(9)##NumberFormat(GamesLost, "999")#">
	<cfset GoalsFor = HomeGoalsFor + AwayGoalsFor >
	<cfset ColGoalsFor = "#CHR(9)##NumberFormat(GoalsFor, "999")#">
	<cfset GoalsAgainst = HomeGoalsAgainst + AwayGoalsAgainst >
	<cfset ColGoalsAgainst = "#CHR(9)##NumberFormat(GoalsAgainst, "999")#">
	<cfset Points = HomePoints + HomePointsAdjust +  AwayPoints + AwayPointsAdjust>
	<cfset ColPoints = "#CHR(9)##NumberFormat(Points, "999")#">	
	<cfset LgTblText = "#LgTblText##ColTeamDesc##ColPlayed##ColGamesWon##ColGamesDrawn##ColGamesLost#">
	<cfif HideGoals IS "No">
		<cfset LgTblText = "#LgTblText##ColGoalsFor##ColGoalsAgainst#">
	<cfelse>
		<cfset LgTblText = "#LgTblText##ColPoints##CHR(10)#" >
	</cfif>
	<cfif HideGoals IS "No">
		<CFSWITCH expression="#LeagueTblCalcMethod#">
			<CFCASE VALUE = "Goal Difference" >
				<cfset GoalDiff = GoalsFor - GoalsAgainst >
				<cfset ColGoalDiff = "#CHR(9)##NumberFormat( GoalDiff, "9999")#">
				<cfset LgTblText = "#LgTblText##ColGoalDiff##ColPoints##CHR(10)#" >
			</CFCASE>
			<CFCASE VALUE = "Goal Average" >
				<cfif GoalAverage GT 99.9999>
					<cfset ColGoalAverage = "#CHR(9)##NumberFormat( 99.9999, "99.9999")#">
				<cfelse>
					<cfset ColGoalAverage = "#CHR(9)##NumberFormat( GoalAverage, "99.9999")#">
				</cfif>
				<cfset LgTblText = "#LgTblText##ColGoalAverage##ColPoints##CHR(10)#" >
			</CFCASE>
			<CFCASE VALUE = "No Method" >		
				<cfset LgTblText = "#LgTblText##ColPoints##CHR(10)#" >
			</CFCASE>
			<CFCASE VALUE = "Two Points for a Win" >
				<cfset ColGoalDiff = "#CHR(9)##NumberFormat( GoalDiff, "9999")#">
				<cfset LgTblText = "#LgTblText##ColGoalDiff##ColPoints##CHR(10)#" >
			</CFCASE>
			<CFDEFAULTCASE>		
				<!--- Should never reach here! --->
				Reached default case in LeagueTab (77) - Aborting....
				<CFABORT>
			</CFDEFAULTCASE>
		 </CFSWITCH>
	</cfif>
 </cfloop>
 <cfset UnderTblTxt = "">
 <cfloop query="QGetPointsAdjust">
	<cfset PartA = "#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#: ">
	<cfif HomePointsAdjust IS NOT 0>
		<cfset PartB = "[#NumberFormat(HomePointsAdjust,"+9")# pts] " >
	<cfelse>
		<cfset PartB = "">
	</cfif>
	<cfset PartC1 = "#TRIM(HomeTeamName)# #TRIM(HomeOrdinal)#">
	<cfset PartC1 = "#TRIM(PartC1)# ">
	<cfif HomeGoals IS ""><cfset PartC2 = ""><cfelse><cfset PartC2 = "#HomeGoals# "></cfif>
	<cfset PartC3 ="v">
	<cfif AwayGoals IS ""><cfset PartC4 = ""><cfelse><cfset PartC4 = " #AwayGoals#"></cfif>
	<cfset PartC5 = "#TRIM(AwayTeamName)# #TRIM(AwayOrdinal)#">
	<cfset PartC5 = " #TRIM(PartC5)#">
	<cfset PartC = "#PartC1##PartC2##PartC3##PartC4##PartC5#">
	<cfif AwayPointsAdjust IS NOT 0>
		<cfset PartD = " [#NumberFormat(AwayPointsAdjust,"+9")# pts]" >
	<cfelse>
		<cfset PartD = "">
	</cfif>
	<cfif AwardedResult IS "H" >
		<cfset PartE = " - Home Win was awarded">
	<cfelseif AwardedResult IS "A" >
		<cfset PartE = " - Away Win was awarded">
	<cfelseif AwardedResult IS "D" >
		<cfset PartE = " - Draw was awarded">
	<cfelseif AwardedResult IS "W" >
		<cfset PartE = " - Void">
	<cfelse>
		<cfset PartE = "">
	</cfif>
	<cfset UnderTblTxt = "#UnderTblTxt##CHR(10)##PartA##PartB##PartC##PartD##PartE#" >
</cfloop>
<cfset SubjectString ="#DivisionName# League Table - #LeagueName#  [#SeasonName#]">
</cfoutput>