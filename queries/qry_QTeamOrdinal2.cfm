<!--- called by SuspendPlayer.cfm --->
<cfquery name="QTeamOrdinal2" datasource="#request.DSN#">
	SELECT DISTINCT
		t.ID  as TeamID,
		o.ID as OrdinalID,
		CASE
		WHEN o.LongCol IS NULL THEN t.LongCol
		ELSE CONCAT(t.LongCol, ' ', o.LongCol)
		END
		as TeamOrdinalDescription
	FROM
		team t,
		ordinal o,
		constitution c
	WHERE 
		c.Leaguecode=  <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND t.ID NOT IN (SELECT ID FROM team WHERE LeagueCode='#request.filter#' AND LEFT(Notes,7) = 'NoScore' OR ShortCol = 'GUEST') 
		AND t.ID IN (SELECT DISTINCT TeamID FROM register WHERE LeagueCode='#request.filter#' AND PlayerID = #ThisPlayerID#) 
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID
	ORDER BY
		TeamOrdinalDescription
</cfquery>		
