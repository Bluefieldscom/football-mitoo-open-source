<!--- called by InclTblChooseTeam.cfm --->

<CFQUERY NAME="GetTeam" datasource="#request.DSN#">
	SELECT	
		ID,
		LongCol as TeamName
	FROM 	
		team
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND	ID NOT IN
			(SELECT ID 
				FROM team as Team 
				WHERE LEFT(Notes,7) = 'NoScore' 
					OR ShortCol = 'GUEST' 
					OR LongCol IS NULL )					
	ORDER BY
		TeamName
</CFQUERY>

