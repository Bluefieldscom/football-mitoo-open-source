<!--- called by InclTblChooseDivision.cfm --->

<cfquery name="GetDivision3" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol as DivisionName
	FROM 	
		division as Division
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
	ORDER BY
		MediumCol
</cfquery>
