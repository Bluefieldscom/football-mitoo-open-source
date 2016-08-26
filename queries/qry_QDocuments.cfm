<!--- called by DownloadDocuments --->
<cfquery name="QDocuments" datasource="zmast">
	SELECT
		LeagueCodePrefix,
		Description,
		FileName,
		Extension,
		GroupName
	FROM
		leaguedocs
	WHERE
		leaguecodeprefix = '#LeagueCodePrefix#'
	ORDER BY
		GroupName desc, Description
</cfquery>