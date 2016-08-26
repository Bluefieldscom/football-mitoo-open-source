<!--- called from getCounties method of webServices.cfc --->

<cfquery name="QCounty" datasource="zmast">
SELECT
	countycode,
	countyname 
FROM 
	countyinfo
ORDER BY
	countyname
</cfquery>