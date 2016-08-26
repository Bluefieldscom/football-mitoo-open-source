<!--- included by Action.cfm --->

<cfinclude template="queries/del_DelPitchAvailable.cfm"> 
<!--- having just deleted the pitchavailable record let's see if there was a single corresponding fixture and set its PitchAvailableID field to zero --->
<cfinclude template="queries/qry_FindFixture01.cfm">
<cfif FindFixture01.RecordCount IS 0 >
<cfelseif FindFixture01.RecordCount IS 1 >
	<!--- set its PitchAvailableID field to zero --->
	<cfinclude template="queries/upd_UpdtFixture01.cfm">
<cfelse>
</cfif>
