<cfquery name="QValidFID" datasource="#request.DSN#" >
	SELECT
		c1.TeamID as HomeID,
		c2.TeamID as AwayID,
		f.HomeTeamSheetOK,
		f.AwayTeamSheetOK
	FROM 
		fixture f,
		constitution c1,
		constitution c2
	WHERE 
		f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND c1.ID = f.HomeID
		AND c2.ID = f.AwayID
</cfquery>
