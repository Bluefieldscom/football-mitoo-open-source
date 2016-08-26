<!--- called by ConstitList.cfm --->

<cfquery name="QFixture001" datasource="#request.DSN#">
	SELECT
		ID
	FROM 
		fixture 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND (HomeID=#CID# OR AwayID=#CID#)
</cfquery>
