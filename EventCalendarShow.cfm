<cfparam name="URL.event_date" default="#CreateODBCDate(Now())#">
<cflock scope="session" timeout="10" type="readonly">
	<cfif StructKeyExists(session, "LeagueID")>
		<cfset request.LeagueID = session.LeagueID >
	<cfelse>
		<cfset request.LeagueID = 0 >
	</cfif>
</cflock>
<cfinclude template="queries/qry_QEvents.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Untitled</title>
	<meta name="robots" content="noindex,nofollow">
	<link rel="stylesheet" type="text/css" href="EventCalendarStyle.css">
</head>
<body bgcolor="#F5F5F5" >

	<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#F5F5F5">
		<tr>
			<cfoutput><td class="showHeader"><a href="EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#MONTH(URL.event_date)#&year_to_view=#YEAR(URL.event_date)#">Diary: #DateFormat(URL.event_date, 'dddd, dd mmmm yyyy')#</a></td></cfoutput>
		</tr>
		<cfoutput query="GetEvents">
			<tr><td>#EventText#</td></tr>
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
				<tr><td align="right" class="non-event"><a href="EventCalendarUpdDel.cfm?LeagueCode=#LeagueCode#&ID=#ID#" target="EventCalendar">Update/Delete</a></td></tr>
			</cfif>
		</cfoutput>
	</table>
</body>
</html>
