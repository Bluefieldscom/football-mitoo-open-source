<!--- called by InclCheckMatchNos --->

<CFQUERY name="QCheckPairThisDetail" datasource="#request.DSN#">
	SELECT
		t.LongCol AS TeamString,
		o.LongCol AS OrdinalString
	FROM
		constitution AS c,
		team AS t,
		ordinal AS o
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.ThisMatchNoID = <cfqueryparam value = #QCheckPairThis.ID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND t.ID = c.TeamID 
		AND c.DivisionID = <cfqueryparam value = #Form.DivisionID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND o.ID = c.OrdinalID
	ORDER BY 
		TeamString, OrdinalString <!--- t.LongCol, o.LongCol --->
</CFQUERY>	
