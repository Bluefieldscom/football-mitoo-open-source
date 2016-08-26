<!--- called by LUList.cfm --->

<cfquery name="QSuspendedPlayersCount" datasource="#request.DSN#" >
	SELECT
		COUNT(*) as cnt1,
		COUNT(distinct playerid) as cnt2
	FROM
		suspension as s
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
</cfquery>


