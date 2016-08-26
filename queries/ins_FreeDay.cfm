<!--- called by UpdateFreeDay.cfm --->
<cfquery name="InsrtFreeDay" datasource="#request.DSN#" >
	INSERT INTO
		teamfreedate
		(TeamID, OrdinalID, FreeDate, LeagueCode)
	VALUES
		(#FreeTID#, #FreeOID#, '#MDate#', '#request.filter#')
</cfquery>
