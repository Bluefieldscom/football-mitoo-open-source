<!--- called by LUList.cfm --->

<cfquery name="QRedundantTeamDetails" datasource="#request.DSN#">	
	SELECT
		td.id,
		t.longcol as team,
		IF(o.longcol IS NULL,"1st Team",o.longcol) as ordinal
	FROM
		teamdetails td, 
		team t, 
		ordinal o 
	WHERE td.id IN 
		(SELECT id FROM teamdetails WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		 AND CONCAT(teamid,"_",ordinalid) NOT IN (SELECT distinct CONCAT(teamid,"_",ordinalid) FROM constitution WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
		)
		AND td.teamid=t.id
		AND td.ordinalid=o.id
	ORDER BY
		team, ordinal
</cfquery>