<!--- called by InclCheckMatchNos --->
<cfquery name="QCheckConstitPair" datasource="#request.DSN#">
	SELECT
		t.longcol as TeamName,
		o.longcol as OrdinalName,
		left(m1.LongCol,3) AS ThisMatchString,
		left(m2.LongCol,3) AS NextMatchString		
	FROM
		constitution AS c,
		team t,
		ordinal o,
		matchno AS m1,
		matchno AS m2
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #Form.DivisionID#	cfsqltype="CF_SQL_INTEGER" maxlength="8">
 		AND m1.LongCol IS NOT NULL 
		AND left(m1.LongCol,3) = left(m2.LongCol,3)
		AND m1.id = c.ThisMatchNoID
		AND m2.id = c.NextMatchNoID
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID
</cfquery>
