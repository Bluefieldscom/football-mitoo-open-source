<!--- included by InclUpdtFixture.cfm --->

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<link href="fmstyle.css" rel="stylesheet" type="text/css">
	<!--- Check to see if the current fixture involves an unknown "Winners of Match nnn" team.
	 The user must not be allowed to enter a score in this case.
	  Also check that both Home and Away boxes have a numeric value--->
<cfinclude template="queries/qry_QHomevAway.cfm">
<cfoutput query="QHomevAway">

	<CFSWITCH expression="#FORM.Operation#">
		<CFCASE VALUE="Update">
		
			<cfif HomeNoScore IS "NoScore" OR AwayNoScore IS "NoScore"> <!--- team is "Winners of...." --->
				<cfif NOT (#Form.HomeGoals# IS "" AND #Form.AwayGoals# IS "") >
					<span class="pix24boldred">You are not allowed to enter a score for<BR>
					#HomeTeam# #HomeOrdinal# v #AwayTeam# #AwayOrdinal# ...<BR><BR>
					Press the Back button on your browser.....</span>
					<CFABORT>
				</cfif> 
			
				<cfif FORM.RadioButton IS NOT 'Result' AND FORM.RadioButton IS NOT 'Postponed' >
					<span class="pix24boldred">You are not allowed to enter #FORM.RadioButton# for<BR>
					#HomeTeam# #HomeOrdinal# v #AwayTeam# #AwayOrdinal# ...<BR><BR>
					Press the Back button on your browser.....</span>
					<CFABORT>
				</cfif> 


				<cfif StructKeyExists(form, "HomePointsAdjust") AND StructKeyExists(form, "AwayPointsAdjust") >
					<cfif FORM.HomePointsAdjust IS '' OR FORM.HomePointsAdjust IS 0 >
					<cfelse>
						<span class="pix24boldred">#HomeTeam# #HomeOrdinal# v #AwayTeam# #AwayOrdinal# ...<BR><BR>
						Points Adjustment: Home Team #FORM.HomePointsAdjust#&nbsp;&nbsp;&nbsp;This is not allowed<BR><BR>
						Press the Back button on your browser.....</span>
						<CFABORT>
					</cfif> 
	
					<cfif FORM.AwayPointsAdjust IS '' OR FORM.AwayPointsAdjust IS 0 >
					<cfelse>
						<span class="pix24boldred">#HomeTeam# #HomeOrdinal# v #AwayTeam# #AwayOrdinal# ...<BR><BR>
						Points Adjustment: Away Team #FORM.AwayPointsAdjust#&nbsp;&nbsp;&nbsp;This is not allowed<BR><BR>
						Press the Back button on your browser.....</span>
						<CFABORT>
					</cfif> 
				</cfif>				
			<cfelse> <!--- team is not "Winners of...." and one of the scores is missing--->
				<cfif #Form.HomeGoals# IS "" AND #Form.AwayGoals# IS NOT "" >	
					<span class="pix24boldred">No score entered for #HomeTeam# #HomeOrdinal# ...<BR><BR>
						Press the Back button on your browser.....</span>
					<CFABORT>
				</cfif> 
				<cfif #Form.HomeGoals# IS NOT "" AND #Form.AwayGoals# IS "" >	
					<span class="pix24boldred">No score entered for #AwayTeam# #AwayOrdinal# ...<BR><BR>
					Press the Back button on your browser.....</span>
					<CFABORT>
				</cfif> 
			</cfif>
		</CFCASE>
		

		<CFDEFAULTCASE>
			DefaultCase in InclCheckNoScore.cfm
			<CFABORT>
		</CFDEFAULTCASE>

	</cfswitch>
</cfoutput>