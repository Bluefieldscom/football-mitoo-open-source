<cflock scope="session" timeout="10" type="readonly">
	<cfset request.SeasonStartDate = session.SeasonStartDate >
	<cfset request.SeasonEndDate = session.SeasonEndDate >
	<cfif StructKeyExists(session, "LeagueID")>
		<cfset request.LeagueID = session.LeagueID >
	<cfelse>
		<cfset request.LeagueID = 0 >
	</cfif>
</cflock>
<cfsetting showdebugoutput="no">

<cfparam name="variables.todays_date" default="#CreateODBCDate(Now())#"> 
<cfparam name="URL.month_to_view" default="#IIF(   ( request.SeasonStartDate LE Now() ) AND ( Now() LE request.SeasonEndDate) , MONTH(CreateODBCDate(Now())), MONTH(CreateODBCDate(request.SeasonStartDate)))#">
<cfparam name="URL.year_to_view" default="#IIF(   ( request.SeasonStartDate LE Now() ) AND ( Now() LE request.SeasonEndDate) , YEAR(CreateODBCDate(Now())), YEAR(CreateODBCDate(request.SeasonStartDate)))#">

<cfinclude template = "queries/qry_MonthsEvents.cfm">
<cfset EventList = ValueList(MonthsEvents.s_day)>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Untitled</title>
	<meta name="robots" content="noindex,nofollow">
	<link rel="stylesheet" type="text/css" href="eventcalendarstyle.css">
</head>

<body bgcolor="#EEEEEE" >

<cfsilent>
<cfscript>
	int_Mnth = URL.month_to_view;
	str_Mnth = MonthAsString(int_Mnth);
	int_Today = Day(variables.todays_date);
	int_Yr = URL.year_to_view;
	int_LastMnth = URL.month_to_view-1;
	int_LastYr = int_Yr;
	int_NextYr = int_Yr;
	if (int_LastMnth IS 0) {
		int_LastMnth = 12;
		int_LastYr = (int_Yr-1);
	}
	int_NextMnth = URL.month_to_view+1;
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

<table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EEEEEE" >
	<tr class="toprow">
	<!--- this is the top row with the left and right arrows and the month name in between --->
		<cfif int_LastYr GT YEAR(request.SeasonStartDate) >
			<td align="right">
				<cfoutput>
					<a href="EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_LastMnth#&year_to_view=#int_LastYr#"><img src="click_left_on.png" border="0" align="absmiddle" onmouseover="this.src='click_left_hover.png';" onMouseOut="this.src='click_left_on.png';"></a>
				</cfoutput>
			</td>
		<cfelseif int_LastMnth GT MONTH(request.SeasonStartDate)-1 >
			<td align="right">
				<cfoutput>
					<a href="EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_LastMnth#&year_to_view=#int_LastYr#"><img src="click_left_on.png" border="0" align="absmiddle" onmouseover="this.src='click_left_hover.png';" onMouseOut="this.src='click_left_on.png';"></a>
				</cfoutput>
			</td>
		<cfelse>
			<td align="right"><img src="click_left_off.png" border="0" ></td>
		</cfif>
		  
		<td colspan="5" align="center">
			<cfoutput><span class="showheader">Diary: #str_Mnth# #int_Yr#</span></cfoutput>
		</td>
		
		<cfif int_NextYr LT YEAR(request.SeasonEndDate) >
			<td align="left">
				<cfoutput>
					<a href="EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_NextMnth#&year_to_view=#int_NextYr#"><img src="click_right_on.png" border="0" align="absmiddle" onmouseover="this.src='click_right_hover.png';" onMouseOut="this.src='click_right_on.png';"></a>
				</cfoutput>
			</td>
		<cfelseif int_NextMnth LT MONTH(request.SeasonEndDate)+1 >
			<td align="left">
				<cfoutput>
					<a href="EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#int_NextMnth#&year_to_view=#int_NextYr#"><img src="click_right_on.png" border="0" align="absmiddle" onmouseover="this.src='click_right_hover.png';" onMouseOut="this.src='click_right_on.png';"></a>
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
				<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
					<cfinclude template="InclEventLoop2.cfm">
				<cfelse>
					<cfinclude template="InclEventLoop1.cfm">
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
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
					<cfinclude template="InclEventLoop2.cfm">
				<cfelse>
					<cfinclude template="InclEventLoop1.cfm">
				</cfif>
				<cfset daycount = daycount + 1 >
			</cfloop>
		</tr>
	</cfloop>
</table>
</body>
</html>

