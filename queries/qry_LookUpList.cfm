<!--- Called by Toolbar1.cfm --->

<cfquery name="LookUpList" datasource="ZMAST">
	SELECT
		ID,
		TableName
	FROM
		lookuptable as LookUpTable
	WHERE
		1 = 1
		<cfif NOT ListFind("Silver",request.SecurityLevel) >
			AND TableName NOT IN('Noticeboard','Document')
		</cfif>
		<cfif VenueAndPitchAvailable IS "No">
			AND TableName NOT IN('Venue')
		</cfif>		
	ORDER BY
		Tablename
</cfquery>
