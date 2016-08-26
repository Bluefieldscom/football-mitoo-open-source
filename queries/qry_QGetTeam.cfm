<!--- called by InclRegist01.cfm --->

<cfquery name="GetTeam" datasource="#request.DSN#">
		SELECT
			ID,
			LongCol
		FROM
			team
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
			AND ID NOT IN
				(SELECT ID 
				FROM team 
				WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' 
									cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
					AND (LEFT(Notes,7) = 'NoScore' OR ShortCol = 'GUEST' ))
		ORDER BY
			LongCol
</cfquery>
