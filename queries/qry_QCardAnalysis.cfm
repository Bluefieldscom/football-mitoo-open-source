<!--- called by CardAnalysis.cfm --->

<cfquery name="QCardAnalysis" datasource="#request.DSN#" >
	SELECT
		t.LongCol as ClubName ,
		t.ID as TID ,
		COALESCE(SUM(a.Card),0) as Points,
		COALESCE(SUM(IF(a.card=1 OR a.card=4, 1, 0)),0) as yellowcards,
		COALESCE(SUM(IF(a.card=3 OR a.card=4, 1, 0)),0) as redcards
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
	HAVING
		Points > 0 <!--- SUM(a.Card) > 0 --->
	ORDER BY
		Points DESC, ClubName <!--- SUM(a.Card) DESC, t.LongCol --->
</cfquery>
