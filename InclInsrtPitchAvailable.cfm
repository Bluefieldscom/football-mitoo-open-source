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
			<cfelseif RadioButton IS "2">
				<cfset CandidateCount = CandidateCount + 1 >
				<cfif CandidateCount Mod 2 IS 0 >
				<cfelse>
					<cfinclude template="queries/ins_PitchAvailable.cfm">
				</cfif>
			<cfelse>
				ERROR in InclInsrtPitchAvailable.cfm
				<cfabort>
			</cfif>
	<cfelse>
	</cfif>
</cfloop>

