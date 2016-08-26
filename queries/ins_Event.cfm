<!--- called by EventCalendarAdd.cfm --->

<cftry>		  
		<cfquery name = "InsertEvent" datasource="#request.DSN#">
			INSERT INTO
				event  
				( EventDate, LeagueCode, EventText, LeagueID)
				VALUES
				('#form.EventDate#',
				 <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> ,
				 '#form.eventtext#', #request.LeagueID#);
		</cfquery>
		<cfcatch type="Database">
			<cfif cfcatch.NativeErrorCode IS "1062">
				<!--- duplicate values on index EventDateLeaguecode --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Event" errortype="duplicatekey" message="EventDateLeaguecode">
				<cfabort>
			</cfif>
		</cfcatch>
		<cfcatch type="Any">
			<!--- for all other errors, most likely non-numeric codes --->
			<cfmodule template="../dberrorpage.cfm" 
				source="Event" errortype="baddata">
			<cfabort>
		</cfcatch>
</cftry>