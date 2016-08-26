<!--- Called by Toolbar1.cfm --->

<CFQUERY NAME="GetFixtureMonths" dbtype="query">
	SELECT
		DISTINCT CalMonth
	FROM
		 GetFixtureDates
	ORDER BY
		CalYear
</CFQUERY>
