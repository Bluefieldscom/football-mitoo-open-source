<!--- Called by inclLeagueInfo.cfm --->

<CFQUERY NAME="QTeamOrdinal" datasource="#request.DSN#">
	SELECT DISTINCT
		t.ID  as TeamID,
		o.ID as OrdinalID,
		CASE
		WHEN o.LongCol IS NULL THEN t.LongCol
		ELSE CONCAT(t.LongCol, ' ', o.LongCol)
		END
		as TeamOrdinalDescription,
		CASE
		WHEN o.LongCol IS NULL THEN t.LongCol
		ELSE CONCAT(t.LongCol, ' ', o.LongCol)
		END
 		as TeamSortOrder
	FROM
		team t,
		ordinal o,
		pitchavailable pa
	WHERE 
		pa.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND pa.TeamID = t.ID
		AND pa.OrdinalID = o.ID
</CFQUERY>



