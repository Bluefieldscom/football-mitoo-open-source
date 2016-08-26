<!--- called by EventCalendarUpdDel.cfm --->

<cftry>		  
	<cfquery name="DeleteEvent" datasource="#request.DSN#">
		DELETE FROM
			event 
		WHERE
			ID = '#form.ID#';
	</cfquery>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" 
			source="Event" errortype="baddata">
		<cfabort>
	</cfcatch>
</cftry>