<!--- called by AppearanceAnalysis.cfm --->

<cfquery name="QAppAnalysis" datasource="#request.DSN#" >
	SELECT
		t.LongCol as TName,
		c.ID as ConstitID ,
		d.ShortCol as CompetitionCode ,
		o.LongCol as OrdinalName ,
		o.ID as OrdinalID
	FROM
		constitution AS c ,
		team AS t ,
		ordinal AS o ,
		division AS d 
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c.TeamID = <cfqueryparam value = #URL.TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND d.ID NOT IN 
			(SELECT ID 
				FROM division 
					WHERE 
						LeagueCode = <cfqueryparam value = '#request.filter#' 
										cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND Notes LIKE '%EXTERNAL%') 
		AND d.ID = c.DivisionID 
		AND o.ID = c.OrdinalID  
		AND	t.ID = c.TeamID   
	ORDER BY
		OrdinalName, d.MediumCol <!--- o.LongCol, d.Mediumcol --->
</cfquery>

