<!--- called by LeagueInfoUpdate.cfm --->

<cfquery name="QUpdate" datasource="ZMAST" >
	UPDATE
		leagueinfo
	SET
		DefaultSMSService = 0
	WHERE
		ID = <cfqueryparam value = #Form.ID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
