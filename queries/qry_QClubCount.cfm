<!--- called by ListOfLeagues.cfm --->
<cfquery name="QClubCount1" datasource="fm#Year1#">
	SELECT 
		COUNT(*) as ActiveClubs
	FROM
		team
	WHERE
		LeagueCode = '#request.filter#' 
		AND (ID NOT IN (SELECT ID FROM team WHERE LeagueCode = '#request.filter#' AND LEFT(Notes,7) = 'NoScore'))	
		AND (ID NOT IN (SELECT ID FROM team WHERE LeagueCode = '#request.filter#' AND shortcol = 'Guest'))
		AND (ID IN (SELECT TeamID from constitution where LeagueCode = '#request.filter#'))			
		AND LongCol NOT LIKE '%WITHDRAWN%'
		AND LongCol NOT LIKE '%league%'
</cfquery>
<cfquery name="QClubCount2" datasource="fm#Year1#">
<!--- this should be zero otherwise it indicates the number of redundant clubs --->
	SELECT 
		COUNT(*) as RedundantClubs
	FROM
		team
	WHERE
		LeagueCode = '#request.filter#' 
		AND (ID NOT IN (SELECT ID FROM team WHERE LeagueCode = '#request.filter#' AND LEFT(Notes,7) = 'NoScore'))	
		AND (ID NOT IN (SELECT TeamID FROM constitution WHERE LeagueCode = '#request.filter#'))			
</cfquery>