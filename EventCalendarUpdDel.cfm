<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

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
	<cfinclude template = "queries/qry_GetEvent.cfm">
	<cfform action="EventCalendarUpdDel.cfm" name="UpdDelEvent" enablecab="no">
			<cfoutput>
			<input type="Hidden" name="StateVector" value="1">
			<input name="LeagueCode" type="hidden" value="#URL.LeagueCode#">
			<input name="ID" type="hidden" value="#GetEvent.ID#">
			<input name="EventDate" type="hidden" value="#DateFormat(GetEvent.EventDate, 'YYYY-MM-DD')#">
			</cfoutput>
			<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#F5F5F5">
				<tr>
					<td colspan="2">
						<cfoutput>
						<span class="showheader"><a href="EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#MONTH(GetEvent.EventDate)#&year_to_view=#YEAR(GetEvent.EventDate)#">Diary: #DateFormat(GetEvent.EventDate, 'DDDD, DD MMMM YYYY')#</a></span>
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

				<tr>
					<td colspan="2">
						<cfoutput>
						<textarea name="EventText" cols="100" rows="3" class="textarea" >#GetEvent.EventText#</textarea>
						</cfoutput>
					</td>
				</tr>
				<tr align="center">
					<td><input name="Action" type="submit" value="Update"></td>
					<td><input name="Action" type="submit" value="Delete"></td>
				</tr>
			</table>
	</cfform>
<!--- second time in, got something to update/delete --->
<cfelse>

	<cfif form.Action IS "Update">
		<cfif TRIM(form.EventText) IS "">
			<!--- delete a blank diary entry --->
			<cfinclude template = "queries/del_Event.cfm">
		<cfelse>
			<cfset form.EventText = Left(form.EventText,255)>		
			<cfinclude template = "queries/upd_Event.cfm">
		</cfif>
	<cfelseif form.Action IS "Delete">
		<cfinclude template = "queries/del_Event.cfm">
		<cfoutput>
			<script type="text/javascript">
				parent.parent.EventCalendar.location.href = 'EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#MONTH(form.EventDate)#&year_to_view=#YEAR(form.EventDate)#';
			</script>
		</cfoutput>
	<cfelse>
		unexpected form.Action - aborting
		<cfabort>
	</cfif>
	<cfoutput>
		<script type="text/javascript">
			parent.parent.EventCalendar.location.href = 'EventCalendar.cfm?LeagueCode=#LeagueCode#&month_to_view=#MONTH(form.EventDate)#&year_to_view=#YEAR(form.EventDate)#';
		</script>
	</cfoutput>
</cfif>
</body>
</html>
