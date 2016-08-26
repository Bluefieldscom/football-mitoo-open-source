<!--- called by MtchDay --->

<cfquery name="LookUpSponsor" dbtype="query" >
	SELECT 
		SponsorsHTML 
	FROM 
		QSponsorInfo
	WHERE 
		DID = <cfqueryparam value = #DID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>