<!--- included by Action.cfm --->

<cfset StartDate = CreateDate(StartYear, StartMonth, Min(DaysInMonth(CreateDate(StartYear,StartMonth,1)), StartDay) ) >
<cfset EndDate = CreateDate(EndYear, EndMonth, Min(DaysInMonth(CreateDate(EndYear,EndMonth,1)), EndDay) ) >
<cfset NoOfDays=DateDiff('d',StartDate,EndDate)>
<cfset CandidateCount = 0 >
<cfloop from="0" to="#NoOfDays#" step="1" index="i" >
	<cfset ThisDate = DateAdd('D', i, StartDate )>
	<cfif DayOfWeek(ThisDate) IS DayOfWeek >
		<cfset ThisDate = DateFormat(ThisDate, 'YYYY-MM-DD')>
		<cfif RadioButton IS "1">
			<cfinclude template="queries/ins_PitchAvailable.cfm">
			<!--- now get the ID of the record we have just inserted --->
			<cfinclude template="queries/qry_GetPitchAvailableID.cfm">
			<cfif GetPitchAvailableID.RecordCount IS 0 >
			<cfelseif GetPitchAvailableID.RecordCount IS 1 >
				<!--- after the insert let's see if there is a single corresponding fixture with a PitchAvailableID=0 and change this from zero to the correct value --->
				<cfinclude template="queries/qry_FindFixture05.cfm">
				<cfif FindFixture05.RecordCount IS 0 >
				<cfelseif FindFixture05.RecordCount IS 1 >
					<!--- set its PitchAvailableID field to the corresponding value --->
					<cfinclude template="queries/upd_UpdtFixture05.cfm">
				<cfelse>
				</cfif>
			<cfelse>
			</cfif>
			
		<cfelseif RadioButton IS "2">
			<cfset CandidateCount = CandidateCount + 1 >
			<cfif CandidateCount Mod 2 IS 0 >
			<cfelse>
				<cfinclude template="queries/ins_PitchAvailable.cfm">
				<!--- now get the ID of the record we have just inserted --->
				<cfinclude template="queries/qry_GetPitchAvailableID.cfm">
				<cfif GetPitchAvailableID.RecordCount IS 0 >
				<cfelseif GetPitchAvailableID.RecordCount IS 1 >
					<!--- after the insert let's see if there is a single corresponding fixture with a PitchAvailableID=0 and change this from zero to the correct value --->
					<cfinclude template="queries/qry_FindFixture05.cfm">
					<cfif FindFixture05.RecordCount IS 0 >
					<cfelseif FindFixture05.RecordCount IS 1 >
						<!--- set its PitchAvailableID field to the corresponding value --->
						<cfinclude template="queries/upd_UpdtFixture05.cfm">
					<cfelse>
					</cfif>
				<cfelse>
				</cfif>
			</cfif>
		<cfelse>
			ERROR in InclInsrtPitchAvailable.cfm
			<cfabort>
		</cfif>
	<cfelse>
	</cfif>
</cfloop>

