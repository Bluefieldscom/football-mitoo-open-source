<!--- called from TransferTeamToMisc.cfm --->

<cfquery name="QMisc02" datasource="#request.DSN#" >
	SELECT
		HomeID
	FROM
		fixture 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND AwayID = <cfqueryparam value = #Form.CID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
