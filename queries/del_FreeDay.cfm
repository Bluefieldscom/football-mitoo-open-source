<!--- called by UpdateFreeDay.cfm --->
<cfquery name="DelFreeDay" datasource="#request.DSN#" >
	DELETE FROM teamfreedate WHERE ID = #QGetFreeDay.ID#
</cfquery>
