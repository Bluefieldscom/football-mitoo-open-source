<!--- called by ExportYellowXLS.cfm --->

<cfquery name="QYellowDetails2" datasource="#request.DSN#">	
	SELECT 
		li.namesort,
		r.leaguecode,
		r.EmailAddress1, 
		r.EmailAddress2, 
		r.Surname, 
		r.Forename 
 	FROM 
		referee r, 
		zmast.leagueinfo li
	WHERE
		li.leaguecodeprefix = r.leaguecode
		AND li.leaguecodeyear = '#right(request.dsn,4)#'
	ORDER BY
		li.namesort, r.Surname, r.Forename
</cfquery>
