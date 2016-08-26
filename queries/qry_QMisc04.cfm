<!--- called from TransferTeamToMisc.cfm --->

<cfquery name="QMisc04" datasource="#request.DSN#" >
	SELECT
		AwayID
	FROM
		fixture 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND HomeID = <cfqueryparam value = #Form.CID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
