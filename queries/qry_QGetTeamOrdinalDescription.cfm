<!--- called from Toolbar2.cfm --->

<cfquery name="GetTeamOrdinalDescription" dbtype="query">
	SELECT 
		TeamOrdinalDescription 
	FROM 
		QTeamOrdinal
	WHERE 
		TeamID = #ThisTeamID#
		AND OrdinalID = #ThisOrdinalID#
		
</cfquery>

