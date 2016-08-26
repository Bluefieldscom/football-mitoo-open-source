<!--- called by ExportRegistrationOfInterest.cfm --->

<cfquery name="QRegOfInterest3" datasource="zmast" >
	SELECT
		DateRegistered, 
		Forename, 
		Surname, 
		Email, 
		OtherComments, 
		LeagueCode, 
		TeamsInvolved, 
		RoleList, 
		Other, 
		HowFoundOut, 
		HowLongUsing, 
		AgeRange
	FROM
		registration3
	ORDER BY
		DateRegistered DESC, Surname
</cfquery>
