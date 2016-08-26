<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfset DoubleHeader = "No" >
<cfset DHInfo = "xx">
<cfset MatchDate = #GetToken(form.datebox,2,",")# >
<!--- include a check of the fixture date only if it has been changed this time. Any clashes? --->

<cfif NOT StructKeyExists(session, "CurrentDate") >	
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.CurrentDate = Now() >
	</cflock>
</cfif>
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.CurrentDate = session.CurrentDate >
</cflock>
<cfif MatchDate IS NOT request.CurrentDate>
	<cfset DateChange = "Yes">
	<cfinclude template="InclCheckFixtureDate.cfm">
<cfelse>
	<cfset DateChange = "No">
</cfif>
<!--- include a check for a score entered or Win awarded for unknown "Winners of Match nnn" team --->
<cfinclude template="InclCheckNoScore.cfm">
<!--- include a check for invalid combination of KO Round and Competition type--->
<cfinclude template="InclCheckKORound.cfm">
<!--- include a check for invalid combination of Officials and marks --->
<cfinclude template="InclCheckOfficials.cfm">
<!--- include a check for invalid Sportsmanship marks --->
<cfinclude template="InclCheckSprtMarks.cfm">
<cfinclude template="InclCheckMatchOfficialsExpenses.cfm">
<cfif DateChange IS "Yes">
	<!--- see if there is a pitch booked already for the new date, if not copy the pitch availability from the old date --->
	<cfinclude template="queries/qry_QPitchAvailableForNewDate.cfm">
</cfif>
<cfinclude template="queries/upd_UpdtFixture.cfm">
<!--- changed by Julian August 25th 2010 at request of Sam --- always push to Goalrun  --->
<cfif RIGHT(request.dsn,4) GE 2008> <!--- applies to season 2008 onwards only --->
	<cfinclude template="InclPushResultToGR.cfm">
</cfif>
	
<!--- Change reference to actual Team Name rather than "Winners of Match" in KO competitions
 only if we are dealing with the latest round --->
<cfif Find( "MatchNumbers", QKnockOut.Notes )>
<!--- Is it a Scoring Home Win? --->
		<cfif IsNumeric(Form.HomeGoals) >
			<cfif IsNumeric(Form.AwayGoals) >
				<cfif HomeGoals GT AwayGoals >
					<cfset TypeOfWin = "Home" >
					<cfinclude template="InclSpecifyWinner.cfm">
				</cfif>
			</cfif>
		</cfif>
<!--- Is it an awarded Home Win? --->
		<cfif Form.RadioButton IS "Home Win">
			<cfset TypeOfWin = "Home" >
			<cfinclude template="InclSpecifyWinner.cfm">
		</cfif>
<!--- Is it a Home Win on penalties? --->
		<cfif Form.RadioButton IS "Home Win on penalties">
			<cfset TypeOfWin = "Home" >
			<cfinclude template="InclSpecifyWinner.cfm">
		</cfif>		
		
<!--- Is it a Scoring Away Win? --->
		<cfif IsNumeric(Form.HomeGoals) >
			<cfif IsNumeric(Form.AwayGoals) >
				<cfif HomeGoals LT AwayGoals >
					<cfset TypeOfWin = "Away" >
					<cfinclude template="InclSpecifyWinner.cfm">
				</cfif>
			</cfif>
		</cfif>
<!--- Is it an awarded Away Win? --->
		<cfif Form.RadioButton IS "Away Win">
			<cfset TypeOfWin = "Away" >
			<cfinclude template="InclSpecifyWinner.cfm">
		</cfif>
<!--- Is it an Away Win on penalties? --->
		<cfif Form.RadioButton IS "Away Win on penalties">
			<cfset TypeOfWin = "Away" >
			<cfinclude template="InclSpecifyWinner.cfm">
		</cfif>
</cfif>
