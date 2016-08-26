<!--- called from the updateTeamListByFixtureID method of webServicesWrite.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cftry>

	<cfset j = ArrayLen(insertAppearanceArray)>
	<cfquery name="QinsertAppearances_query" datasource="#variables.dsn#">
	
		INSERT INTO
			appearance
			(FixtureID, HomeAway, PlayerID,	GoalsScored, Card, StarPlayer, LeagueCode)
		VALUES
			<cfloop index="i" from="1" to="#j#">
				(
				<cfqueryparam value = #insertAppearanceArray[i].fixtureid# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">,
				<cfqueryparam value = '#insertAppearanceArray[i].homeAway#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="1">,
				<cfqueryparam value = #insertAppearanceArray[i].playerid# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">,
				<cfqueryparam value = #insertAppearanceArray[i].goalsScored# 
					cfsqltype="CF_SQL_INTEGER" maxlength="2">,
				<cfqueryparam value = #insertAppearanceArray[i].card# 
					cfsqltype="CF_SQL_INTEGER" maxlength="1">,
				<cfqueryparam value = #insertAppearanceArray[i].starPlayer# 
					cfsqltype="CF_SQL_INTEGER" maxlength="1">,
				<cfqueryparam value = '#insertAppearanceArray[i].leagueCode#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				)
				<cfif j GT 1 AND i LT j>
					,
				</cfif>
			</cfloop>
			
	</cfquery>
	
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
