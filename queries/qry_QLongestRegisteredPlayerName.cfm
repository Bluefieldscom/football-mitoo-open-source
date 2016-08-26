<!--- called by RegisteredList1.cfm and RegisteredList2.cfm --->

<CFQUERY NAME="QLongestRegisteredPlayerName" datasource="#request.DSN#">
	SELECT
		MAX(LENGTH(TRIM(CONCAT(p.Surname, " ", p.Forename)))) as Length
	FROM
		register AS r, 
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.ID = r.PlayerID
</CFQUERY>
