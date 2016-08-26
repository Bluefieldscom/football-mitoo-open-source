<!--- called by GatherTeamsUnderClubProcess2.cfm --->

<cfquery name="QUmbrellaID" datasource="zmast" >
	SELECT
		ID,
		ClubName,
		Location
	FROM
		clubinfo
	WHERE
		ClubName = '#ClubName#'
		AND Location=''
</cfquery>
