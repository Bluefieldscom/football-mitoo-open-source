<!--- called by GatherTeamsUnderClub.cfm --->
<cfquery name="QGetCountyInfo" datasource="zmast">
	SELECT
		ID,
		CountyCode,
		CountyName
	FROM
		countyinfo
	WHERE
		CountyName <> 'TEST'
	ORDER BY
		CountyName
</cfquery>
