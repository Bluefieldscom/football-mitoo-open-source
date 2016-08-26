<!--- called by TeamsNotPlayingToday.cfm --->

<CFQUERY NAME="QTeamFreeDate" datasource="#request.DSN#" >
	SELECT
		CONCAT(TeamID, '-', OrdinalID) as FreeTOID
	FROM
		teamfreedate
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND FreeDate = '#DateFormat(MDate, "YYYY-MM-DD")#'
</CFQUERY>
