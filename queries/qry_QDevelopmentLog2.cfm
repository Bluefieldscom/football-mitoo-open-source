<!--- called by BroadcastImportantMessageToAdministrators.cfm --->

<cfquery NAME="QDevelopmentLog2" datasource="zmast">
	SELECT
		DevDate,
		DevText, 
		JABNotes
	FROM 
		developmentlog
	WHERE
		DateDiff(Now(), DevDate) >= 14
	ORDER BY
		DevDate DESC
</cfquery>
