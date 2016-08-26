<!--- called by AppearanceAnalysis.cfm --->

<cfquery name="QClubAnalysis" datasource="#request.DSN#" >
	SELECT
		t.LongCol as ClubName ,
		t.ID as TID ,
		COUNT(a.ID) as Appearances,
		SUM(IF(a.Activity=1,1,0)) as Apps1,
		SUM(IF(a.Activity=2,1,0)) as Apps2,
		SUM(IF(a.Activity=3,1,0)) as Apps3
	FROM
		register AS r ,
		team AS t ,
		appearance AS a ,
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND p.ID = a.PlayerID 
		AND p.ID = r.PlayerID 
		AND t.ID = r.TeamID
	GROUP BY
		ClubName, TID <!--- t.LongCol, t.ID --->
	ORDER BY
		ClubName <!--- t.LongCol --->
</cfquery>
