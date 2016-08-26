<!--- called from MatchOfficialsExpensesGridXLS.cfm --->

<CFQUERY NAME="QMatchOfficialsExpenses1" datasource="#request.DSN#">
	SELECT
		f.MatchOfficialsExpenses, f.HomeID, f.AwayID
	FROM 
		fixture AS f,
		constitution AS c
	WHERE 
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c.ID = f.HomeID
</cfquery>
<CFQUERY NAME="QMatchOfficialsExpenses2" datasource="#request.DSN#">
	SELECT
		f.MatchOfficialsExpenses, f.HomeID, f.AwayID
	FROM 
		fixture AS f,
		constitution AS c
	WHERE 
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND f.MatchOfficialsExpenses > 0
		AND c.ID = f.HomeID
</cfquery>
