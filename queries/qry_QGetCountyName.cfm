<!--- called by Counties.cfm --->
<cfquery name="QGetCountyName" datasource="ZMAST" cachedWithin=#CreateTimeSpan(0,1,0,0)#>
	SELECT
		CountyName
	FROM
		countyinfo
	WHERE
		CountyCode = '#request.County#'
</cfquery>
