<!--- called by inclShowJABOnly.cfm --->
<cfquery name="DelOrTypeConstitution" datasource="#request.DSN#">
	DELETE FROM constitution 
	WHERE 
	(constitution.TeamID IN (SELECT ID FROM team WHERE longcol LIKE '% or %'  ))
	AND
	(constitution.ID NOT IN (SELECT HomeID FROM fixture ))
	AND
	(constitution.ID NOT IN (SELECT AwayID FROM fixture ))
</cfquery>
