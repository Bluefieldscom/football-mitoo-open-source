<!--- Called by LUList.cfm --->

<CFQUERY NAME="TeamList" datasource="#request.DSN#">
	SELECT 
		ID,
		LongCol,
		MediumCol,
		ShortCol,
		Notes,
		EmailAddress1,
		EmailAddress2,
		FACharterStandardType,
		ParentCountyFA,
		AffiliationNo
	FROM
		team
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol IS NOT NULL 
		AND ID NOT IN
			(SELECT ID 
				FROM team 
				WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND LEFT(Notes,7) = 'NoScore')
	ORDER BY
		 LongCol
</CFQUERY>
