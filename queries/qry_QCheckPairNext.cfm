<!--- called by InclCheckMatchNos --->

<cfquery name="QCheckPairNext" datasource="#request.DSN#">
	SELECT
		COUNT(m.ID) AS cnt,
		m.LongCol AS NextMatchString,
		m.ID
	FROM
		constitution AS c,
		matchno AS m
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
 		AND m.LongCol IS NOT NULL 
		AND c.DivisionID = <cfqueryparam value = #Form.DivisionID# 
								cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND m.id = c.NextMatchNoID 
	GROUP BY
		ID, NextMatchString <!--- m.ID, m.LongCol --->
	HAVING
		cnt > 2 <!--- COUNT(m.ID) > 2 --->
	ORDER BY 
		NextMatchString <!--- m.LongCol --->
</cfquery>
