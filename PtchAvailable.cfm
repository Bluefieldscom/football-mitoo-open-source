<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.SeasonStartDate = session.SeasonStartDate >
	<cfset request.SeasonEndDate = session.SeasonEndDate >
</cflock>

<cfsetting showdebugoutput="no">

<cfparam name="variables.todays_date" default="#CreateODBCDate(Now())#"> 
<!---
<cfparam name="URL.month_to_view" default="#IIF(   ( request.SeasonStartDate LE Now() ) AND ( Now() LE request.SeasonEndDate) , MONTH(CreateODBCDate(Now())), MONTH(CreateODBCDate(request.SeasonStartDate)))#">
<cfparam name="URL.year_to_view" default="#IIF(   ( request.SeasonStartDate LE Now() ) AND ( Now() LE request.SeasonEndDate) , YEAR(CreateODBCDate(Now())), YEAR(CreateODBCDate(request.SeasonStartDate)))#">
--->
<cfif StructKeyExists(url, "TID")>
	<cfset ThisTeamID = url.TID >
</cfif>
<cfif StructKeyExists(url, "OID")>
	<cfset ThisOrdinalID = url.OID >
</cfif>
<cfif StructKeyExists(url, "year_to_view")>
	<cfif url.year_to_view IS "">
		<cfif (request.SeasonStartDate LE Now()) AND (Now() LE request.SeasonEndDate) >
			<cfset ThisYear = YEAR(CreateODBCDate(Now()))>
		<cfelse>
			<cfset ThisYear = YEAR(CreateODBCDate(request.SeasonStartDate))>
		</cfif>
	<cfelse>
		<cfset ThisYear = url.year_to_view >
	</cfif>
<cfelse>
	<cfif (request.SeasonStartDate LE Now()) AND (Now() LE request.SeasonEndDate) >
		<cfset ThisYear = YEAR(CreateODBCDate(Now()))>
	<cfelse>
		<cfset ThisYear = YEAR(CreateODBCDate(request.SeasonStartDate))>
	</cfif>
</cfif>
<cfif StructKeyExists(url, "month_to_view")>
	<cfif url.month_to_view IS "">
		<cfif (request.SeasonStartDate LE Now()) AND (Now() LE request.SeasonEndDate) >
			<cfset ThisMonth = MONTH(CreateODBCDate(Now()))>
		<cfelse>
			<cfset ThisMonth = MONTH(CreateODBCDate(request.SeasonStartDate))>
		</cfif>
	<cfelse>
		<cfset ThisMonth = url.month_to_view >
	</cfif>
<cfelse>
		<cfif (request.SeasonStartDate LE Now()) AND (Now() LE request.SeasonEndDate) >
			<cfset ThisMonth = MONTH(CreateODBCDate(Now()))>
		<cfelse>
			<cfset ThisMonth = MONTH(CreateODBCDate(request.SeasonStartDate))>
		</cfif>
</cfif>
 
<cfinclude template = "queries/qry_TeamDetails.cfm">

<cfif #TRIM(QTeamDetails.OrdinalName)# IS "">
	<cfset ThisTeamsName = "#QTeamDetails.TeamName# <em>(First Team)</em>" >
<cfelse>
	<cfset ThisTeamsName = "#QTeamDetails.TeamName# #QTeamDetails.OrdinalName#" >
</cfif>

<cfset ThisVenueID = QTeamDetails.VenueID >
<cfset ThisPitchNoID = QTeamDetails.PitchNoID >

<cfinclude template = "queries/qry_PtchBookedAllOK.cfm">

<cfset OKDayList = ValueList(PtchBookedAllOK.s_day)>
<cfset OKPitchavailableIDList = ValueList(PtchBookedAllOK.PitchavailableID)>
<cfset OKPitchStatusIDList = ValueList(PtchBookedAllOK.PitchStatusID)>
<cfset OKPitchNoIDList = ValueList(PtchBookedAllOK.PNID)>
<cfset OKVenueIDList = ValueList(PtchBookedAllOK.VID)>
<cfset OKVenueNameList = QuotedValueList(PtchBookedAllOK.VenueName)>
<cfset OKPitchNumberList = ValueList(PtchBookedAllOK.PitchNumber)>

<!---
<cfif PtchBookedCount IS 0>
	<cfset PtchBookedList = ListAppend(PtchBookedList, 0)>
	<cfset PtchBookedIDList = "">
	<cfset PitchStatusIDList = "">
	<cfset PitchNoIDList = "">
	<cfset VenueIDList = "">
</cfif>
--->

<cfinclude template = "queries/qry_PtchBookedNOTAllOK.cfm">

<cfset BADDayList = ValueList(PtchBookedNOTAllOK.s_day)>
<cfset BADPitchavailableIDList = ValueList(PtchBookedNOTAllOK.PitchavailableID)>
<cfset BADPitchStatusIDList = ValueList(PtchBookedNOTAllOK.PitchStatusID)>
<cfset BADPitchNoIDList = ValueList(PtchBookedNOTAllOK.PNID)>
<cfset BADVenueIDList = ValueList(PtchBookedNOTAllOK.VID)>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Untitled</title>
	<meta name="robots" content="noindex,nofollow">
	<link rel="stylesheet" type="text/css" href="PtchAvailableStyle.css">
</head>

<body bgcolor="lavender" >

<cfsilent>
<cfscript>
	int_Mnth = ThisMonth;
	str_Mnth = MonthAsString(int_Mnth);
	int_Today = Day(variables.todays_date);
	int_Yr = ThisYear;
	int_LastMnth = ThisMonth-1;
	int_LastYr = int_Yr;
	int_NextYr = int_Yr;
	if (int_LastMnth IS 0) {
		int_LastMnth = 12;
		int_LastYr = (int_Yr-1);
	}
	int_NextMnth = ThisMonth+1;
	if (int_NextMnth IS 13) {
		int_NextMnth = 1;
		int_NextYr = (int_Yr+1);
	}
	firstOn = DayofWeek('#int_Yr#-#int_Mnth#-01');
	totaldays = DaysInMonth('#int_Yr#-#int_Mnth#-01');
	offSet = firstOn-1;
	daycount = 1;
</cfscript>
</cfsilent>

<table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="lavender" >
	<tr class="toprow">
	<!--- this is the top row with the left and right arrows and the month name in between --->
		<!--- Left Arrow Image --->
		<cfif int_LastYr GT YEAR(request.SeasonStartDate) >
			<td align="right">
				<cfoutput>
					<a href="PtchAvailable.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_LastMnth#&year_to_view=#int_LastYr#&TID=#ThisTeamID#&OID=#ThisOrdinalID#"><img src="click_left_on.png" border="0" align="absmiddle" onMouseOver="this.src='click_left_hover.png';" onMouseOut="this.src='click_left_on.png';"></a>
				</cfoutput>
			</td>
		<cfelseif int_LastMnth GT MONTH(request.SeasonStartDate)-1 >
			<td align="right">
				<cfoutput>
					<a href="PtchAvailable.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_LastMnth#&year_to_view=#int_LastYr#&TID=#ThisTeamID#&OID=#ThisOrdinalID#"><img src="click_left_on.png" border="0" align="absmiddle" onMouseOver="this.src='click_left_hover.png';" onMouseOut="this.src='click_left_on.png';"></a>
				</cfoutput>
			</td>
		<cfelse>
			<td align="right"><img src="click_left_off.png" border="0" ></td>
		</cfif>
		<!--- e.g. Availability <br />May 2005 --->
		<td colspan="5" align="center" bgcolor="Thistle">
			<cfoutput><span class="showheader1">#ThisTeamsName#</span><span class="showheader2"><br />Pitch Availability #str_Mnth# #int_Yr#</span></cfoutput>
		</td>
		<!--- Right Arrow Image --->
		<cfif int_NextYr LT YEAR(request.SeasonEndDate) >
			<td align="left">
				<cfoutput>
					<a href="PtchAvailable.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_NextMnth#&year_to_view=#int_NextYr#&TID=#ThisTeamID#&OID=#ThisOrdinalID#"><img src="click_right_on.png" border="0" align="absmiddle" onMouseOver="this.src='click_right_hover.png';" onMouseOut="this.src='click_right_on.png';"></a>
				</cfoutput>
			</td>
		<cfelseif int_NextMnth LT MONTH(request.SeasonEndDate)+1 >
			<td align="left">
				<cfoutput>
					<a href="PtchAvailable.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_NextMnth#&year_to_view=#int_NextYr#&TID=#ThisTeamID#&OID=#ThisOrdinalID#"><img src="click_right_on.png" border="0" align="absmiddle" onMouseOver="this.src='click_right_hover.png';" onMouseOut="this.src='click_right_on.png';"></a>
				</cfoutput>
			</td>
		<cfelse>
			<td align="left"><img src="click_right_off.png" border="0" ></td>
		</cfif>
	</tr>
	<!--- this is the row with seven column headings showing the day names --->
	<tr align="center">
		<td width="15%">Sun</td>
		<td width="14%">Mon</td>
		<td width="14%">Tue</td>
		<td width="14%">Wed</td>
		<td width="14%">Thu</td>
		<td width="14%">Fri</td>
		<td width="15%">Sat</td>
	</tr>

	<!--- this is the first row of dates --->				
		<tr align="center">
			<cfset daycount=1>
			<!--- days belonging to the end of the previous month will show as blank --->
			<cfloop index="ColumnNumber" from="1" to="#offSet#">
				<td>&nbsp;</td>
			</cfloop>
			<cfloop index="ColumnNumber" from="#offSet+1#" to="7">
				<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
					<cfinclude template="InclPtchAvailableLoop2.cfm">
				</cfif>
				<cfset daycount = daycount + 1 >
			</cfloop>
		</tr>
		

	<cfloop index="RowNumber" from="2" to="6">
		<cfif daycount GT totaldays >
			<cfbreak>
		</cfif>
	
	<!--- these are subsequent full rows of dates --->
		<tr align="center">
			<cfloop index="ColumnNumber" from="1" to="7">
				<cfif daycount GT totaldays >
					<cfloop index="ColumnNumber" from="#ColumnNumber#" to="7">
						<td>&nbsp;</td>
					</cfloop>
					<cfbreak>
				</cfif>
				<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
					<cfinclude template="InclPtchAvailableLoop2.cfm">
				<cfelse>
				</cfif>
				<cfset daycount = daycount + 1 >
			</cfloop>
		</tr>
	</cfloop>
</table>



