<!--- called by Unsched.cfm --->

<cfquery name="QFreeToday" datasource="#request.DSN#">
	SELECT
		CONCAT(cast(TeamID as char), cast(OrdinalID as char)) as FreeToday
	FROM
		teamfreedate
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND FreeDate='#DateFormat(request.CurrentDate,'YYYY-MM-DD')#'
</cfquery>
