<!--- called by InclCheckKORound --->

<CFQUERY NAME="QKnockOut" datasource="#request.DSN#" >
	SELECT
		Notes
	FROM
		division
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
