<!--- included by Action.cfm --->

<!--- before we update the pitchavailable record let's see if there was a single corresponding fixture and set its PitchAvailableID field to zero --->
<cfinclude template="queries/qry_FindFixture01.cfm">
<cfif FindFixture01.RecordCount IS 0 >
<cfelseif FindFixture01.RecordCount IS 1 >
	<!--- set its PitchAvailableID field to zero --->
	<cfinclude template="queries/upd_UpdtFixture01.cfm">
<cfelse>
</cfif>
<cfinclude template="queries/upd_PitchAvailable.cfm">
<!--- after the update let's see if there is now a single corresponding fixture with a PitchAvailableID=0 and change this from zero to the correct value --->
<cfinclude template="queries/qry_FindFixture02.cfm">
<cfif FindFixture02.RecordCount IS 0 >
<cfelseif FindFixture02.RecordCount IS 1 >
	<!--- set its PitchAvailableID field to the corresponding value --->
	<cfinclude template="queries/upd_UpdtFixture02.cfm">
<cfelse>
</cfif>
