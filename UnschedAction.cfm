<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">

<cfset variables.robotindex="no">

<cfif form.Operation IS "Confirm">
	<!--- changing the date of the fixtures --->
	<cflock scope="session" timeout="10" type="exclusive" >
		<cfset session.CurrentDate = #GetToken(form.datebox,2,",")# >
	</cflock>
	<cflocation URL="Unsched.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" addtoken="no">
	<cfabort>
</cfif>

<cfif form.Operation IS "- Add Ticked -">
	<cfset OpType = "Temporary">
<cfelse>
	<cfset OpType = "Normal">
</cfif>

<cfset TickedCount = 0 >
<cfset ListOfTickedRowNumbers = "">
<cfset ListOfMatches = "">
<cfloop index="I" from="1" to="#UnschedCount#" step="1" >
	<cfif StructKeyExists(form, "R#I#") >
		<cfset TickedCount = TickedCount + 1 >
		<cfset ListOfTickedRowNumbers = ListAppend(ListOfTickedRowNumbers,#I#)>
	</cfif>

	<cfif form.VenueAndPitchAvailable IS "Yes">
		<cfif StructKeyExists(form, "R#I#") AND StructKeyExists(form, "V#I#") >
			<cfset ThisString = evaluate("form.V#I#") >
			<cfset ThisTeamID =  GetToken(ThisString,1 )  >
			<cfset ThisOrdinalID =  GetToken(ThisString,2 ) >
			<cfset ThisVenueID =  GetToken(ThisString,3 ) >
			<cfset ThisPitchNoID = GetToken(ThisString,4 ) >
			<cfset ThisPitchStatusID = GetToken(ThisString,5 ) >
			<cfset ThisBookingDate =  GetToken(ThisString,6 ) >
			<cfset ThisLeagueCode =  GetToken(ThisString,7 ) >
			<!--- check to see if there is already a pitch availability for "This" specification, if not, insert a record --->
			<cfinclude template="queries/qry_GetPitchAvailableID2.cfm">
			<cfif GetPitchAvailableID2.RecordCount IS 0>
				<!--- insert a pitchavailability for this date and venue --->
				<cfinclude template="queries/ins_PitchAvailable2.cfm">
				<!--- now get the ID of the record we have just inserted --->
				<cfinclude template="queries/qry_GetPitchAvailableID2.cfm">
				<cfset mmm = #ListSetAt(ListOfFixturePitchAvailabilityIDs, I, GetPitchAvailableID2.PA_ID)#>
			</cfif>
		</cfif>
	</cfif>
	
</cfloop>


<cfif TickedCount IS 0>
	<span class="pix24boldred">Empty Group - no boxes were ticked<BR><BR>
	Press the Back button on your browser.....</span>
	<cfabort>
</cfif>

<cfset MatchDate = form.FixtDate  >

<!--- we are not choosing referees or assistants when adding a group so we need to insert the ID of the "blank" official --->
<cfinclude template="queries/qry_GetBlankReferee.cfm">		  
<cfset RefereeID = #GetBlankReferee.ID#>
<cfset AsstRef1ID = #GetBlankReferee.ID#>
<cfset AsstRef2ID = #GetBlankReferee.ID#>
<cfset FourthOfficialID = #GetBlankReferee.ID#>
<cfset AssessorID = #GetBlankReferee.ID#>			
<CFLOOP index="I" from="1" to="#TickedCount#" step="1" >
	<cfset J = #ListGetAt(ListOfTickedRowNumbers, I)#>
	
	<!---
	<cfset HomeTeamID = #ListGetAt(ListOfHomeTeamIDs, J)#>
	<cfset HomeOrdinalID = #ListGetAt(ListOfHomeOrdinalIDs, J)#>
	--->
	<cfif form.VenueAndPitchAvailable IS "Yes">
		<cfset FixturePitchAvailabilityID = #ListGetAt(ListOfFixturePitchAvailabilityIDs, J)#>
	<cfelse>
		<cfset FixturePitchAvailabilityID = 0 >
	</cfif>
	
	<cfset HomeID = #ListGetAt(ListOfHomeIDs, J)#>
	<cfset AwayID = #ListGetAt(ListOfAwayIDs, J)#>
	<!---
	<cfif form.VenueAndPitchAvailable IS "Yes">
		<cfset ThisTeamID = HomeTeamID >
		<cfset ThisOrdinalID = HomeOrdinalID >
		<cfset ThisDate = DateFormat(MatchDate, 'YYYY-MM-DD') >
		<cfinclude template="queries/qry_FixturePitchAvailability.cfm">
		<cfif FixturePitchAvailability.RecordCount IS 1> 
			<cfset ThisFixturePitchAvailableID = FixturePitchAvailability.FPA_ID >
		<cfelse>
			<cfset ThisFixturePitchAvailableID = "" >
		</cfif>
		<!--- If there is only one available slot then use it when inserting the fixture
		If there is more than one slot then they will have to choose a particular slot when looking at and updating the fixture screen ---> 
	</cfif>
	--->
	
	
	
	<cfinclude template="InclInsrtGroupOfFixtures.cfm">
</CFLOOP>



<CFLOCATION URL="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(MatchDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
