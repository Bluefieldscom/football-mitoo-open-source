<!--- called by RegisteredList1.cfm and RegisteredList2.cfm --->

<CFQUERY NAME="QLongestClubName" datasource="#request.DSN#">
	SELECT
		MAX(LENGTH(t.LongCol)) as Length
	FROM
		register AS r, 
		player AS p, 
		team AS t
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID = r.PlayerID 
		AND t.ID = r.TeamID
</CFQUERY>
