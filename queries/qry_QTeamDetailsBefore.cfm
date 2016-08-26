<!--- called by upd_TeamDetails.cfm --->
<cfquery name="QTeamDetailsBefore" datasource="#request.DSN#">	
	SELECT 
		ID,
		VenueID,
		PitchNoID,
		ShirtColour1,
		ShortsColour1,
		SocksColour1,
		ShirtColour2,
		ShortsColour2,
		SocksColour2,
		URLTeamWebsite,
		URLTeamPhoto,
		
		Contact1Name,
		Contact1JobDescr,
		Contact1Address,
		Contact1TelNo1,
		Contact1TelNo1Descr,
		Contact1TelNo2,
		Contact1TelNo2Descr,
		Contact1TelNo3,
		Contact1TelNo3Descr,
		Contact1Email1,
		Contact1Email2,
		
		Contact2Name, 
		Contact2JobDescr,
		Contact2Address,
		Contact2TelNo1,
		Contact2TelNo1Descr,
		Contact2TelNo2,
		Contact2TelNo2Descr,
		Contact2TelNo3,
		Contact2TelNo3Descr,
		Contact2Email1,
		Contact2Email2,
		
		Contact3Name,
		Contact3JobDescr,
		Contact3Address,
		Contact3TelNo1,
		Contact3TelNo1Descr,
		Contact3TelNo2,
		Contact3TelNo2Descr,
		Contact3TelNo3,
		Contact3TelNo3Descr,
		Contact3Email1,
		Contact3Email2,
		
		ShowHideContact1Address,
		ShowHideContact2Address,
		ShowHideContact3Address,
		
		ShowHideContact1TelNo1,
		ShowHideContact2TelNo1,
		ShowHideContact3TelNo1,
		ShowHideContact1TelNo2,
		ShowHideContact2TelNo2,
		ShowHideContact3TelNo2,
		ShowHideContact1TelNo3,
		ShowHideContact2TelNo3,
		ShowHideContact3TelNo3,
		
		ShowHideContact1Email1,
		ShowHideContact2Email1,
		ShowHideContact3Email1,
		ShowHideContact1Email2,
		ShowHideContact2Email2,
		ShowHideContact3Email2
	FROM
		teamdetails
	WHERE
		teamdetails.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND teamdetails.ID = <cfqueryparam value = #ThisTeamDetailsID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
