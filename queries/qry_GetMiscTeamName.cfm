<!--- called from TransferTeamToMisc.cfm --->

<CFQUERY NAME="GetMiscTeamName" datasource="#request.DSN#">
	SELECT
		t.LongCol as TeamName,
		o.LongCol as OrdinalName,
		c.ID as CID
	FROM
		team AS t,
		ordinal AS o,
		constitution AS c
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND c.DivisionID = <cfqueryparam value = #Form.DivisionID# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND t.LongCol IS NOT NULL 
		AND t.ID NOT IN
			(SELECT ID 
				FROM team 
				WHERE LEFT(Notes,7) = 'NoScore' 
					OR ShortCol = 'GUEST') 
		AND t.ID = c.TeamID 
		AND o.ID = c.OrdinalID
	ORDER BY TeamName, OrdinalName
</CFQUERY>
