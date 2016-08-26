<!--- called by EventCalendarUpdDel.cfm --->
<cftry>		  
	<cfquery name="GetEvent" datasource="#request.DSN#">
		SELECT 
			ID,
			EventDate,
			EventText
		FROM
			event 
		WHERE
			ID = <cfqueryparam value = #URL.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">;
	</cfquery>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" 
			source="Event" errortype="baddata">
		<cfabort>
	</cfcatch>
</cftry>