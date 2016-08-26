<!--- called by ExportRegistrationOfInterest.cfm --->

<cfquery name="QRegOfInterest1" datasource="zmast" >
	SELECT
		DateRegistered, 
		Name, 
		Email, 
		Info, 
		LeagueCode
	FROM
		registration
	ORDER BY
		DateRegistered DESC, Name
</cfquery>
