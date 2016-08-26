<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Untitled</title>
	<meta name="robots" content="noindex,nofollow">
	<link rel="stylesheet" type="text/css" href="EventCalendarStyle.css">
</head>

<body bgcolor="#F5F5F5" >
<!--- First time in  --->
<cfif NOT StructKeyExists(form, "StateVector") >
	<cfform name="AddEvent" action="EventCalendarAdd.cfm">
	<cfoutput>
	<input type="Hidden" name="StateVector" value="1">
	<input name="LeagueCode" type="hidden" value="#URL.LeagueCode#">
	<input name="EventDate" type="hidden" value="#DateFormat(URL.Event_Date, 'YYYY-MM-DD')#">
	</cfoutput>
			<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#F5F5F5">
				<tr>
					<td colspan="2">
						<cfoutput>
							<span class="showheader"><a href="EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#MONTH(URL.event_date)#&year_to_view=#YEAR(URL.event_date)#">Diary: #DateFormat(URL.Event_Date, 'DDDD, DD MMMM YYYY')#</a></span>
						</cfoutput>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<cfoutput>
						<span class="textwarning">255 characters maximum</span>
						</cfoutput>
					</td>
				</tr>
		
		<tr align="center">
			<td colspan="2"><textarea name="EventText" rows="3" cols="100" class="textarea" ></textarea></td>
		</tr>
		<tr align="center">
			<td><input  type="submit" value="Add"></td>
			<td><input  type="reset" value="Clear"></td>
		</tr>
	</table>
	</cfform>
<!--- second time in, got something to insert? --->
<cfelse>
	<cfif TRIM(form.EventText) IS "">
		<!--- don't add a blank diary entry --->
	<cfelse>
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.LeagueID = session.LeagueID >
		</cflock>
		<cfset form.EventText = Left(form.EventText,255)>		
		<cfinclude template = "queries/ins_Event.cfm">
	</cfif>
	<!--- reload the eventcal --->
	<cfoutput>
		<script type="text/javascript">
			parent.parent.EventCalendar.location.href = 'EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#MONTH(form.EventDate)#&year_to_view=#YEAR(form.EventDate)#';
		</script>
	</cfoutput>
</cfif>

</body>
</html>
