<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset DelayPeriod = 1>
<cfset BoundaryDate = CreateODBCDate(NOW()- DelayPeriod )>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QRedCardsAndSuspensions.cfm">
<cfif QRedCardsAndSuspensions.RecordCount IS 0>
	<span class="pix13bold">Nothing to report</span>
<cfelse>
	<cfoutput query="QRedCardsAndSuspensions" group="PlayerName">
	<cfset PlayersFullName = "<b>#PlayerSurname#</b> #PlayerForename#">
	<cfset RedCardCount = 0>	
	<span class="pix13"><br><br>#PlayersFullName# (Reg No #PlayerNo#) of #TeamName#<BR></span>
	<cfoutput>
			<cfset RedCardCount = RedCardCount + 1 >
			<span class="pix13">Red Card on #DateFormat(FixtureDate, 'DDDD, DD MMM YYYY')# <a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#"><u>see Team Sheet</u></a><br></span>
			<!--- &nbsp;&nbsp;&nbsp;<a href="SuspendPlayer.cfm?LeagueCode=#LeagueCode#&PI=#PID#">add suspension</a><BR>--->
	</cfoutput>
	<cfset ThisPID = QRedCardsAndSuspensions.PID >
	<cfinclude template="queries/qry_QSuspens.cfm">
	<cfif QSuspens.RecordCount IS 0>
	<cfelse>
		<cfset ListOfFirstDays=ValueList(QSuspens.FirstDay)>
		<cfset ListOfLastDays=ValueList(QSuspens.LastDay)>
		<cfset ListOfNumberOfMatches=ValueList(QSuspens.NumberOfMatches)>
		<cfloop index="I" from="1" to="#ListLen(ListOfFirstDays)#" step="1" >
			<cfset FDay = ListGetAt(ListOfFirstDays, I)>
			<cfset LDay = ListGetAt(ListOfLastDays, I)>
			<cfset NoM = ListGetAt(ListOfNumberOfMatches, I)>
			<span class="pix13"><cfif #DateFormat( LDay , 'YYYY-MM-DD')# IS "2999-12-31">Ongoing <cfelseif NoM GT 0>Served <cfelse>Period </cfif><cfif NoM GT 0>#NoM# match ban</cfif> suspension from #DateFormat( FDay , 'DD MMMM YYYY')# <cfif #DateFormat( LDay , 'YYYY-MM-DD')# IS "2999-12-31"><cfelse>to #DateFormat( LDay , 'DD MMMM YYYY')#</cfif></span><br>
		</cfloop>
	</cfif>
	<span class="pix10">Red Cards=#RedCardCount# Suspensions=#QSuspens.RecordCount#</span><br>
	</cfoutput>
</cfif>
