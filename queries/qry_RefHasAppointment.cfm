<!--- called by  RefAvailable.cfm --->

<cfquery name="QRefHasAppointment" datasource="#request.DSN#">
	SELECT
		DAY(FixtureDate) as f_day ,
		MONTH(FixtureDate) as f_month
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5" >
		AND (RefereeID = #ThisRefereeID# OR AsstRef1ID = #ThisRefereeID# OR AsstRef2ID = #ThisRefereeID# OR FourthOfficialID = #ThisRefereeID# OR AssessorID = #ThisRefereeID# )
		AND MONTH(FixtureDate) = #ThisMonth#
	ORDER BY
		f_day
</cfquery>