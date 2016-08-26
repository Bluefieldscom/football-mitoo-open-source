<!--- called by GatherTeamsUnderClubProcess2.cfm --->
<cftry>
	<cfquery name="UpdtClubInfo" datasource="zmast" >
		UPDATE clubinfo
		SET ClubName='#ClubName#', Location='#Location#', DateTimeStamp=#CreateODBCDateTime(Now())#, Password='#request.SecurityLevel#'
		WHERE
		ID=#ClubInfoID#
	</cfquery>
	<cfcatch type="Database">
		<cfif cfcatch.NativeErrorCode IS "1062">
			<!--- duplicate values on Leaguecode,Shortcol(unique ID) - Check --->
				<cfmodule template="../dberrorpage.cfm" 
					source="clubinfo" errortype="duplicatekey" message="indexno">
		</cfif>
	</cfcatch>
</cftry>
