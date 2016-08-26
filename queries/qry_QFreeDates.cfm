<!--- called by FreeDates.cfm --->
<cfquery name="QFreeDates" datasource="#request.DSN#">

SELECT
	CASE
		WHEN o.longcol IS NULL THEN t.longcol
		ELSE CONCAT(t.longcol, ' ', o.longcol)
	END
		as TeamName,
		tfd.FreeDate 
	FROM
		teamfreedate tfd, team t, ordinal o
	WHERE
		tfd.LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND tfd.TeamID=t.ID
		AND tfd.OrdinalID=o.ID
	ORDER BY 
		TeamName,tfd.FreeDate;
		
</cfquery>
