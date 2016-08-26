<!--- called by RCLogReport.cfm --->
<cfquery name="QRCLogReportRefsName" datasource="#request.DSN#" >
	SELECT
		Concat(Forename," ",Surname) as OutputText 
	FROM 
		referee
	WHERE 
		ID = #RID#
</cfquery>

