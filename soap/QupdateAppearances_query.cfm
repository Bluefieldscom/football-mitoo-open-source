<!--- called from the updateTeamListByFixtureID method of webServicesWrite.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cftry>

	<cfset j = ArrayLen(updateAppearanceArray)>
	<cfloop index="i" from="1" to="#j#">

		<cfquery name="QupdateAppearances_query" datasource="#variables.dsn#">
		
		UPDATE 
			appearance
			SET GoalsScored = <cfqueryparam value = #updateAppearanceArray[i].goalsScored# 
				cfsqltype="CF_SQL_INTEGER" maxlength="2">, 
				Card = <cfqueryparam value = #insertAppearanceArray[i].card# 
				cfsqltype="CF_SQL_INTEGER" maxlength="1">, 
				StarPlayer = <cfqueryparam value = #updateAppearanceArray[i].starPlayer# 
				cfsqltype="CF_SQL_INTEGER" maxlength="1">
		WHERE	
			FixtureID 	 	= <cfqueryparam value = #updateAppearanceArray[i].fixtureid# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND HomeAway 	= <cfqueryparam value = '#updateAppearanceArray[i].homeAway#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="1">
			AND PlayerID 	= <cfqueryparam value = #updateAppearanceArray[i].playerid# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND LeagueCode 	= <cfqueryparam value = '#updateAppearanceArray[i].leagueCode#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		</cfquery>
		
	</cfloop>
			
	<cfcatch type="Database">
		<cfif cfcatch.NativeErrorCode IS "1062">
			<!--- duplicate values for FixtureID,PlayerID,HomeAway --->
			<cfmodule template="../dberrorpage.cfm" source="TeamList" errortype="duplicatekey">
			<cfset ws_success=0>
			<cfabort>
		</cfif>
	</cfcatch>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" source="TeamList" errortype="baddata">
		<cfset ws_success=0>
		<cfabort>
	</cfcatch>
</cftry>
