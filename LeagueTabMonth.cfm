<cfif NOT StructKeyExists(url, "FormDate")>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "MPeriod")>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT (url.MPeriod IS 1 OR url.MPeriod IS 2) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition
If it is, then we'll jump over to Knock Out History instead
--->
<cfsilent>
<CFPARAM name="KO" default="No">

<cfinclude template="queries/qry_QKnockOut.cfm">

<cfif Left(QKnockOut.Notes,2) IS "KO" >
<!--- Jumping here.... --->
	<CFLOCATION URL=
		"KOHist.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" 
				ADDTOKEN="NO">
</cfif>

<cfif     Left(QKnockOut.Notes,2) IS "P1" > 
	<cfset NoOfMeetings = 1>
<cfelseif Left(QKnockOut.Notes,2) IS "P3" >
	<cfset NoOfMeetings = 3>
<cfelseif Left(QKnockOut.Notes,2) IS "P4" >
	<cfset NoOfMeetings = 4>
<cfelse>
	<cfset NoOfMeetings = 2> <!--- "Normal" teams play each other twice a season, home and away --->
</cfif>

<!--- HideGoals will suppress Goals For, Goals Against and Goal Difference columns --->
<cfif Find( "HideGoals", QKnockOut.Notes )>
	<cfset HideGoals = "Yes">
<cfelse>
	<cfset HideGoals = "No">
</cfif>
<!--- HideDivision will suppress everything for this Division --->
<cfif Find( "HideDivision", QKnockOut.Notes )>
	<cfset HideDivision = "Yes">
<cfelse>
	<cfset HideDivision = "No">
</cfif>

<cfif Find( "SuppressTable", QKnockOut.Notes )>
	<cfset SuppressTable = "Yes">
<cfelse>
	<cfset SuppressTable = "No">
</cfif>

<cfinclude template="queries/qry_QGetPointsAdjust.cfm">

</cfsilent>

<cfif NoOfMeetings IS 1>
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other once only</span></td>
		</tr>
	</table>
<cfelseif NoOfMeetings IS 3>
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other three times</span></td>
		</tr>
	</table>
<cfelseif NoOfMeetings IS 4>
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other four times</span></td>
		</tr>
	</table>
<cfelse>

</cfif>

<cfif HideGoals IS "Yes">
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Goals For, Goals Against and Goal Difference columns have been hidden at the League's request</span></td>
		</tr>
	</table>
</cfif>

<cfif SuppressTable IS "Yes">
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">This has been suppressed at the League's request</span></td>
		</tr>
	</table>
	<CFABORT>
</cfif>
<cfif HideDivision IS "Yes"  >
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<cfoutput>
			<td align="CENTER"><span class="pix10">#QKnockOut.CompetitionDescription# League Table is not published</span></td>
			</cfoutput>
		</tr>
	</table>
	<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cfelse>
		<CFABORT>
	</cfif>
</cfif>

<cfset DateMinimum = "#DateFormat(url.FormDate, 'YYYY-MM-')#01">
<cfset DateMaximum = "#DateFormat(DateAdd('m', (url.MPeriod-1), DateMinimum), 'YYYY-MM-')##DaysInMonth(url.FormDate)#">
<!--- <cfoutput>DateMinimum is #DateMinimum# DateMaximum is #DateMaximum#</cfoutput> --->
<cfinclude template="queries/qry_QLeagueTableComponentsMonth.cfm">
<cfinclude template="queries/qry_QLeagueTableRowsMonth.cfm">
<cfinclude template="InclNewChunkPart2Month.cfm">

<!--- next, underneath the form table display various buttons....... 
Leading Goalscorers
Attendance Statistics
Expanded League Table
.... etc
--->
<table width="100%" border="0" cellpadding="0" cellspacing="5" >
	<tr>
		<td valign="top">
			<table>
				<cfset DivisionName = Getlong.CompetitionDescription>
				<cfinclude template="InclLeagueTabButtons.cfm">
			</table>
		</td>
		<td align="center">
			<cfinclude template="InclLeagueTabAdvertsTbl.cfm">
		</td>
	</tr>
</table>
