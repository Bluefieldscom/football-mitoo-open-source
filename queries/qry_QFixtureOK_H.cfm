<!--- called by InclInsrtGroupOfFixtures.cfm --->

<cfquery name="QFixtureOK_H" datasource="#request.DSN#">
	SELECT
		COUNT(*) as HomeCount,
		#HomeID# as HID
	FROM
		fixture 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND HomeID = <cfqueryparam value = #HomeID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND AwayID = <cfqueryparam value = #AwayID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
