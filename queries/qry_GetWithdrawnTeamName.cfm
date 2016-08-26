<!--- called from RestoreBackFromMisc.cfm --->

<CFQUERY NAME="GetWithdrawnTeamName" datasource="#request.DSN#">
	SELECT
		t.LongCol as TeamName,
		o.LongCol as OrdinalName,
		c.ID as CID
	FROM
		team AS t,
		ordinal AS o,
		constitution AS c
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #request.MiscID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND (t.LongCol LIKE '%(WITHDRAWN)%' OR o.LongCol LIKE  '%(WITHDRAWN)%' )
		AND t.ID = c.TeamID 
		AND o.ID = c.OrdinalID
	ORDER BY TeamName, OrdinalName
</CFQUERY>
