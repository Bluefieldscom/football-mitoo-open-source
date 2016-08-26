<!--- called by ExportCommitteeDetails.cfm --->

<cfquery name="QCommitteeDetails" datasource="#request.DSN#" >
	SELECT 
		longcol,
		mediumcol,
		leaguecode,
		namesort,
		countieslist,
		websitelink ,
		notes 
	FROM 
		committee, 
		zmast.leagueinfo 
	WHERE 
		leaguecode=leaguecodeprefix
		AND leaguecodeyear='#RIGHT(request.DSN,4)#'
	ORDER BY
		namesort, mediumcol
</cfquery>
