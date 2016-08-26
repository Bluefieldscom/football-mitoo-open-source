<!--- included by InclUpdtFixture.cfm and InclUpdtGoals.cfm and  InclUpdtAwardedGame.cfm --->

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- First of all, we should only be here if the string "MatchNumbers" is found in division.notes --->

<!--- Look at the Fixture just updated. We are going to get the NextMatchNoID from the constitution record
of the team that's won. This will be either the Home or Away team. 
Remember: a fixture consists of 2 constitution records , home and away --->
<cfinclude template="queries/qry_QSW1.cfm">
<cfif QSW1.RecordCount IS "1"> <!--- Should always find just the one record --->
	<cfif VAL(LEFT(QSW1.ThisMatchInfo,3)) IS QSW1.MatchNumber >
		 <!--- 	Check that the 2 matchnos agree before going further with all the updates etc. 
		 If true, we are dealing with the "latest" match for Arsenal so we can do the major update --->
		<cfinclude template="queries/qry_QSW00.cfm">
		<cfif QSW00.RecordCount IS "1">  <!--- Should always find just one record --->
			<CFSWITCH expression="#RIGHT(QSW1.NextMatchInfo,4)#">
				<CFCASE VALUE="Home">
					<cfinclude template="queries/upd_QSW2Home.cfm">
					<!--- The way it's coded, "WHERE HomeID = #QSW00.ID#"
					will possibly update more than one record
					it will, in fact, change all occurrences of "Winners of Match qqq" at home to "Arsenal" at home --->
				</CFCASE>
				<CFCASE VALUE="Away">
					<cfinclude template="queries/upd_QSW2Away.cfm">
				</CFCASE>
				<CFDEFAULTCASE> <!--- Should never get here! ABORT --->
				Error in InclSpecifyWinner.cfm - CFDEFAULTCASE <cfoutput>#QSW00.RecordCount#</cfoutput> records ABORTING <BR>
				<CFABORT> 
				</CFDEFAULTCASE>
			</CFSWITCH>
	
			<!--- OK so far, but now we need to do a couple of things...
			In our example, "Arsenal" replaces "Winners of Match ppp", so the "Arsenal" constitution record
			will have to inherit the 'This' & 'Next' of the "Winners of Match ppp" constitution record and
			the "Winners of Match ppp" constitution record itself will be DELETED	--->
			<cfinclude template="queries/upd_QUpdtConstit.cfm">
			<cfinclude template="queries/del_DltConstit.cfm">
			<!--- Let's also make 'This' & 'Next' references disappear for the constitution record
			 of the losing team, the team "Arsenal" beat	--->
			<cfinclude template="queries/qry_QGetBlank.cfm">
			<cfinclude template="queries/qry_QUpdtConstit2.cfm">
		<cfelse>  <!--- Should always find just the one record , otherwise ABORT --->
			<cfoutput>
				<cfif QSW00.RecordCount IS "0">
					<!--- No Next Match - must be the Final --->
				<cfelse>
					<span class="pix18boldred">
					Error: Too many "Next" matches found. Check the Constitution carefully!<BR><BR>
					<P>Press the Back button on your browser.....
					</span>
					<CFABORT>
				</cfif>
			</cfoutput>
		</cfif>
	<cfelse>
		<!--- That's all folks! No more processing needed --->
	</cfif>
<cfelse> <!--- Should always find just the one record, otherwise ABORT --->
	Error in InclSpecifyWinner.cfm - QSW1 Should always find just the one record. ABORTING <BR>
	<CFABORT>
</cfif>
