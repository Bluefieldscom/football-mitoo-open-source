<!--- called by Unsched.cfm --->
<cfquery name="QVenueSequence" datasource="#request.DSN#"> 
	SELECT
		ID
	FROM
		constitution 
	WHERE
		TeamID IN (SELECT TeamID FROM constitution WHERE ID=#ThisHomeID#)
		AND OrdinalID IN (SELECT OrdinalID FROM constitution WHERE ID=#ThisHomeID#)
</cfquery>