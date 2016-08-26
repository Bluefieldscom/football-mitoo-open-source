<!--- called by InclSpecifyWinner.cfm --->

<cfquery name="QGetBlank" datasource="#request.DSN#">
	SELECT
		ID    <!--- Get the id of the blank Match Number --->
	FROM
		matchno
	WHERE
		LongCol IS NULL
	LIMIT 1
</cfquery>
