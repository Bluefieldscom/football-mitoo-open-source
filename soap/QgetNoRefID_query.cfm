<!--- called from webServicesWrite.cfc --->

<cfquery name="getNoRefID" datasource="#variables.dsn#">
	SELECT
		ID 
	FROM
		referee 
	WHERE 
		mediumcol IS NULL 
		AND Left(Notes,11) = 'No referee'
		AND leaguecode='#arguments.leagueCode#'
</cfquery>
