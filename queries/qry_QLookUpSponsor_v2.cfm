<!--- called from ToolBar2.cfm --->

<cfquery name="LookUpSponsor" dbtype="query">
	SELECT 
		SponsorsHTML 
	FROM 
		QSponsorInfo 
	WHERE 
		DID = <cfqueryparam value = #DivisionID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
