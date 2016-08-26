<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link href="fmstyle.css" rel="stylesheet" type="text/css">

<cfif NOT StructKeyExists(url, "HA") OR NOT StructKeyExists(url, "FID")>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<cfif 	StructKeyExists(session, "DropDownTeamID") AND
		StructKeyExists(session, "ChosenConstitsAllSides") >
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.DropDownTeamID = session.DropDownTeamID >
			<cfset request.ChosenConstitsAllSides = session.ChosenConstitsAllSides >
		</cflock>
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- set teamID for query --->
<cfset TeamID = request.DropDownTeamID>
<cfinclude template = "queries/qry_QTeamSheetFixtureInfo.cfm">
<cfif QTeamSheetFixtureInfo.RecordCount IS 1>
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- check that the URL has not been tampered with  --->

<cfif     url.HA IS "H" AND ListFind( #request.ChosenConstitsAllSides#,QTeamSheetFixtureInfo.HomeID ) GT "0" >
	<cfset TitleText = "Home to #QTeamSheetFixtureInfo.teamName2# #TRIM(QTeamSheetFixtureInfo.ordinalName2)#">
	<cfif IsNumeric(QTeamSheetFixtureInfo.HomeGoals)><cfset TotalGoalsScored = QTeamSheetFixtureInfo.HomeGoals><cfelse><cfset TotalGoalsScored = 0 ></cfif>
<cfelseif url.HA IS "A" AND ListFind( #request.ChosenConstitsAllSides#,QTeamSheetFixtureInfo.AwayID ) GT "0" >
	<cfset TitleText = "Away to #QTeamSheetFixtureInfo.teamName1# #TRIM(QTeamSheetFixtureInfo.ordinalName1)#">
	<cfif IsNumeric(QTeamSheetFixtureInfo.AwayGoals)><cfset TotalGoalsScored = QTeamSheetFixtureInfo.AwayGoals><cfelse><cfset TotalGoalsScored = 0 ></cfif>
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<title><cfoutput query="QTeamSheetFixtureInfo">#TitleText#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<cfinclude template="InclLeagueInfo.cfm">
<!--- This query is used to populate the top half of the screen --->
<cfinclude template = "queries/qry_QPlayersWhoPlayed.cfm">
<cfset PlayerIDList=ValueList(QPlayersWhoPlayed.PlayerID)>
<cfset PlayerCount = QPlayersWhoPlayed.RecordCount>
<table border="1" align="center" cellpadding="5" cellspacing="0">

	<tr>
		<td colspan="3" align="center"><cfoutput query="QTeamSheetFixtureInfo"><span class="pix10">#DateFormat(FixtureDate, 'DDDD, DD MMMM YYYY')#</span></cfoutput></td>
	</tr>
	<tr>
		<td colspan="3" align="center"><cfoutput query="QTeamSheetFixtureInfo"><span class="pix10">#DivisionName# #koroundname#</span></cfoutput></td>
	</tr>
	<tr>
	<cfif url.HA IS "H">
		<cfset HClass="pix13bold">
		<cfset AClass="pix13">
	<cfelse>
		<cfset HClass="pix13">
		<cfset AClass="pix13bold">
	</cfif>
	<tr>
		<td colspan="3" align="center"><cfoutput query="QTeamSheetFixtureInfo"><span class=#HClass#>#teamName1# #TRIM(ordinalName2)# &nbsp; #HomeGoals# &nbsp;</span><span class="Pix13"> v </span><span class=#AClass#>&nbsp; #AwayGoals# &nbsp; #teamName2# #TRIM(ordinalName2)#</span></cfoutput></td>
	</tr>
	<tr>
		<td colspan="3" align="center"><span class="pix13"><cfoutput query="QTeamSheetFixtureInfo">#PlayerCount# appearances for <cfif url.HA IS "H">#teamName1# #TRIM(ordinalName1)#<cfelse>#teamName2# #TRIM(ordinalName2)#</cfif></cfoutput></span></td>
	</tr>
	<tr>
		<td align="center"><span class="pix10">RegNo</span></td>
		<td><span class="pix10">Name</span></td>
		<td align="center"><span class="pix10">Goals</span></td>
	</tr>
	
	<cfset GoalsTally = 0 >
	<cfoutput query="QPlayersWhoPlayed">
	<tr>
	<cfif Card IS 0 >
		<cfset ThisBGColor = "white">
	<cfelseif Card IS 1 >
		<cfset ThisBGColor = "yellow">
	<cfelseif Card IS 3 >
		<cfset ThisBGColor = "red">
	<cfelseif Card IS 4 >
		<cfset ThisBGColor = "orange">
	</cfif>
		<td align="right" bgcolor="#ThisBGColor#"><span class="pix13"><cfif PlayerRegNo IS 0>&nbsp;<cfelse>#PlayerRegNo#</cfif></span></td>
		<td><span class="pix13"><cfif PlayerRegNo IS 0>Own Goal<cfelse>#PlayerForename# #PlayerSurname#</cfif></span></td>
		<td align="center"><span class="pix13bold"><cfif GoalsScored IS 0>&nbsp;<cfelse>#GoalsScored#</cfif></span></td>
		<cfset GoalsTally = GoalsTally + GoalsScored >
	</tr>
	
	</cfoutput>
	
	<tr>
		<td height="50" colspan="3" align="center"><span class="pix13">Referee marks awarded = <cfoutput query="QTeamSheetFixtureInfo"><cfif url.HA IS "H">#RefereeMarksH#<cfelse>#RefereeMarksA#</cfif></cfoutput></span></td>
	</tr>
	<cfif TotalGoalsScored IS NOT GoalsTally>
		<tr>
			<td height="50" colspan="3" align="center"><span class="pix18boldred">Sum of 'Goals' column does not agree with the score!</span></td>
		</tr>
	</cfif>
</table>
to do list........<br />
yyy warn if the referee marks are missing<br />display any Notes




				
</body>
</html>
