<!--- called by ClubList.cfm and GatherTeamsUnderClub.cfm --->

<!--- TR preferred solution with MySQL: (shorter and faster) --->
<CFQUERY NAME="QClubList" datasource="#request.DSN#">
	SELECT 
		ID,
		LongCol,
		CASE
			WHEN ID IN (SELECT TeamID from constitution where LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">) THEN 'No'
			ELSE 'Yes'
		END
		AS RedundantTeam,
		CASE
			WHEN ShortCol = 'Guest' THEN 'Yes'
			ELSE 'No'
		END
		AS Guest,
		Notes as ClubNotes,
		CASE
			WHEN Notes LIKE '%WEBSITE%' THEN 'Yes'
			ELSE 'No'
		END
		AS HasAWebsite,
		CASE
			WHEN ( Notes LIKE '%STREETMAP%' OR Notes LIKE '%MULTIMAP%' ) THEN 'Yes'
			ELSE 'No'
		END
		AS HasAMap		
	FROM
		team
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID NOT IN
			(SELECT ID 
				FROM team 
				WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND LEFT(Notes,7) = 'NoScore')
	ORDER BY
		Guest, LongCol
</cfquery>
