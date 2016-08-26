<!--- called by GatherTeamsUnderClub.cfm --->
<cftry>
	<cfquery name="InsrtClubInfo" datasource="zmast" >
		INSERT INTO clubinfo ( ClubName, CountyInfoID, DateTimeStamp, Password ) VALUES ( '#ClubName#', '#form.CountyInfoID#', #CreateODBCDateTime(Now())#, '#request.SecurityLevel#'  )
	</cfquery>
	<cfcatch type="Database">
		<cfif cfcatch.NativeErrorCode IS "1062">
			<!--- duplicate values on Leaguecode,Shortcol(unique ID) - Check --->
				<cfmodule template="../dberrorpage.cfm" 
					source="clubinfo" errortype="duplicatekey" message="indexno">
		</cfif>
	</cfcatch>
</cftry>
