<!---
called by InclCheckNoScore.cfm
called by UpdateForm.cfm
 --->
<!--- gets the Home & Away team names and first seven bytes of Notes to see if it is a "Winners of...." team --->

<CFQUERY NAME="QHomevAway" datasource="#request.DSN#">
SELECT
	t1.LongCol as HomeTeam    ,
	o1.LongCol as HomeOrdinal ,
	t2.LongCol as AwayTeam    ,
	o2.LongCol as AwayOrdinal ,
	LEFT(t1.Notes,7) as HomeNoScore ,
	LEFT(t2.Notes,7) as AwayNoScore
FROM
	constitution AS c1,
	team AS t1,
	ordinal AS o1,
	constitution AS c2,
	team AS t2,
	ordinal AS o2
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c1.ID = <cfqueryparam value = #HomeID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
	AND c2.ID = <cfqueryparam value = #AwayID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
	AND c1.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND c2.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND t1.id = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.id = c2.TeamID 
	AND o2.id = c2.OrdinalID
</CFQUERY>

