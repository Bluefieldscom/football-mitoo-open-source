<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif StructKeyExists(url, "RefereeID") AND StructKeyExists(url, "LeagueCode") >
	<!---  for yellow security level check that the url.ID (referee's id) parameter and leaguecode parametere have not been tampered with.  --->
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.YellowKey = session.YellowKey  >
		</cflock>
		<cfif url.RefereeID IS "#Reverse(GetToken(Reverse(request.YellowKey),1,'|'))#" AND url.LeagueCode IS "#GetToken(request.YellowKey,1,'|')#">
			<!--- all OK --->
		<cfelse>
			<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
			<cfabort>
		</cfif>
	<cfelseif StructKeyExists(form, "RefereeID") AND StructKeyExists(form, "LeagueCode") >
	<!---  for yellow security level check that the url.ID (referee's id) parameter and leaguecode parametere have not been tampered with.  --->
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.YellowKey = session.YellowKey  >
		</cflock>
		<cfif form.RefereeID IS "#Reverse(GetToken(Reverse(request.YellowKey),1,'|'))#" AND form.LeagueCode IS "#GetToken(request.YellowKey,1,'|')#">
			<!--- all OK --->
		<cfelse>
			<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
			<cfabort>
		</cfif>
	</cfif>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Untitled</title>
	<meta name="robots" content="noindex,nofollow">
	<link rel="stylesheet" type="text/css" href="RefAvailableStyle.css">
</head>

<body bgcolor="#FEFFD2" >
<!--- First time in  --->
<cfif NOT StructKeyExists(form, "StateVector") >
	<cfform name="AddAvailability" action="RefAvailableAdd.cfm">
	<cfoutput>
	<input type="Hidden" name="StateVector" value="1">
	<input name="LeagueCode" type="hidden" value="#URL.LeagueCode#">
	<input name="MatchDate" type="hidden" value="#DateFormat(URL.Match_Date, 'YYYY-MM-DD')#">
	<input name="RefereeID" type="hidden" value="#URL.RefereeID#">

	<table width="100%" cellpadding="2" cellspacing="2" bgcolor="FEFFD2">
		<tr align="center">
			<td colspan="2" valign="top">
			<span class="showheader1"><a href="RefAvailable.cfm?LeagueCode=#LeagueCode#&month_to_view=#MONTH(URL.Match_date)#&year_to_view=#YEAR(URL.Match_date)#&RefereeID=#RefereeID#">Availability</a><br />#DateFormat(URL.Match_Date, 'DDDD, DD MMMM YYYY')#</span>
			</td>
			<td colspan="1" rowspan="3" valign="middle" bgcolor="silver"><input name="Action" type="submit" value="Delete"></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<textarea name="Notes" rows="1" cols="30" class="textarea" ></textarea><br /><span class="textwarning">Notes (255 characters maximum)</span>
			</td>
		</tr>
		<tr align="center">
			<td valign="middle" bgcolor="LightGreen"><input name="Action"  type="submit" value="Yes"></td>
			<td valign="middle" bgcolor="Pink"><input name="Action" type="submit" value="No"></td>
		</tr>
	</table>
	</cfoutput>
	</cfform>
<!--- second time in, got something to insert? --->
<cfelse>
	<cfif form.Action IS "Yes"> <!--- referee is definitely available --->
		<cfinclude template = "queries/ins_RefAvailable.cfm">
	<cfelseif form.Action IS "No"> <!--- referee is definitely unavailable --->
		<cfinclude template = "queries/ins_RefAvailable.cfm">
	<cfelse>
	<!--- nothing to insert if Delete button clicked --->
				<!--- do nothing --->
			<cfoutput>
				<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
				<span class="pix13boldred">Nothing changed. Please click on the Back button of your browser.</span>
			</cfoutput>
			<cfabort>

	</cfif>
	<!--- reload the calendar --->
	<cfoutput>
		<script type="text/javascript">
			parent.parent.RefAvailable.location.href = 'RefAvailable.cfm?LeagueCode=#LeagueCode#&month_to_view=#MONTH(form.MatchDate)#&year_to_view=#YEAR(form.MatchDate)#&RefereeID=#RefereeID#';
		</script>
	</cfoutput>
</cfif>

</body>
</html>
