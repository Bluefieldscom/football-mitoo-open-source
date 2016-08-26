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
<cfset PIDList = "">
<cfif QRedCardsAndSuspensions.RecordCount IS 0>
	<span class="pix13bold">Nothing to report</span>
<cfelse>
	<cfoutput query="QRedCardsAndSuspensions" group="PlayerName">
		<cfset PlayersFullName = "<b>#PlayerSurname#</b> #PlayerForename#">
		<cfset Reporting = "No">
		<cfset RedCardCount = 0>	
		<cfoutput>
			<cfset RedCardCount = RedCardCount + 1 >
		</cfoutput>
		<cfset ThisPID = QRedCardsAndSuspensions.PID >
		<cfinclude template="queries/qry_QSuspens.cfm">
		<cfif RedCardCount IS QSuspens.RecordCount> 
			<!--- do not report on this if they agree --->
		<cfelse>
			<cfset PIDList = ListAppend(PIDList, PID)>
		</cfif>
	</cfoutput>
</cfif>
<cfif PIDList IS "">
<cfelse>
	<cfloop list="#PIDList#" index = "ListElement">
		<cfinclude template="queries/qry_QRedCards.cfm">
		<cfoutput query="QRedCards" group="PID">
			<cfset PlayersFullName = "<b>#PlayerSurname#</b> #PlayerForename#">
			<span class="pix13"><br><br>#PlayersFullName# (Reg No #PlayerNo#) of #TeamName#<BR></span>
			<cfoutput>
				<span class="pix13">Red Card on #DateFormat(FixtureDate, 'DDDD, DD MMM YYYY')# <a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#"><u>see Team Sheet</u></a><br></span>
			</cfoutput>
			<cfset ThisPID = QRedCards.PID >
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
			<span class="pix10">Red Cards=#QRedCards.RecordCount# Suspensions=#QSuspens.RecordCount#</span><br>
		</cfoutput>
	</cfloop>
</cfif>
		
		
		
		
		<!---
		
		<cfoutput query="QRedCardsAndSuspensions" group="PlayerName">
			<cfset PlayersFullName = "<b>#PlayerSurname#</b> #PlayerForename#">
						<span class="pix13"><br><br>#PlayersFullName# (Reg No #PlayerNo#) of #TeamName#<BR></span>

			<cfoutput>
				<span class="pix13">Red Card on #DateFormat(FixtureDate, 'DDDD, DD MMM YYYY')# <a href="TeamList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=#HomeAway#"><u>see Team Sheet</u></a><br></span>
			</cfoutput>
			<cfset ListOfFirstDays=ValueList(QSuspens.FirstDay)>
			<cfset ListOfLastDays=ValueList(QSuspens.LastDay)>
			<cfset ListOfNumberOfMatches=ValueList(QSuspens.NumberOfMatches)>
			<cfloop index="I" from="1" to="#ListLen(ListOfFirstDays)#" step="1" >
				<cfset FDay = ListGetAt(ListOfFirstDays, I)>
				<cfset LDay = ListGetAt(ListOfLastDays, I)>
				<cfset NoM = ListGetAt(ListOfNumberOfMatches, I)>
				<span class="pix13"><cfif NoM GT 0>#NoM# match ban</cfif> suspension from #DateFormat( FDay , 'DD MMMM YYYY')# to #DateFormat( LDay , 'DD MMMM YYYY')#</span><br>
			</cfloop>
							<span class="pix10">Red Cards=#RedCardCount# Suspensions=#QSuspens.RecordCount#</span><br> 
	
		</cfoutput>
</cfif>
--->
