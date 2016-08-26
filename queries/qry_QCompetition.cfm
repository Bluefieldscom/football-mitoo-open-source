<!--- Called by inclLeagueInfo.cfm --->

<CFQUERY NAME="QCompetition" datasource="#request.DSN#">
	SELECT 
		ID        as CompetitionID,
		LongCol    as CompetitionDescription,
		MediumCol  as CompetitionSortOrder,
		ShortCol   as CompetitionCode,
		Notes     as CompetitionNotes
	FROM
		division
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</CFQUERY>
