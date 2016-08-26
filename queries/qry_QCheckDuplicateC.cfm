<!--- called by InclInsrtConstit.cfm --->

<CFQUERY name="QCheckDuplicateC" datasource="#request.DSN#">
	SELECT
		t.LongCol as TeamName,
		o.LongCol as OrdinalName,
		d.LongCol as DivisionName
	FROM
		constitution AS c,
		team AS t,
		ordinal AS o,
		division AS d
	WHERE
		c.LeagueCode     = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.TeamID     = <cfqueryparam value = #Form.TeamID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c.OrdinalID  = <cfqueryparam value = #Form.OrdinalID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c.DivisionID = <cfqueryparam value = #Form.DivisionID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND t.ID = c.TeamID 
		AND o.ID = c.OrdinalID 
		AND d.ID = c.DivisionID
</CFQUERY>
