<!--- determine which year involved --->
<cfquery name="getLeagueYear" datasource="zmast">
	SELECT 
		leagueCodeYear, id, defaultLeagueCode, leagueName, 
		defaultGoalScorers, leagueTblCalcMethod, pointsForWin, pointsForDraw, pointsForLoss
	FROM 
		leagueinfo
	WHERE
		leagueCodePrefix = '#arguments.leaguecode#'
	AND 
		(	
		('#arguments.startDate#' BETWEEN seasonStartDate AND seasonEndDate) 
		OR ('#arguments.endDate#' BETWEEN seasonStartDate AND seasonEndDate) 
		)
</cfquery>
<!--- set fm datasource --->
<cfset variables.dsn = "fm2008"> <!--- & getLeagueYear.leagueCodeYear> --->
<cfset variables.league_id = getLeagueYear.id>
