<!--- called by inclShowJABOnly.cfm --->
<cfquery name="QOrTypeConstitution" datasource="#request.DSN#">
	SELECT 
		constitution.leaguecode,
		d.longcol as DivisionName, 
		t.longcol as TeamName, 
		o.longcol as OrdinalName 
	FROM 
		constitution, division d, team t , ordinal o
	WHERE 
	(constitution.TeamID IN (SELECT ID FROM team WHERE longcol LIKE '% or %'  ))
	AND
	(constitution.ID NOT IN (SELECT HomeID FROM fixture ))
	AND
	(constitution.ID NOT IN (SELECT AwayID FROM fixture ))
	AND constitution.DivisionID = d.ID
	AND constitution.TeamID = t.ID
	AND constitution.OrdinalID = o.ID
	ORDER BY
	leaguecode,DivisionName,TeamName,OrdinalName
	
</cfquery>
