<!--- called from webServicesWrite.cfc (twice) --->

<cfquery name="getKORoundID" datasource="#variables.dsn#">
	SELECT
		ID 
	FROM
		koround 
	WHERE 
		mediumcol #variables.getWhere#
		AND leaguecode='#arguments.leagueCode#'
</cfquery>
