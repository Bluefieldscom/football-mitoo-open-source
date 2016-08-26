<cfoutput>
	<!--- Process the Unregistered Players first..... 
	prefix is "u" ........ from bottom of screen --->
	<cfloop index="I" from="1" to="#UnregisteredPlayersCount#" step="1" >
		<cfif StructKeyExists(form, "u#I#") > 
		<!--- this unregistered player has been ticked --->
			<cfset uID = "uID#I#">
			<cfset uID = Evaluate(uID)>
			<cfinclude template = "queries/ins_RegistrationList.cfm">
		</cfif>
	</cfloop>
	<!--- Process the Registered Players next..... 
	prefix is "r" ........ from top of screen --->
	<cfloop index="J" from="1" to="#ThisClubsRegisteredPlayersCount#" step="1" >
		<cfif NOT StructKeyExists(form, "r#J#") >
			<cfset rID = "rID#J#">
			<cfset rID = Evaluate(rID)>
			<cfinclude template = "queries/del_RegistrationList.cfm">
		</cfif>
	</cfloop>
</cfoutput>
<CFLOCATION URL="RegisteredList1.cfm?LeagueCode=#Form.LeagueCode#&TeamID=#Form.TeamID#&TblName=Register" ADDTOKEN="NO">


