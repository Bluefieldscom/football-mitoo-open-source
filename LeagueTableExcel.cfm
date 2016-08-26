<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfquery name="aaa33" datasource="#request.DSN#">
	SELECT 
	Rank, Name, 
	HomeGamesPlayed, HomeGamesWon, HomeGamesDrawn, HomeGamesLost, HomeGoalsFor, HomeGoalsAgainst, HomePoints, HomePointsAdjust,
	AwayGamesPlayed, AwayGamesWon, AwayGamesDrawn, AwayGamesLost, AwayGoalsFor, AwayGoalsAgainst, AwayPoints, AwayPointsAdjust
	 FROM leaguetable
	 WHERE DivisionID = #DefaultDivisionID# ORDER BY Rank
</cfquery>

<cfsetting enablecfoutputonly="yes">
<cfset TabChar = Chr(9)>
<cfset NewLine = Chr(13) & Chr(10)>
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=LeagueTable#DefaultDivisionID#.xls">
<cfoutput>#TabChar##TabChar#P#TabChar#W#TabChar#D#TabChar#L#TabChar#F#TabChar#A#TabChar#Pts#TabChar#Adj#TabChar#P#TabChar#W#TabChar#D#TabChar#L#TabChar#F#TabChar#A#TabChar#Pts#TabChar#Adj#TabChar##NewLine#</cfoutput>
<cfoutput query="aaa33" >#Rank##TabChar##Name##TabChar##HomeGamesPlayed##TabChar##HomeGamesWon##TabChar##HomeGamesDrawn##TabChar##HomeGamesLost##TabChar##HomeGoalsFor##TabChar##HomeGoalsAgainst##TabChar##HomePoints##TabChar##HomePointsAdjust##TabChar##AwayGamesPlayed##TabChar##AwayGamesWon##TabChar##AwayGamesDrawn##TabChar##AwayGamesLost##TabChar##AwayGoalsFor##TabChar##AwayGoalsAgainst##TabChar##AwayPoints##TabChar##AwayPointsAdjust##TabChar##NewLine#</cfoutput>
<cfoutput>Don't forget to right align columns C through to R#NewLine#</cfoutput>