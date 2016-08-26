<!--- called by MtchDay.cfm --->			  
<cfquery name="QAnyHomeAppearances" datasource="#request.DSN#" >
	SELECT
		count(*) as HCount
	FROM
		appearance
	WHERE 
		leaguecode='#request.filter#' 
		AND FixtureID=#FID#
		AND HomeAway='H'
</cfquery>
