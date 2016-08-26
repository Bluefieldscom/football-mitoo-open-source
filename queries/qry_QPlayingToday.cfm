<!--- called by Unsched.cfm --->


<cfquery name="QPlayingToday" datasource="#request.DSN#">
	SELECT
		c.TeamID    as TeamID,
		c.OrdinalID as OrdinalID,
		CONCAT(cast(c.TeamID as char), cast(c.OrdinalID as char)) as PlayingToday,
		t.LongCol   as TeamName,
		o.LongCol   as OrdinalName
	FROM
		fixture f,
		constitution c,
		team t,
		ordinal o
	WHERE 
		f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.FixtureDate=#CreateODBCDate(request.CurrentDate)#
		AND f.HomeID = c.id 
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID
	UNION
	select
		c.TeamID    as TeamID,
		c.OrdinalID as OrdinalID,
		CONCAT(cast(c.TeamID as char), cast(c.OrdinalID as char)) as PlayingToday,
		t.LongCol   as TeamName,
		o.LongCol   as OrdinalName
	FROM
		fixture f,
		constitution c,
		team t,
		ordinal o
	WHERE 
		f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.FixtureDate=#CreateODBCDate(request.CurrentDate)#
		AND f.AwayID = c.id 
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID;
</cfquery>
<!---
<cfquery name="QPlayingToday" datasource="#request.DSN#">
	SELECT
		c.TeamID    as TeamID,
		c.OrdinalID as OrdinalID,
		CONCAT(cast(c.TeamID as char), cast(c.OrdinalID as char)) as PlayingToday,
		t.LongCol   as TeamName,
		o.LongCol   as OrdinalName
	FROM
		fixture f,
		constitution c,
		team t,
		ordinal o
	WHERE 
		f.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND f.FixtureDate=#CreateODBCDate(request.CurrentDate)#
		AND (f.HomeID = c.id OR f.AwayID = c.id)
		AND c.TeamID = t.ID
		AND c.OrdinalID = o.ID;
</cfquery>
--->