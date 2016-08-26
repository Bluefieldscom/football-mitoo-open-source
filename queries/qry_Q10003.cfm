<!--- called by SwapHomeAway.cfm --->
<cfquery name="Q10003" datasource="#request.DSN#">
	SELECT
		ID,
		HomeAway
	FROM
		appearance
	WHERE
		FixtureID = #Q10001.ID#
</cfquery>
