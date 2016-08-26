<!--- called from SuspendPlayer.cfm --->

<CFQUERY NAME="GetSuspension" datasource="#request.DSN#">
	SELECT
		s.ID as SID,
		s.FirstDay,
		s.LastDay,
		s.NumberOfMatches,
		s.SuspensionNotes,
		p.Surname, p.Forename,
		<!--- p.LongCol as PlayerName, --->
		p.ShortCol as RegNo,
		p.ID as PlayerID
	FROM
		suspension AS s, 
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND s.ID = <cfqueryparam value = #SI# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND p.ID = s.PlayerID
</CFQUERY>
