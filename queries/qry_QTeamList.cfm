<!--- called from ResultsGrid.cfm --->

<CFQUERY NAME="QTeamList" datasource="#request.DSN#">
SELECT
	t.LongCol as TeamName,
	t.MediumCol as TeamNameMedium,
	o.LongCol as OrdinalName,
	o.ShortCol as OrdinalNameShort,
	c.TeamID as TeamID,
	c.OrdinalID as OrdinalID,
	c.ID as CID
FROM
	team AS t,
	ordinal AS o ,
	constitution AS c 
WHERE
	c.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c.DivisionID = <cfqueryparam value = #DivisionID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND c.TeamID = t.ID 
	AND c.OrdinalID = o.ID
ORDER BY
	TeamName, OrdinalName <!--- t.LongCol, o.LongCol --->
</CFQUERY>
