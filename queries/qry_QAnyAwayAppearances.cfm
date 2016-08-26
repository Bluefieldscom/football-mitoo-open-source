<!--- called by MtchDay.cfm --->			  
<cfquery name="QAnyAwayAppearances" datasource="#request.DSN#" >
	SELECT
		count(*) as ACount
	FROM
		appearance
	WHERE 
		leaguecode='#request.filter#' 
		AND FixtureID=#FID#
		AND HomeAway='A'
</cfquery>
