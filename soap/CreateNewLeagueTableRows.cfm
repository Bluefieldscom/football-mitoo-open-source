<!--- called by Unsched.cfm, LeagueTab.cfm, LeagueTabExpand.cfm --->

<!--- delete all the rows for in the table LeagueTbl for this competition --->
<cfinclude template="../queries/del_LeagueTable.cfm"> 

<!--- get LeagueTblCalcMethod  and Point values --->
<cfinclude template="../queries/qry_QLeagueCode.cfm">

<!--- do the counting of games and summing of goals etc  --->
<cfinclude template="../queries/qry_QLeagueTableComponents.cfm">

<!--- create the league table data rows sorted by points, goal diff etc  --->
<cfinclude template="../queries/qry_QLeagueTableRows.cfm"> 

<!--- for each of the rows produced by the above, insert a row into table LeagueTable  --->
<cfoutput query="QLeagueTableRows">
		<!--- DivisionID --->
			<cfset DivisionID = #DivisionID# >
		<!--- CompetitionName --->
			<cfset CompetitionName = #CompetitionName# >
		<!--- Rank --->
			<cfset Rank = #CurrentRow# >
		<!--- Name --->
			<cfset Name = TRIM('#ClubName# #OrdinalName#') >
		<!--- ConstitutionID --->
			<cfset ConstitutionID = #CIdentity# >
		<!--- TeamID --->
			<cfset TeamID = #TeamID# >
		<!--- PointsAdjustment --->
			<cfset PointsAdjustment = #PointsAdjustment# >
		<!--- HomeGamesPlayed --->
			<cfset HomeGamesPlayed = 
			  #CountHomeWinNormal# + #CountHomeDrawNormal# + #CountHomeDefeatNormal# 
			+ #CountHomeWinResultAwarded# + #CountHomeDrawResultAwarded# + #CountHomeDefeatResultAwarded# 
			+ #CountHomeWinOnPenalties# + #CountHomeDefeatOnPenalties# + #CountHomeVoid# >
		<!--- HomeGamesWon --->
			<cfset HomeGamesWon = 
			  #CountHomeWinNormal# +  
			+ #CountHomeWinResultAwarded# +  
			+ #CountHomeWinOnPenalties# >
		<!--- HomeGamesDrawn --->
			<cfset HomeGamesDrawn = 
			  #CountHomeDrawNormal# 
			+ #CountHomeDrawResultAwarded# >
		<!--- HomeGamesLost --->
			<cfset HomeGamesLost = 
			  #CountHomeDefeatNormal# 
			+ #CountHomeDefeatResultAwarded#
			+ #CountHomeDefeatOnPenalties# >
		<!--- HomeGamesActuallyPlayedAndLost --->
			<cfset HomeGamesActuallyPlayedAndLost = 
			  #CountHomeDefeatNormal# 
			+ #CountHomeDefeatOnPenalties# >
		<!--- HomeGoalsFor ---> 
			<cfset HomeGoalsFor = IIF(SumHomeGoalsFor IS "",0,SumHomeGoalsFor) >
		<!--- HomeGoalsAgainst --->
			<cfset HomeGoalsAgainst = IIF(SumHomeGoalsAgainst IS "",0,SumHomeGoalsAgainst) >
		<!--- HomePoints --->
			<cfset HomePoints = (#HomeGamesWon# * #PointsForWin#) + (#HomeGamesDrawn# * #PointsForDraw#) + (#HomeGamesActuallyPlayedAndLost# * #PointsForLoss#) >
		<!--- HomePointsAdjust --->
			<cfif IsNumeric(SumHomePointsAdjust) AND SumHomePointsAdjust IS NOT 0 >
				<cfset HomePointsAdjust = #SumHomePointsAdjust#>
			<cfelse>
				<cfset HomePointsAdjust = 0>
			</cfif>
			
		<!--- AwayGamesPlayed --->
			<cfset AwayGamesPlayed = 
			  #CountAwayWinNormal# + #CountAwayDrawNormal# + #CountAwayDefeatNormal# 
			+ #CountAwayWinResultAwarded# + #CountAwayDrawResultAwarded# + #CountAwayDefeatResultAwarded# 
			+ #CountAwayWinOnPenalties# + #CountAwayDefeatOnPenalties# + #CountAwayVoid# >
		<!--- AwayGamesWon --->
			<cfset AwayGamesWon = 
			  #CountAwayWinNormal# +  
			+ #CountAwayWinResultAwarded# +  
			+ #CountAwayWinOnPenalties# >
		<!--- AwayGamesDrawn --->
			<cfset AwayGamesDrawn = 
			  #CountAwayDrawNormal# 
			+ #CountAwayDrawResultAwarded# >
		<!--- AwayGamesLost --->
			<cfset AwayGamesLost = 
			  #CountAwayDefeatNormal# 
			+ #CountAwayDefeatResultAwarded#
			+ #CountAwayDefeatOnPenalties# >
		<!--- AwayGamesActuallyPlayedAndLost --->
			<cfset AwayGamesActuallyPlayedAndLost = 
			  #CountAwayDefeatNormal# 
			+ #CountAwayDefeatOnPenalties# >
		<!--- AwayGoalsFor ---> 
			<cfset AwayGoalsFor = IIF(SumAwayGoalsFor IS "",0,SumAwayGoalsFor) >
		<!--- AwayGoalsAgainst --->
			<cfset AwayGoalsAgainst = IIF(SumAwayGoalsAgainst IS "",0,SumAwayGoalsAgainst) >
		<!--- AwayPoints --->
			<cfset AwayPoints = (#AwayGamesWon# * #PointsForWin#) + (#AwayGamesDrawn# * #PointsForDraw#) + (#AwayGamesActuallyPlayedAndLost# * #PointsForLoss#) >
		<!--- AwayPointsAdjust --->
			<cfif IsNumeric(SumAwayPointsAdjust) AND SumAwayPointsAdjust IS NOT 0 >
				<cfset AwayPointsAdjust = #SumAwayPointsAdjust#>
			<cfelse>
				<cfset AwayPointsAdjust = 0>
			</cfif>
	<cfinclude template="../queries/ins_LeagueTable.cfm">
</cfoutput>
