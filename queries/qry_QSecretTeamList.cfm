<!--- called by SecretWordList.cfm --->

<cfquery name="QGetSecretTeamList" datasource="#request.DSN#">
	SELECT ID, LongCol, ShortCol 
	FROM team
	WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND	ID NOT IN
		(SELECT ID 
			FROM team 
			WHERE LEFT(Notes,7) = 'NoScore' 
				OR ShortCol = 'GUEST' 
				OR LongCol IS NULL )					
	ORDER BY
		LongCol
</cfquery>
