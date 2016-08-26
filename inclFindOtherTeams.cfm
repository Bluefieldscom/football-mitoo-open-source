<!--- called by GatherTeamsUnderClub.cfm --->
<!--- create CF queries  --->
<cfset QCounty = QueryNew("County") >
<cfset QIgnoredToken = QueryNew("IgnoredToken") >
<cfset QToken = QueryNew("Token") >
<cfset QGatheredTeam = QueryNew("fmTeamID,LeagueInfoID,ClubName,LeagueName,Season,CountiesList") >

<!--- replace unusual characters with a space thereby breaking up hyphenated words into components --->
<cfset ThisClubName = ClubName >
<cfset ThisClubName = ReplaceList(ThisClubName,   "&,/,-,(,)", " , , , , "   ) > <!---  e.g. "Eastcote-Richings Park"  has hyphen replaced with space --->

<!--- this flag "ThereIsOnlyOneToken" tells us if the team name consists of just one word --->
<cfset ThereIsOnlyOneToken = "No" >
<!--- if there is only one token then consider it as useful, regardless of what it is, and search for it in other leagues ---> 
<cfif GetToken(ClubName,2) IS "">
	<cfset ThereIsOnlyOneToken = "Yes" >
	<cfset ThisClubName = ClubName >
</cfif>

<!--- search for up to 8 tokens in the name of the club e.g. "Eastcote Richings Park"  --->
<cfloop index="i" from="1" to="8" step="1" > <!--- I can't think of a club name with more than eight words --->
	<cfset ThisToken = GetToken(ThisClubName,i) > <!--- delimiter is a space --->
	<cfif ThisToken IS "">
		<cfset iLast = i >
		<cfexit> <!--- finished  ----------------------------------------------------------------------------------------------- WARNING at bottom --->
	<cfelseif Len(ThisToken) LT 3 AND ThereIsOnlyOneToken IS "No" >
				<cfset temp = QueryAddRow(QIgnoredToken) >
				<cfset temp = QuerySetCell(QIgnoredToken, "IgnoredToken", ThisToken ) >
	<cfelseif ListFindNoCase(ExemptTokenList, ThisToken) AND ThereIsOnlyOneToken IS "No" >
				<cfset temp = QueryAddRow(QIgnoredToken) >
				<cfset temp = QuerySetCell(QIgnoredToken, "IgnoredToken", ThisToken ) >
	<cfelse>
				<cfset GoodTokenCount = GoodTokenCount + 1 >
				<cfset temp = QueryAddRow(QToken) >
				<cfset temp = QuerySetCell(QToken, "Token", ThisToken ) >
	
		<!--- search for this token in the name of any team 
		across all leagues for the several seasons 
		ignoring "Winners of...." and GUEST teams e.g. search for "Eastcote" --->
		
		
		
		
		<cfloop index="YYYY" from="2004" to="2008" step="1">
		
		
		
		
		
		
		
		
			<cfinclude template="queries/qry_QSearchTeamYYYY.cfm">
			<cfoutput query="QSearchTeam">
				<cfset temp = QueryAddRow(QGatheredTeam) >
				<cfset temp = QuerySetCell(QGatheredTeam, "fmTeamID", fmTeamID ) >
				<cfset temp = QuerySetCell(QGatheredTeam, "LeagueInfoID", LeagueInfoID ) >
				<cfset temp = QuerySetCell(QGatheredTeam, "ClubName", ClubName ) >
				<cfset temp = QuerySetCell(QGatheredTeam, "LeagueName", LeagueName ) >
				<cfset temp = QuerySetCell(QGatheredTeam, "Season", Season ) >
				<cfset temp = QuerySetCell(QGatheredTeam, "CountiesList", CountiesList ) >
			</cfoutput>
		</cfloop>
	</cfif>
</cfloop>
<!--- WARNING - do not code any more after this line because this .cfm is included and the <cfexit> takes control to the calling program as soon as it is executed ---->
