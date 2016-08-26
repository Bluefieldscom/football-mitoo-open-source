<!--- called by Action.cfm (this is only ever activated by Julian when JAB logged in) --->
		  
<cfquery name="InsrtSponsor" datasource="#request.DSN#" >
	INSERT INTO sponsor ( LastUpdated, Button, DID, TID, OID, SponsorsHTML, SponsorsName, Notes, TeamHTML, LeagueCode )
		  
		   VALUES ( #CreateODBCDate(Now())#, '#Form.Button#', #Form.DID#, #Form.TID#, #Form.OID#, '#Form.SponsorsHTML#', '#Form.SponsorsName#', '#Form.Notes#', '#Form.TeamHTML#', 
				<cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5"> )
</cfquery>
		
