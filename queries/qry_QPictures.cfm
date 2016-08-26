<!--- called by DownloadDocuments --->
<cfquery name="QPictures" datasource="zmast">
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
		AND Extension='jpg'
	ORDER BY
		GroupName desc, Description
</cfquery>