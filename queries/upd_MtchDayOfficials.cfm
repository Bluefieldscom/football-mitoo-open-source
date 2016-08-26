<!--- called by MtchDayOfficials.cfm --->

<cfif ThisKOTime IS "">
	<cfquery name="UpdateOfficials" datasource="#request.DSN#">
		UPDATE
			fixture 
		SET 
			KOTime = NULL, 
			RefereeID=#ThisRefereeID#, 
			AsstRef1ID=#ThisAsstRef1ID#, 
			AsstRef2ID=#ThisAsstRef2ID#
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND id = #ThisFixtureID#
	</cfquery>
<cfelse>
	<cfquery name="UpdateOfficials" datasource="#request.DSN#">
		UPDATE
			fixture 
		SET 
			KOTime = '#ThisKOTime#', 
			RefereeID=#ThisRefereeID#, 
			AsstRef1ID=#ThisAsstRef1ID#, 
			AsstRef2ID=#ThisAsstRef2ID#
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND id = #ThisFixtureID#
	</cfquery>
</cfif>
