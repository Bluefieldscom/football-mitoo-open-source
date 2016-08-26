<!--- called by JLogInQuery.cfm --->

<cftry>

	<cfquery name="DeleteSupervisorTrail" datasource="ZMAST" >
		DELETE
		FROM
			loghistory
		WHERE
			Passwd = '*Supervisor*'			
	</cfquery>

	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="LogHistory"><cfabort>
	</cfcatch>
	
</cftry>