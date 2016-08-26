<cfoutput>
	<cfloop index="I" from="1" to="#PlayersWhoDidNotStartCount#" step="1" >
		<cfif StructKeyExists(form, "P#I#")>

			<cfset AID = "AID#I#">
			<cfset AID = Evaluate(AID)>
			
			<cfset NSN = "NSN#I#">
			<cfset NSN = Evaluate(NSN)>
			
			<cfset ASN = "ASN#I#">
			<cfset ASN = Evaluate(ASN)>
			<cfif ASN IS ''>
				<cfset ASN = NSN >
			</cfif>

			
			<!--- #I#  PID=#PID# GoalsScored = #GoalsScored# CardValue = #CardValue#<BR> --->
			<cfif IsNumeric(NSN) AND IsNumeric(ASN)>
				<cfinclude template = "queries/ins_StartingLineUp.cfm">
			</cfif>
		</cfif>
	</cfloop>
<!---	
<cfif PlayersWhoStartedCount LE #MaxAllowedOnTeamSheet# >
--->
	<cfloop index="J" from="1" to="#PlayersWhoStartedCount#" step="1" >
		<cfif NOT StructKeyExists(form, "ppp#J#")>
			<cfset AppID = "AppID#J#">
			<cfset AppID = Evaluate(AppID)>
			<cfinclude template = "queries/del_StartingLineUp.cfm">
		</cfif>
	</cfloop>
<!---	
<cfelse>
	<span class="pix18boldred"> UpdateStartingLineUpList.cfm - please report this error to us. <br>
	LeagueCode=#LeagueCode#, PlayersWhoStartedCount =#PlayersWhoStartedCount# MaxAllowedOnTeamSheet #MaxAllowedOnTeamSheet#</span>
	<cfabort>
</cfif>
--->

</cfoutput>
