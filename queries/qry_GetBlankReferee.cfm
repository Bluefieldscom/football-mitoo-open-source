<!--- called by Action.cfm --->

<CFQUERY NAME="GetBlankReferee" datasource="#request.DSN#">
	SELECT
		ID
	FROM
		referee as Referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND LongCol IS NULL
</CFQUERY>
