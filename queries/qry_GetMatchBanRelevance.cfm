<!--- called by InclConstit02.cfm --->

<CFQUERY NAME="GetMatchBanRelevance" datasource="#request.DSN#">
	SELECT
		MatchBanFlag
	FROM
		constitution
	WHERE
		ID = <cfqueryparam value = #url.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
