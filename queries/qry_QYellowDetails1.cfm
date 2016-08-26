<!--- called by ExportYellowXLS.cfm --->

<cfquery name="QYellowDetails1" datasource="#request.DSN#">	
	SELECT 
		li.namesort,
		t.leaguecode,
		CASE
			WHEN o.longcol IS NULL THEN t.longcol
			ELSE CONCAT(t.longcol, ' ', o.longcol)
			END
			as TeamName,
		td.Contact1Name, 
		td.Contact1JobDescr, 
		td.Contact1Email1, 
		td.Contact1Email2, 
		td.Contact2Name, 
		td.Contact2JobDescr, 
		td.Contact2Email1, 
		td.Contact2Email2, 
		td.Contact3Name, 
		td.Contact3JobDescr, 
		td.Contact3Email1, 
		td.Contact3Email2
	FROM 
		teamdetails td, 
		team t,
		ordinal o,
		zmast.leagueinfo li
	WHERE
		td.TeamID = t.ID
		AND td.OrdinalID = o.ID
		AND li.leaguecodeprefix = t.leaguecode
		AND li.leaguecodeyear = '#right(request.dsn,4)#'
<!--- HAVING		
		 TeamName not like '%WITHDRAWN%' --->
	ORDER BY
		li.namesort,t.longcol,o.longcol
</cfquery>
