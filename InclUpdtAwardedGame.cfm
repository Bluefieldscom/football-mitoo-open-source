<!--- included by InclBatchUpdate2.cfm --->

<cfif ListFind("Silver,Skyblue",request.SecurityLevel)   >
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfinclude template="queries/upd_FixtResult.cfm">
<cfinclude template="queries/qry_QKnockOut_v2.cfm">

<!--- Change reference to actual Team Name rather than "Winners of Match" in KO competitions
 only if we are dealing with the latest round --->
<cfif Find( "MatchNumbers", QKnockOut.Notes )>
<!--- Is it a Scoring or Awarded Home Win? --->
		<cfif IsNumeric(Form.HomeGoals) >
			<cfif IsNumeric(Form.AwayGoals) >
				<cfif HomeGoals GT AwayGoals >
					<cfset TypeOfWin = "Home" >
					<cfinclude template="InclSpecifyWinner.cfm">
				</cfif>
			</cfif>
		</cfif>
		<cfif Form.HomeGoals IS "H" AND Form.AwayGoals IS "H" >
			<cfset TypeOfWin = "Home" >
			<cfinclude template="InclSpecifyWinner.cfm">
		</cfif>
		
<!--- Is it a Scoring or Awarded Away Win? --->
		<cfif IsNumeric(Form.HomeGoals) >
			<cfif IsNumeric(Form.AwayGoals) >
				<cfif HomeGoals LT AwayGoals >
					<cfset TypeOfWin = "Away" >
					<cfinclude template="InclSpecifyWinner.cfm">
				</cfif>
			</cfif>
		</cfif>
		<cfif Form.HomeGoals IS "A" AND Form.AwayGoals IS "A" >
			<cfset TypeOfWin = "Away" >
			<cfinclude template="InclSpecifyWinner.cfm">
		</cfif>
		
</cfif>
