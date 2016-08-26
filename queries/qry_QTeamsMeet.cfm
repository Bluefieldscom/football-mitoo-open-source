<!--- called by Unsched.cfm --->
<cfquery name="QTeamsMeet" datasource="#request.DSN#"> 
	SELECT
		FixtureDate
	FROM
		fixture
	WHERE
		HomeID IN (#request.InList#)
		AND AwayID IN (#request.InList#)
	ORDER BY
		FixtureDate DESC;
</cfquery>
