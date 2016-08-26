<!--- called by TeamHist.cfm --->
<!---
Present the user with a list of ALL the games still to be played for the specified
League and Division and Team. 
This query will only apply for non KO divisions
Don't show games which have already got fixtures or results
see "NOT IN" clause in SQL
--->

<CFQUERY NAME="QUnschedHomeMatches" datasource="#request.DSN#"> 
SELECT
	c1.ID as HomeID,
	c2.ID as AwayID,
	IF(ordinal1.longcol IS NULL, t1.longcol, CONCAT(t1.longcol, ' ', ordinal1.longcol)) as HomeTeam, 
	IF(ordinal2.longcol IS NULL, t2.longcol, CONCAT(t2.longcol, ' ', ordinal2.longcol)) as AwayTeam 
FROM
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS ordinal1,
	ordinal AS ordinal2,
	matchno AS m1,
	matchno AS m2
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c1.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
	AND c2.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND c1.id = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND	t1.ID = c1.TeamID 
	AND ordinal1.id = c1.OrdinalID 
	AND m1.id = c1.ThisMatchNoID 
	AND t2.ID = c2.TeamID 
	AND ordinal2.id = c2.OrdinalID 
	AND m2.id = c2.ThisMatchNoID 
	AND NOT (c1.ID = c2.ID) 
	<cfif PlayOne IS "No" AND PlayThree IS "No" AND PlayFour IS "No">
		AND c1.ID NOT IN (SELECT fx.HomeID FROM fixture fx WHERE fx.HomeID = c1.ID AND fx.AwayID = c2.ID )
	</cfif>
ORDER BY
		HomeTeam,  AwayTeam
</CFQUERY>
