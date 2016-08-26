<!--- called from RegisterPlayer.cfm --->

<cfquery name="UpdateNewRegistration" datasource="#request.DSN#" >
	UPDATE
		register 
	SET
		FirstDay = #CreateODBCDate(request.CurrentDate)#
		<!---
		<cfif request.fmTeamID IS NOT 0 >
			, TeamID = #request.fmTeamID#
		</cfif>
		--->
	WHERE
		ID = #QGetNewRegistration.ID#
</cfquery>
