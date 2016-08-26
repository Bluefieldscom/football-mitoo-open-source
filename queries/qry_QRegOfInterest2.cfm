<!--- called by ExportRegistrationOfInterest.cfm --->

<cfquery name="QRegOfInterest2" datasource="zmast" >
	SELECT
		DateRegistered, 
		Forename, 
		Surname, 
		Email, 
		OtherComments, 
		LeagueCode, 
		TeamsInvolved, 
		Roles, 
		HowFoundOut, 
		HowLongUsing, 
		AgeRange
	FROM
		registration2
	ORDER BY
		DateRegistered DESC, Surname
</cfquery>
