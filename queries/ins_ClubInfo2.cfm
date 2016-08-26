<!--- called by GatherTeamsUnderClubProcess2.cfm --->
<cftry>
	<cfquery name="InsrtClubInfo" datasource="zmast" >
		INSERT INTO clubinfo ( ClubName, Location, DateTimeStamp, Password ) VALUES ( '#ClubName#', '', #CreateODBCDateTime(Now())#, '#request.SecurityLevel#'  )
	</cfquery>
	<cfcatch type="Database">
		<cfif cfcatch.NativeErrorCode IS "1062">
			<!--- duplicate values on keys - Check --->
				<cfmodule template="../dberrorpage.cfm" 
					source="clubinfo" errortype="duplicatekey" message="indexno">
		</cfif>
	</cfcatch>
</cftry>
