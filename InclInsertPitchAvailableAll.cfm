<!--- included by Action.cfm --->
<cfloop  from="1" to="#ListLen(VenueNameList)#" step="1" index="x">
	<cfoutput>
		<cfif ListGetAt(VenueNameList,x) IS "*UNKNOWN*" >
			<cfset ThisDate = ListGetAt(BookingDateList,x)>
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
	</cfoutput>
</cfloop>
