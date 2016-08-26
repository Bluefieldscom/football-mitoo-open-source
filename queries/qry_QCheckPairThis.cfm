<!--- called by InclCheckMatchNos --->

<cfquery name="QCheckPairThis" datasource="#request.DSN#">
	SELECT
		COUNT(m.ID) AS cnt,
		m.LongCol AS ThisMatchString,
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
		AND m.id = c.ThisMatchNoID 
	GROUP BY
		ID, ThisMatchString <!--- m.ID, m.LongCol --->
	HAVING
		cnt > 1 <!--- COUNT(m.ID) > 1 --->
	ORDER BY 
		ThisMatchString <!--- m.LongCol --->
</cfquery>
