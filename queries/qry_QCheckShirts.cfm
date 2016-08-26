<!--- called from StartingLineUpList.cfm --->
<cfquery NAME="QCheckShirts01" datasource="#request.DSN#">
	SELECT 
		COUNT(DISTINCT(nominalshirtnumber)) as counter,
		COUNT(DISTINCT(actualshirtnumber)) as cntr
	FROM
		shirtnumber s
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">	
		AND s.appearanceid IN (SELECT id FROM appearance WHERE fixtureid=#FID# AND homeaway='#HA#')
</cfquery>

<cfquery NAME="QCheckShirts02" datasource="#request.DSN#">
	SELECT 
		COUNT(id) as counter
	FROM
		shirtnumber s
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">	
		AND s.appearanceid IN (SELECT id FROM appearance WHERE fixtureid=#FID# AND homeaway='#HA#')
</cfquery>
<cfquery NAME="QCheckShirts03" datasource="#request.DSN#">
	SELECT 
		nominalshirtnumber
	FROM
		shirtnumber s
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">	
		AND s.appearanceid IN (SELECT id FROM appearance WHERE fixtureid=#FID# AND homeaway='#HA#' AND Activity=1)
	ORDER BY
		nominalshirtnumber
</cfquery>
<cfquery NAME="QCheckShirts04" datasource="#request.DSN#">
	SELECT 
		COUNT(DISTINCT(nominalshirtnumber)) as counter
	FROM
		shirtnumber s
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">	
		AND s.appearanceid IN (SELECT id FROM appearance WHERE fixtureid=#FID# AND homeaway='#HA#' AND Activity>1)
</cfquery>

<cfquery NAME="QCheckShirts05" datasource="#request.DSN#">
	SELECT 
		COUNT(id) as counter
	FROM
		shirtnumber s
	WHERE
		s.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">	
		AND s.appearanceid IN (SELECT id FROM appearance WHERE fixtureid=#FID# AND homeaway='#HA#' AND Activity>1)
</cfquery>
