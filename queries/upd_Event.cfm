<!--- called by EventCalendarUpdDel.cfm --->

<cftry>		  
	<cfquery name="UpdateEvent" datasource="#request.DSN#">
		UPDATE event 
		SET eventtext = '#form.eventtext#'
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