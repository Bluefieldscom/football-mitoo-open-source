<!--- called by upd_RefAvailable.cfm --->
<!--- applies to season 2012 onwards only --->
<cfquery name = "QRefAppt" datasource="#request.DSN#">
	SELECT
		ID 
	FROM 
		fixture
	WHERE
	LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
	AND FixtureDate = '#form.MatchDate#'
	AND (RefereeID = #form.RefereeID#  OR  
		AsstRef1ID = #form.RefereeID#  OR
			AsstRef2ID = #form.RefereeID#  OR
				FourthOfficialID = #form.RefereeID# OR
					AssessorID = #form.RefereeID# )
</cfquery>
