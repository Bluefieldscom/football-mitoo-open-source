<!--- called by ClubList.cfm --->

<cfquery name="QTeamUnavailableDates" datasource="#request.DSN#" >
	SELECT
		FreeDate 
	FROM
		teamfreedate
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TeamID = #QClubStuff.TeamID#
		AND OrdinalID = #QClubStuff.OrdinalID#
	ORDER BY 
		FreeDate
</cfquery>
