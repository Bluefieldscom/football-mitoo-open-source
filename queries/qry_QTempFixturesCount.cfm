<!--- Called by MtchDay.cfm and FixtResMonth.cfm --->

<cfquery name="QTempFixtures" dbtype="query">
	SELECT
		COUNT(FID) as counter
	FROM
		QFixtures
	WHERE
		Result = 'T'
</cfquery>
